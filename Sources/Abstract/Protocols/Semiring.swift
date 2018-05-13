/*:
# Semiring

A Semiring is an algebraic structure consisting of a type with 2 composition operations like the one from Magma, called "Addition" and "Multiplication". They refer to two distinct algebraic strutures, the first (we can call it `Additive`) being a Commutative Monoid, and the second (we can call it `Multiplicative`) being a Monoid. Semiring "merges" the two structures into one.

Each operation must follow the respective laws in respect to its `empty` value. In addition, 2 more laws that must hold:

- multiplication must "distribute" over addition, both lhs and rhs:
	- a <>* (b <>+ c) = (a <>* b) <>+ (a <>* c)
	- (b <>+ c) <>* a = (b <>* a) <>+ (c <>* a)
- the `zero` element must "annihilate" an instance if applied with the multiplication operation, both lhs and rhs:
	- zero <>* a = a <>* zero = zero
*/

#if SWIFT_PACKAGE
    import Operadics
#endif

infix operator <>+ : AdditionPrecedence
infix operator <>* : MultiplicationPrecedence

public protocol Semiring {
	static func <>+(lhs: Self, rhs: Self) -> Self
	static func <>*(lhs: Self, rhs: Self) -> Self

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
		return {
			let x1 = (a <>* (b <>+ c) == (a <>* b) <>+ (a <>* c))($0)
			let x2 = ((b <>+ c) <>* a == (b <>* a) <>+ (c <>* a))($0)
			return x1 && x2
		}
	}

	public static func zeroAnnihiliatesTheMultiplicative(_ a: Element) -> (Element.Context) -> Bool {
		return { (.zero <>* a == .zero)($0)
			  && (a <>* .zero == .zero)($0) }
	}
}

/*:
## AutoSemiring_

`AutoSemiring_` protocols are convience protocols that, other than declaring conformance to `Semiring`, adds 2 associated types, one for `Additive` and one for `Multiplicative`. This is beacuse we can derive the implementation of `Semiring` methods if we can make assertions on the underlying types involved.
 */

/*:
## AutoSemiringWrapped

If for type `A` both `Additive` and `Multiplicative` are `Wrapper`, and the `WrappedType` type is `A` itself, we can derive the implementation of all the functions like the following:
*/

public protocol AutoSemiringWrapped: Semiring {
	associatedtype Additive: CommutativeMonoid & Wrapper where Additive.WrappedType == Self
	associatedtype Multiplicative: Monoid & Wrapper where Multiplicative.WrappedType == Self
}

extension AutoSemiringWrapped {
	public static func <>+(lhs: Self, rhs: Self) -> Self {
		return (Additive.init(lhs) <> Additive.init(rhs)).unwrap
	}

	public static var zero: Self {
		return Additive.empty.unwrap
	}

	public static func <>*(lhs: Self, rhs: Self) -> Self {
		return (Multiplicative.init(lhs) <> Multiplicative.init(rhs)).unwrap
	}

	public static var one: Self {
		return Multiplicative.empty.unwrap
	}
}

/*:
## AutoSemiringWrapper

If instead the semiring is a wrapper of `A`, and both `Additive` and `Multiplicative` are wrappers of `A`, we can still derive a generic implementation for the functions:
*/

public protocol AutoSemiringWrapper: Semiring, Wrapper {
	associatedtype Additive: CommutativeMonoid & Wrapper where Additive.WrappedType == Self.WrappedType
	associatedtype Multiplicative: Monoid & Wrapper where Multiplicative.WrappedType == Self.WrappedType
}

extension AutoSemiringWrapper {
	public static func <>+(lhs: Self, rhs: Self) -> Self {
		return Self.init((Additive.init(lhs.unwrap) <> Additive.init(rhs.unwrap)).unwrap)
	}

	public static var zero: Self {
		return Self.init(Additive.empty.unwrap)
	}

	public static func <>*(lhs: Self, rhs: Self) -> Self {
		return Self.init((Multiplicative.init(lhs.unwrap) <> Multiplicative.init(rhs.unwrap)).unwrap)
	}

	public static var one: Self {
		return Self.init(Multiplicative.empty.unwrap)
	}
}

/*:
Now we can define some semirings just by defining the associated types.
*/
