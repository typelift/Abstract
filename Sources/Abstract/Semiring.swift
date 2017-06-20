/*:
# Semiring

A Semiring is an algebraic structure consisting of a type with 2 composition operations like the one from Magma, called "Addition" and "Multiplication". They refer to two distinct algebraic strutures, the first (we can call it `Additive`) being a Commutative Monoid, and the second (we can call it `Multiplicative`) being a Monoid.

We can define a Semiring as a protocol with 2 associated types, each conforming to the required protocol, and two operations, each referring to the underlying representing type. Let's use the `<>+` operator for `Additive` and the `<>*` operator for `Multiplicative`. Let's also call `zero` the `empty` distinguished element for `Additive`, and `one` the `empty` distinguished element for `Multiplicative`.

In addition to the basic requirements for the underlying types (Commutative Monoid and Monoid), there are 2 more laws that must hold:

- multiplication must "distribute" over addition, both left and right:
	- a <>* (b <>+ c) = (a <>* b) <>+ (a <>* c)
	- (b <>+ c) <>* a = (b <>* a) <>+ (c <>* a)
- the `zero` element must "annihilate" an instance if applied with the multiplication operation, both left and right:
	- zero <>* a = a <>* zero = zero
*/

import Operadics

infix operator <>+ : AdditionPrecedence
infix operator <>* : MultiplicationPrecedence

public protocol Semiring {
	associatedtype Additive: CommutativeMonoid
	associatedtype Multiplicative: Monoid

	static func <>+(left: Self, right: Self) -> Self
	static func <>*(left: Self, right: Self) -> Self

	static var zero: Self { get }
	static var one: Self { get }
}

extension Law where Element: Semiring {
	public static func multiplicationIsDistributiveOverAddition(_ a: Element, _ b: Element, _ c: Element) -> Bool {
		return (a <>* (b <>+ c) == (a <>* b) <>+ (a <>* c))
			&& ((b <>+ c) <>* a == (b <>* a) <>+ (c <>* a))
	}

	public static func zeroAnnihiliatesTheMultiplicative(_ a: Element) -> Bool {
		return (.zero <>* a == .zero)
			&& (a <>* .zero == .zero)
	}
}

extension LawInContext where Element: Semiring {
	public static func multiplicationIsDistributiveOverAddition(_ a: Element, _ b: Element, _ c: Element) -> (Element.Context) -> Bool {
		return  { (a <>* (b <>+ c) == (a <>* b) <>+ (a <>* c))($0)
			   && ((b <>+ c) <>* a == (b <>* a) <>+ (c <>* a))($0) }
	}

	public static func zeroAnnihiliatesTheMultiplicative(_ a: Element) -> (Element.Context) -> Bool {
		return { (.zero <>* a == .zero)($0)
			  && (a <>* .zero == .zero)($0) }
	}
}

/*:
Interestingly, if for type `A` both `Additive` and `Multiplicative` are `Wrapper` and the `Wrapped` type is `A` itself, we can derive the implementation of all the functions:
*/

extension Semiring where Additive: Wrapper, Additive.Wrapped == Self {
	public static func <>+(left: Self, right: Self) -> Self {
		return (Additive(left) <> Additive(right)).unwrap
	}

	public static var zero: Self {
		return Additive.empty.unwrap
	}
}

extension Semiring where Multiplicative: Wrapper, Multiplicative.Wrapped == Self {
	public static func <>*(left: Self, right: Self) -> Self {
		return (Multiplicative(left) <> Multiplicative(right)).unwrap
	}

	public static var one: Self {
		return Multiplicative.empty.unwrap
	}
}

/*:
Now we can define some semirings just by defining the associated types:
*/

extension Bool: Semiring {
	public typealias Additive = And
	public typealias Multiplicative = Or
}

//: ------

public struct FunctionSR<A,SR: Semiring & Equatable>: Wrapper, Semiring, EquatableInContext where SR.Additive: Equatable, SR.Multiplicative: Equatable {
	public typealias Wrapped = (A) -> SR
	public typealias Additive = FunctionCM<A,SR.Additive>
	public typealias Multiplicative = FunctionM<A,SR.Multiplicative>
	public typealias Context = A

	public let unwrap: (A) -> SR

	public init(_ value: @escaping (A) -> SR) {
		self.unwrap = value
	}

	public var call: (A) -> SR {
		return unwrap
	}

	public static func <>+ (left: FunctionSR, right: FunctionSR) -> FunctionSR {
		return .init { left.call($0) <>+ right.call($0) }
	}

	public static func <>* (left: FunctionSR, right: FunctionSR) -> FunctionSR {
		return .init { left.call($0) <>* right.call($0) }
	}

	public static var zero: FunctionSR<A, SR> {
		return .init { _ in SR.zero }
	}

	public static var one: FunctionSR<A, SR> {
		return .init { _ in SR.one }
	}

	public static func == (left: FunctionSR, right: FunctionSR) -> (A) -> Bool {
		return { left.call($0) == right.call($0) }
	}
}

//:------

/*:
A Tropical semiring is just a fancy name for a (min, +)-semiring. This semiring is called tropical to honor the Brazillian mathematician, Imre Simon, who founded tropical mathematics.
 */

public struct Tropical<A: ComparableToTop & Summable & Equatable>: Wrapper, Semiring, Equatable {
    public typealias Wrapped = A
    public typealias Additive = Min<A>
    public typealias Multiplicative = Add<A>
    
    public let unwrap: A
    
    public init(_ value: A) {
        self.unwrap = value
    }
    
    public static func <>+(left: Tropical, right: Tropical) -> Tropical {
        return Tropical(
            (Additive(left.unwrap) <> Additive(right.unwrap)).unwrap
        )
    }
    
    public static func <>*(left: Tropical, right: Tropical) -> Tropical {
        return Tropical(
            (Multiplicative(left.unwrap) <> Multiplicative(right.unwrap)).unwrap
        )
    }

    public static var zero: Tropical {
        return Tropical(Additive.empty.unwrap)
    }
    
    public static var one: Tropical {
        return Tropical(Multiplicative.empty.unwrap)
    }
    
    public static func == (left: Tropical, right: Tropical) -> Bool {
        return left.unwrap == right.unwrap
    }
}
