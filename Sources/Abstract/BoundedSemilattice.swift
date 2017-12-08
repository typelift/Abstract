/*:
# Bounded Semilattice

A Bounded Semilattice is a Commutative Monoid in which the operation is idempotent (applying it twice is the same as applying it once), thus:

a <> b <> b = a <> b
*/

#if SWIFT_PACKAGE
    import Operadics
#endif
    
public protocol BoundedSemilattice: CommutativeMonoid {}

extension Law where Element: BoundedSemilattice {
	public static func isIdempotent(_ a: Element, _ b: Element) -> Bool {
		return (a <> b <> b) == (a <> b)
	}
}

extension LawInContext where Element: BoundedSemilattice {
	public static func isIdempotent(_ a: Element, _ b: Element) -> (Element.Context) -> Bool {
		return (a <> b <> b) == (a <> b)
	}
}

/*:
## Types
*/

// sourcery: fixedTypesForPropertyBasedTests = "TestStructure"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "BoundedSemilattice & Equatable"
public struct OptionalBS<T>: BoundedSemilattice, Wrapper, Equatable where T: BoundedSemilattice & Equatable {
	public typealias WrappedType = T?

	public let unwrap: T?
	public init(_ value: T?) {
		self.unwrap = value
	}

	public static var empty: OptionalBS<T> {
		return .init(nil)
	}

	public static func <> (_ left: OptionalBS, _ right: OptionalBS) -> OptionalBS {
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

	public static func == (_ left: OptionalBS, _ right: OptionalBS) -> Bool {
		return left.unwrap == right.unwrap
	}
}

//: ------

// sourcery: fixedTypesForPropertyBasedTests = "TestFunction"
// sourcery: requiredContextForPropertyBasedTests = "String"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "BoundedSemilattice & EquatableInContext"
public struct OptionalBSF<T>: BoundedSemilattice, Wrapper, EquatableInContext where T: BoundedSemilattice & EquatableInContext {
	public typealias WrappedType = T?
	public typealias Context = T.Context

	public let unwrap: T?
	public init(_ value: T?) {
		self.unwrap = value
	}

	public static var empty: OptionalBSF<T> {
		return .init(nil)
	}

	public static func <> (_ left: OptionalBSF, _ right: OptionalBSF) -> OptionalBSF {
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

extension Max: BoundedSemilattice {}

//: ------

extension Min: BoundedSemilattice {}

//: ------

extension And: BoundedSemilattice {}

//: ------

extension Or: BoundedSemilattice {}

//: ------

// sourcery: fixedTypesForPropertyBasedTests = "Int,TestStructure"
// sourcery: requiredContextForPropertyBasedTests = "Int"
// sourcery: arbitraryFunction
// sourcery: arbitraryGenericParameterProtocols = "BoundedSemilattice & Equatable"
public struct FunctionBS<A, M: BoundedSemilattice & Equatable>: Wrapper, BoundedSemilattice, EquatableInContext {
	public typealias WrappedType = (A) -> M
	public typealias Context = A

	public let unwrap: (A) -> M
	
	public init(_ value: @escaping (A) -> M) {
		self.unwrap = value
	}

	public var call: (A) -> M {
		return unwrap
	}

	public static func <> (left: FunctionBS, right: FunctionBS) -> FunctionBS {
		return FunctionBS.init { left.call($0) <> right.call($0) }
	}
	
	public static var empty: FunctionBS<A, M> {
		return FunctionBS { _ in M.empty }
	}
	
	public static func == (left: FunctionBS, right: FunctionBS) -> (Context) -> Bool {
		return { context in left.call(context) == right.call(context) }
	}
}
