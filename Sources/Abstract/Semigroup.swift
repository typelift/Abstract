/*:
# Semigroup

A Semigroup is a Magma where the composition operation is associative, which means that multiple operations in sequence can happen in any time order.

To put it simply: (a <> b) <> c = a <> (b <> c)
*/

#if !XCODE_BUILD
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

// sourcery: semigroup
// sourcery: wrapper
// sourcery: genericArbitraryTypes = "Int"
public struct Add<A: Addable>: Wrapper, Semigroup, Equatable {
	public typealias Wrapped = A

	public let unwrap: A
	
	public init(_ value: A) {
		self.unwrap = value
	}
	
	public static func <> (left: Add, right: Add) -> Add {
		return Add.init(A.add(left.unwrap,right.unwrap))
	}
}

//: ------

// sourcery: semigroup
// sourcery: wrapper
// sourcery: genericArbitraryTypes = "Int"
public struct Multiply<A: Multipliable>: Wrapper, Semigroup, Equatable {
	public typealias Wrapped = A

	public let unwrap: A
	
	public init(_ value: A) {
		self.unwrap = value
	}
	
	public static func <> (left: Multiply, right: Multiply) -> Multiply {
		return Multiply(A.multiply(left.unwrap,right.unwrap))
	}
}

//: ------

// sourcery: semigroup
// sourcery: wrapper
// sourcery: genericArbitraryTypes = "Int"
public struct Max<A: ComparableToBottom>: Wrapper, Semigroup, Equatable {
	public typealias Wrapped = A

	public let unwrap: A
	
	public init(_ value: A) {
		self.unwrap = value
	}
	
	public static func <> (left: Max, right: Max) -> Max {
		return Max(max(left.unwrap, right.unwrap))
	}
}

//: ------

// sourcery: semigroup
// sourcery: wrapper
// sourcery: genericArbitraryTypes = "Int"
public struct Min<A: ComparableToTop>: Wrapper, Semigroup, Equatable {
	public typealias Wrapped = A

	public let unwrap: A
	
	public init(_ value: A) {
		self.unwrap = value
	}
	
	public static func <> (left: Min, right: Min) -> Min {
		return Min(min(left.unwrap, right.unwrap))
	}
}

//: ------

// sourcery: semigroup
// sourcery: wrapper
public struct And: Wrapper, Semigroup, Equatable, ExpressibleByBooleanLiteral {
	public typealias Wrapped = Bool
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

// sourcery: semigroup
// sourcery: wrapper
public struct Or: Wrapper, Semigroup, Equatable, ExpressibleByBooleanLiteral {
	public typealias Wrapped = Bool
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

// sourcery: semigroup
// sourcery: wrapper
// sourcery: genericArbitraryTypes = "Int"
// sourcery: requiredContext = "Int"
public struct Endofunction<A: Equatable>: Wrapper, Semigroup, EquatableInContext {
	public typealias Wrapped = (A) -> A
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

// sourcery: semigroup
// sourcery: wrapper
// sourcery: genericArbitraryTypes = "Int,TestStructure"
// sourcery: requiredContext = "Int"
public struct FunctionS<A, S: Semigroup & Equatable>: Wrapper, Semigroup, EquatableInContext {
	public typealias Wrapped = (A) -> S
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

// sourcery: semigroup
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
