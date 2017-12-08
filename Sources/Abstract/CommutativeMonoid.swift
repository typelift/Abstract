/*:
# Commutative Monoid

A Commutative Monoid is a Monoid in which the operation is commutative, thus:

a <> b = b <> a
*/

#if SWIFT_PACKAGE
    import Operadics
#endif
    
public protocol CommutativeMonoid: Monoid {}

extension Law where Element: CommutativeMonoid {
	public static func isCommutative(_ a: Element, _ b: Element) -> Bool {
		return (a <> b) == (b <> a)
	}
}

extension LawInContext where Element: CommutativeMonoid {
	public static func isCommutative(_ a: Element, _ b: Element) -> (Element.Context) -> Bool {
		return (a <> b) == (b <> a)
	}
}

/*:
## Types
*/

// sourcery: fixedTypesForPropertyBasedTests = "TestStructure"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "CommutativeMonoid & Equatable"
public struct OptionalCM<T>: CommutativeMonoid, Wrapper, Equatable where T: CommutativeMonoid & Equatable {
	public typealias WrappedType = T?

	public let unwrap: T?
	public init(_ value: T?) {
		self.unwrap = value
	}

	public static var empty: OptionalCM<T> {
		return .init(nil)
	}

	public static func <> (_ left: OptionalCM, _ right: OptionalCM) -> OptionalCM {
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

	public static func == (_ left: OptionalCM, _ right: OptionalCM) -> Bool {
		return left.unwrap == right.unwrap
	}
}

//: ------

// sourcery: fixedTypesForPropertyBasedTests = "TestFunction"
// sourcery: requiredContextForPropertyBasedTests = "String"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "CommutativeMonoid & EquatableInContext"
public struct OptionalCMF<T>: CommutativeMonoid, Wrapper, EquatableInContext where T: CommutativeMonoid & EquatableInContext {
	public typealias WrappedType = T?
	public typealias Context = T.Context

	public let unwrap: T?
	public init(_ value: T?) {
		self.unwrap = value
	}

	public static var empty: OptionalCMF<T> {
		return .init(nil)
	}

	public static func <> (_ left: OptionalCMF, _ right: OptionalCMF) -> OptionalCMF {
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

extension Add: CommutativeMonoid {}

//: ------

extension Multiply: CommutativeMonoid {}

//: ------

extension Max: CommutativeMonoid {}

//: ------

extension Min: CommutativeMonoid {}

//: ------

extension And: CommutativeMonoid {}

//: ------

extension Or: CommutativeMonoid {}

//: ------

// sourcery: fixedTypesForPropertyBasedTests = "Int,TestStructure"
// sourcery: requiredContextForPropertyBasedTests = "Int"
// sourcery: arbitraryFunction
// sourcery: arbitraryGenericParameterProtocols = "CommutativeMonoid & Equatable"
public struct FunctionCM<A, M: CommutativeMonoid & Equatable>: Wrapper, CommutativeMonoid, EquatableInContext {
	public typealias WrappedType = (A) -> M
	public typealias Context = A

	public let unwrap: (A) -> M
	
	public init(_ value: @escaping (A) -> M) {
		self.unwrap = value
	}

	public var call: (A) -> M {
		return unwrap
	}

	public static func <> (left: FunctionCM, right: FunctionCM) -> FunctionCM {
		return FunctionCM.init { left.call($0) <> right.call($0) }
	}
	
	public static var empty: FunctionCM<A, M> {
		return FunctionCM { _ in M.empty }
	}
	
	public static func == (left: FunctionCM, right: FunctionCM) -> (Context) -> Bool {
		return { context in left.call(context) == right.call(context) }
	}
}
