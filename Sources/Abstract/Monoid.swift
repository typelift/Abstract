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

/*:
`FirstM` and `LastM` work like the pretty self-explanatory `First` and `Last` except that the `.empty` value is always discarded: `FirstM.empty <> _` will return the second value, and `_ <> LastM.empty` will return the first value.
*/

// sourcery: fixedTypesForPropertyBasedTests = "TestStructure"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "Monoid & Equatable"
public struct FirstM<A: Monoid & Equatable>: Wrapper, Monoid, Equatable {
	public typealias WrappedType = A

	public let unwrap: A

	public init(_ value: A) {
		self.unwrap = value
	}

	public static func <> (left: FirstM, right: FirstM) -> FirstM {
		switch (left,right) {
		case (FirstM.empty,FirstM.empty):
			return left
		case (FirstM.empty,_):
			return right
		default:
			return left
		}
	}
}

//: ------

// sourcery: fixedTypesForPropertyBasedTests = "TestStructure"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "Monoid & Equatable"
public struct LastM<A: Monoid & Equatable>: Wrapper, Monoid, Equatable {
	public typealias WrappedType = A

	public let unwrap: A

	public init(_ value: A) {
		self.unwrap = value
	}

	public static func <> (left: LastM, right: LastM) -> LastM {
		switch (left,right) {
		case (LastM.empty,LastM.empty):
			return right
		case (_,LastM.empty):
			return left
		default:
			return right
		}
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
// sourcery: arbitraryFunction
// sourcery: arbitraryGenericParameterProtocols = "Monoid & Equatable"
public struct FunctionM<A, M: Monoid & Equatable>: Wrapper,  Monoid, EquatableInContext {
	public typealias WrappedType = (A) -> M
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
