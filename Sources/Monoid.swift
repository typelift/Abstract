/*:
# Monoid

A Monoid is a Semigroup with a distinct element that acts as "empty" in respect to the operation.

The empty element (let's called it `e`) has to be neutral to the operation both from left and from right, thus:

a <> e = e <> a = a
*/

public protocol Monoid: Semigroup {
	static var e: Self { get }
}

extension Law where Element: Monoid {
	public static func isNeutralToEmpty(_ a: Element) -> Bool {
		return (a <> Element.e) == a && (Element.e <> a) == a
	}
}

extension LawInContext where Element: Monoid {
	public static func isNeutralToEmpty(_ a: Element) -> (Element.Context) -> Bool {
		return { context in ((a <> Element.e) == a)(context) && ((Element.e <> a) == a)(context) }
	}
}

/*:
## Types

The defined Monoids will be mostly extensions of the already defined Semigroups, by adding the empty element. `FunctionM` is the monoidal version of `FunctionS`.

Each type again is tested for the new laws in `AbstractTests.swift`.
*/

//: ------

extension Add: Monoid {
	public static var e: Add<A> {
		return Add.init(A.zero)
	}
}

//: ------

extension Multiply: Monoid {
	public static var e: Multiply<A> {
		return Multiply.init(A.one)
	}
}

//: ------

extension Max: Monoid {
	public static var e: Max<A> {
		return Max(A.min)
	}
}

//: ------

extension Min: Monoid {
	public static var e: Min<A> {
		return Min(A.max)
	}
}

//: ------

extension Bool: Monoid {
	public static let e = true
	
	public static func <> (left: Bool, right: Bool) -> Bool {
		return left && right
	}
}

//: ------

extension FunctionI: Monoid {
	public static var e: FunctionI<A> {
		return FunctionI<A> { $0 }
	}
}

//: ------

public struct FunctionM<A, M: Monoid & Equatable>: Monoid, EquatableInContext {
	public typealias Context = A
	
	public let call: (A) -> M
	
	public init(_ call: @escaping (A) -> M) {
		self.call = call
	}
	
	public static func <> (left: FunctionM, right: FunctionM) -> FunctionM {
		return FunctionM.init { left.call($0) <> right.call($0) }
	}
	
	public static var e: FunctionM<A, M> {
		return FunctionM { _ in M.e }
	}
	
	public static func == (left: FunctionM, right: FunctionM) -> (Context) -> Bool {
		return { context in left.call(context) == right.call(context) }
	}
}

//: ------

extension Ordering: Monoid {
	public static var e: Ordering {
		return .equalTo
	}
}
