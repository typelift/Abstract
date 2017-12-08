/*:
# Monoid

A Monoid is a Semigroup with a distinct element that acts as "empty" in respect to the operation.

The empty element (let's called it `e`) has to be neutral to the operation both from left and from right, thus:

a <> e = e <> a = a
*/

#if SWIFT_PACKAGE
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

extension String: Monoid {
	public static let empty: String = ""

	public static func <> (left: String, right: String) -> String {
		return left + right
	}
}

//: ------

// sourcery: fixedTypesForPropertyBasedTests = "TestStructure"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "Equatable"
public struct ArrayEq<T>: Wrapper, Monoid, Equatable where T: Equatable {
	public typealias WrappedType = [T]

	public let unwrap: [T]
	public init(_ value: [T]) {
		self.unwrap = value
	}

	public static var empty: ArrayEq<T> {
		return .init([])
	}

	public static func <> (left: ArrayEq, right: ArrayEq) -> ArrayEq {
		return ArrayEq.init(left.unwrap + right.unwrap)
	}
}

//: ------

// sourcery: fixedTypesForPropertyBasedTests = "TestFunction"
// sourcery: requiredContextForPropertyBasedTests = "String"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "EquatableInContext"
public struct ArrayEqF<T>: Wrapper, Monoid, EquatableInContext where T: EquatableInContext {
	public typealias WrappedType = [T]
	public typealias Context = T.Context

	public let unwrap: [T]
	public init(_ value: [T]) {
		self.unwrap = value
	}

	public static var empty: ArrayEqF<T> {
		return .init([])
	}

	public static func <> (left: ArrayEqF, right: ArrayEqF) -> ArrayEqF {
		return ArrayEqF.init(left.unwrap + right.unwrap)
	}
}

//: ------

// sourcery: fixedTypesForPropertyBasedTests = "TestStructure"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "Equatable"
public struct OptionalEq<T>: Wrapper, Monoid, Equatable where T: Equatable {
	public typealias WrappedType = Optional<T>

	public let unwrap: Optional<T>
	public init(_ value: Optional<T>) {
		self.unwrap = value
	}

	public static var empty: OptionalEq {
		return .init(.none)
	}

	public static func <> (left: OptionalEq, right: OptionalEq) -> OptionalEq {
		return .init(left.unwrap ?? right.unwrap)
	}
}

//: ------

// sourcery: fixedTypesForPropertyBasedTests = "TestFunction"
// sourcery: requiredContextForPropertyBasedTests = "String"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "EquatableInContext"
public struct OptionalEqF<T>: Wrapper, Monoid, EquatableInContext where T: EquatableInContext {
	public typealias WrappedType = Optional<T>
	public typealias Context = T.Context

	public let unwrap: Optional<T>
	public init(_ value: Optional<T>) {
		self.unwrap = value
	}

	public static var empty: OptionalEqF {
		return .init(.none)
	}

	public static func <> (left: OptionalEqF, right: OptionalEqF) -> OptionalEqF {
		return .init(left.unwrap ?? right.unwrap)
	}
}

//: ------

// sourcery: fixedTypesForPropertyBasedTests = "TestStructure"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "Semigroup & Equatable"
public struct OptionalM<T>: Monoid, Wrapper, Equatable where T: Semigroup & Equatable {
	public typealias WrappedType = T?

	public let unwrap: T?
	public init(_ value: T?) {
		self.unwrap = value
	}

	public static var empty: OptionalM<T> {
		return .init(nil)
	}

	public static func <> (_ left: OptionalM, _ right: OptionalM) -> OptionalM {
		switch (left.unwrap,right.unwrap) {
		case (.some(let leftValue),.some(let rightValue)):
			return .init(leftValue <> rightValue)
		case (.some,_):
			return left
		case (_,.some):
			return right
		default:
			return .init(nil)
		}
	}
}

//: ------

// sourcery: fixedTypesForPropertyBasedTests = "TestFunction"
// sourcery: requiredContextForPropertyBasedTests = "String"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "Semigroup & EquatableInContext"
public struct OptionalMF<T>: Monoid, Wrapper, EquatableInContext where T: Semigroup & EquatableInContext {
	public typealias WrappedType = T?
	public typealias Context = T.Context

	public let unwrap: T?
	public init(_ value: T?) {
		self.unwrap = value
	}

	public static var empty: OptionalMF<T> {
		return .init(nil)
	}

	public static func <> (_ left: OptionalMF, _ right: OptionalMF) -> OptionalMF {
		switch (left.unwrap,right.unwrap) {
		case (.some(let leftValue),.some(let rightValue)):
			return .init(leftValue <> rightValue)
		case (.some,_):
			return left
		case (_,.some):
			return right
		default:
			return .init(nil)
		}
	}
}

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
public struct FirstM<A>: Wrapper, Monoid, Equatable where A: Monoid & Equatable {
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
