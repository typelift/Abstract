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
	public static func neutralityToEmpty(_ a: Element) -> Bool {
		return (a <> Element.e) == a && (Element.e <> a) == a
	}
}

extension LawInContext where Element: Monoid {
	public static func neutralityToEmpty(_ a: Element) -> (Element.Context) -> Bool {
		return { context in ((a <> Element.e) == a)(context) && ((Element.e <> a) == a)(context) }
	}
}

/*:
# Types

The defined Monoids will be mostly extensions of the already defined Semigroups, by adding the empty element. `FunctionM` is the monoidal version of `FunctionS`.

Each type again is tested for the new laws in `AbstractTests.swift`.
*/

//: ------

extension Add: Monoid {
	public static var e: Add<T> {
		return Add.init(T.zero)
	}
}

//: ------

extension Multiply: Monoid {
	public static var e: Multiply<T> {
		return Multiply.init(T.one)
	}
}

//: ------

extension Max: Monoid {
	public static var e: Max<T> {
		return Max(T.min)
	}
}

//: ------

extension Min: Monoid {
	public static var e: Min<T> {
		return Min(T.max)
	}
}

//: ------

extension FunctionI: Monoid {
	public static var e: FunctionI<T> {
		return FunctionI<T> { $0 }
	}
}

//: ------

public struct FunctionM<T, M: Monoid & Equatable>: Monoid, EquatableInContext {
	public typealias Context = T
	
	public let call: (T) -> M
	
	public init(_ call: @escaping (T) -> M) {
		self.call = call
	}
	
	public static func <> (left: FunctionM, right: FunctionM) -> FunctionM {
		return FunctionM.init { left.call($0) <> right.call($0) }
	}
	
	public static var e: FunctionM<T, M> {
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
