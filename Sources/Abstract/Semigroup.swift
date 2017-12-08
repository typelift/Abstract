/*:
# Semigroup

A Semigroup is a Magma where the composition operation is associative, which means that multiple operations in sequence can happen in any time order.

To put it simply: (a <> b) <> c = a <> (b <> c)
*/

#if SWIFT_PACKAGE
    import Operadics
#endif

public protocol Semigroup: Magma {}

extension Law where Element: Semigroup {
	public static func isAssociative(_ a: Element, _ b: Element, _ c: Element) -> Bool {
		return (a <> b <> c) == (a <> (b <> c))
	}
}

extension LawInContext where Element: Semigroup {
	public static func isAssociative(_ a: Element, _ b: Element, _ c: Element) -> (Element.Context) -> Bool {
		return (a <> b <> c) == (a <> (b <> c))
	}
}

/*:
## Types

Here are some types that form a relevant Semigroup along with a specific operation.

Each type is tested for associativity in `AbstractTests.swift`, and for testing purposes every type is made to conform to `Equatable`.
*/

//: ------

// sourcery: fixedTypesForPropertyBasedTests = "TestStructure"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "Semigroup & Equatable"
public struct OptionalS<T>: Semigroup, Wrapper, Equatable where T: Semigroup & Equatable {
	public typealias WrappedType = T?

	public let unwrap: T?

	public init(_ value: T?) {
		self.unwrap = value
	}

	public static func <> (_ left: OptionalS, _ right: OptionalS) -> OptionalS {
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
public struct OptionalSF<T>: Semigroup, Wrapper, EquatableInContext where T: Semigroup & EquatableInContext {
	public typealias WrappedType = T?
	public typealias Context = T.Context

	public let unwrap: WrappedType

	public init(_ value: WrappedType) {
		self.unwrap = value
	}

	public static func <> (_ left: OptionalSF, _ right: OptionalSF) -> OptionalSF {
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

// sourcery: fixedTypesForPropertyBasedTests = "Int"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "Addable"
public struct Add<A: Addable>: Wrapper, Semigroup, Equatable {
	public typealias WrappedType = A

	public let unwrap: A
	
	public init(_ value: A) {
		self.unwrap = value
	}
	
	public static func <> (left: Add, right: Add) -> Add {
		return Add.init(A.add(left.unwrap,right.unwrap))
	}
}

//: ------

// sourcery: fixedTypesForPropertyBasedTests = "Int"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "Multipliable"
public struct Multiply<A: Multipliable>: Wrapper, Semigroup, Equatable {
	public typealias WrappedType = A

	public let unwrap: A
	
	public init(_ value: A) {
		self.unwrap = value
	}
	
	public static func <> (left: Multiply, right: Multiply) -> Multiply {
		return Multiply(A.multiply(left.unwrap,right.unwrap))
	}
}

//: ------

// sourcery: fixedTypesForPropertyBasedTests = "Int"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "ComparableToBottom"
public struct Max<A: ComparableToBottom>: Wrapper, Semigroup, Equatable {
	public typealias WrappedType = A

	public let unwrap: A
	
	public init(_ value: A) {
		self.unwrap = value
	}
	
	public static func <> (left: Max, right: Max) -> Max {
		return Max(max(left.unwrap, right.unwrap))
	}
}

//: ------

// sourcery: fixedTypesForPropertyBasedTests = "Int"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "ComparableToTop"
public struct Min<A: ComparableToTop>: Wrapper, Semigroup, Equatable {
	public typealias WrappedType = A

	public let unwrap: A
	
	public init(_ value: A) {
		self.unwrap = value
	}
	
	public static func <> (left: Min, right: Min) -> Min {
		return Min(min(left.unwrap, right.unwrap))
	}
}

//: ------

// sourcery: arbitrary
public struct And: Wrapper, Semigroup, Equatable, ExpressibleByBooleanLiteral {
	public typealias WrappedType = Bool
	public typealias BooleanLiteralType = Bool

	public let unwrap: Bool

	public init(_ value: Bool) {
		self.unwrap = value
	}

	public init(booleanLiteral value: BooleanLiteralType) {
		self.init(value)
	}

	public static func <> (left: And, right: And) -> And {
		return And(left.unwrap && right.unwrap)
	}
}

//: ------

// sourcery: arbitrary
public struct Or: Wrapper, Semigroup, Equatable, ExpressibleByBooleanLiteral {
	public typealias WrappedType = Bool
	public typealias BooleanLiteralType = Bool

	public let unwrap: Bool

	public init(_ value: Bool) {
		self.unwrap = value
	}

	public init(booleanLiteral value: BooleanLiteralType) {
		self.init(value)
	}

	public static func <> (left: Or, right: Or) -> Or {
		return Or(left.unwrap || right.unwrap)
	}
}

//: ------

// sourcery: fixedTypesForPropertyBasedTests = "Int"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "Equatable"
public struct First<A: Equatable>: Wrapper, Semigroup, Equatable {
    public typealias WrappedType = A
    
    public let unwrap: A
    
    public init(_ value: A) {
        self.unwrap = value
    }
    
    public static func <> (left: First, right: First) -> First {
        return left
    }
}

//: ------

// sourcery: fixedTypesForPropertyBasedTests = "TestFunction"
// sourcery: requiredContextForPropertyBasedTests = "String"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "EquatableInContext"
public struct FirstF<A>: Wrapper, Semigroup, EquatableInContext where A: EquatableInContext {
	public typealias WrappedType = A
	public typealias Context = A.Context

	public let unwrap: WrappedType

	public init(_ value: WrappedType) {
		self.unwrap = value
	}

	public static func <> (left: FirstF, right: FirstF) -> FirstF {
		return left
	}
}

//: ------

// sourcery: fixedTypesForPropertyBasedTests = "Int"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "Equatable"
public struct Last<A>: Wrapper, Semigroup, Equatable where A: Equatable {
    public typealias WrappedType = A
    
    public let unwrap: A
    
    public init(_ value: A) {
        self.unwrap = value
    }
    
    public static func <> (left: Last, right: Last) -> Last {
        return right
    }
}

//: ------

// sourcery: fixedTypesForPropertyBasedTests = "TestFunction"
// sourcery: requiredContextForPropertyBasedTests = "String"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "EquatableInContext"
public struct LastF<A>: Wrapper, Semigroup, EquatableInContext where A: EquatableInContext {
	public typealias WrappedType = A
	public typealias Context = A.Context

	public let unwrap: A

	public init(_ value: A) {
		self.unwrap = value
	}

	public static func <> (left: LastF, right: LastF) -> LastF {
		return right
	}
}

//: ------

// sourcery: fixedTypesForPropertyBasedTests = "Int"
// sourcery: requiredContextForPropertyBasedTests = "Int"
public struct Endofunction<A: Equatable>: Wrapper, Semigroup, EquatableInContext {
	public typealias WrappedType = (A) -> A
	public typealias Context = A

	public let unwrap: (A) -> A
	
	public init(_ value: @escaping (A) -> A) {
		self.unwrap = value
	}

	public var call: (A) -> A {
		return unwrap
	}

	public static func <> (left: Endofunction, right: Endofunction) -> Endofunction {
		return Endofunction.init { right.call(left.call($0)) }
	}
	
	public static func == (left: Endofunction, right: Endofunction) -> (Context) -> Bool {
		return { left.call($0) == right.call($0) }
	}
}

//: ------

// sourcery: fixedTypesForPropertyBasedTests = "Int,TestStructure"
// sourcery: requiredContextForPropertyBasedTests = "Int"
// sourcery: arbitraryFunction
// sourcery: arbitraryGenericParameterProtocols = "Semigroup & Equatable"
public struct FunctionS<A, S: Semigroup & Equatable>: Wrapper, Semigroup, EquatableInContext {
	public typealias WrappedType = (A) -> S
	public typealias Context = A

	public let unwrap: (A) -> S

	public init(_ value: @escaping (A) -> S) {
		self.unwrap = value
	}

	public var call: (A) -> S {
		return unwrap
	}

	public static func <> (left: FunctionS, right: FunctionS) -> FunctionS {
		return FunctionS.init { left.call($0) <> right.call($0) }
	}
	
	public static func == (left: FunctionS, right: FunctionS) -> (Context) -> Bool {
		return { left.call($0) == right.call($0) }
	}
}

//: ------

// sourcery: arbitrary
public enum Ordering: Semigroup {
	case lowerThan
	case equalTo
	case greaterThan
	
	public static func <> (left: Ordering, right: Ordering) -> Ordering {
		switch (left,right) {
		case (.lowerThan,_):
			return left
		case (.equalTo,_):
			return right
		case (.greaterThan,_):
			return left
		}
	}
}
