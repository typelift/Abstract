/*:
# Monoid

A Monoid is a Semigroup with a distinct element that acts as "empty" in respect to the operation.

The empty element (let's called it `e`) has to be neutral to the operation both from left and from right, thus:

a <> e = e <> a = a
*/

#if !XCODE_BUILD
    import Operadics
#endif

public protocol Monoid: Semigroup {
	static var empty: Self { get }
}

extension Law where Element: Monoid {
	public static func isNeutralToEmpty(_ a: Element) -> Bool {
		return (a <> .empty) == a && (.empty <> a) == a
	}
}

extension LawInContext where Element: Monoid {
	public static func isNeutralToEmpty(_ a: Element) -> (Element.Context) -> Bool {
		return { ((a <> .empty) == a)($0) && ((.empty <> a) == a)($0) }
	}
}

/*:
## Types

The defined Monoids will be mostly extensions of the already defined Semigroups, by adding the empty element. `FunctionM` is the monoidal version of `FunctionS`.

Each type again is tested for the new laws in `AbstractTests.swift`.
*/

//: ------

extension Add: Monoid {
	public static var empty: Add<A> {
		return Add.init(A.zero)
	}
}

//: ------

extension Multiply: Monoid {
	public static var empty: Multiply<A> {
		return Multiply.init(A.one)
	}
}

//: ------

extension Max: Monoid {
	public static var empty: Max<A> {
		return Max(A.min)
	}
}

//: ------

extension Min: Monoid {
	public static var empty: Min<A> {
		return Min(A.max)
	}
}

//: ------

extension And: Monoid {
	public static var empty: And {
		return true
	}
}

//: ------

extension Or: Monoid {
	public static var empty: Or {
		return false
	}
}

//: ------

extension Endofunction: Monoid {
	public static var empty: Endofunction<A> {
		return Endofunction<A> { $0 }
	}
}

//: ------

// sourcery: fixedTypesForPropertyBasedTests = "Int,TestStructure"
// sourcery: requiredContextForPropertyBasedTests = "Int"
public struct FunctionM<A, M: Monoid & Equatable>: Wrapper,  Monoid, EquatableInContext {
	public typealias Wrapped = (A) -> M
	public typealias Context = A

	public let unwrap: (A) -> M
	
	public init(_ value: @escaping (A) -> M) {
		self.unwrap = value
	}

	public var call: (A) -> M {
		return unwrap
	}

	public static func <> (left: FunctionM, right: FunctionM) -> FunctionM {
		return FunctionM.init { left.call($0) <> right.call($0) }
	}
	
	public static var empty: FunctionM<A, M> {
		return FunctionM { _ in M.empty }
	}
	
	public static func == (left: FunctionM, right: FunctionM) -> (Context) -> Bool {
		return { context in left.call(context) == right.call(context) }
	}
}

//: ------

extension Ordering: Monoid {
	public static var empty: Ordering {
		return .equalTo
	}
}
