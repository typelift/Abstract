/*:
# Semigroup

A Semigroup is a Magma where the composition operation is associative, which means that multiple operations in sequence can happen in any time order.

To put it simply: (a <> b) <> c = a <> (b <> c)
*/

import Operadics

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

public struct Add<A: Summable>: Semigroup, Equatable {
	public let value: A
	
	init(_ value: A) {
		self.value = value
	}
	
	public static func <> (left: Add, right: Add) -> Add {
		return Add(left.value + right.value)
	}
	
	public static func == (left: Add, right: Add) -> Bool {
		return left.value == right.value
	}
}

//: ------

public struct Multiply<A: Multipliable>: Semigroup, Equatable {
	public let value: A
	
	public init(_ value: A) {
		self.value = value
	}
	
	public static func <> (left: Multiply, right: Multiply) -> Multiply {
		return Multiply(left.value * right.value)
	}
	
	public static func == (left: Multiply, right: Multiply) -> Bool {
		return left.value == right.value
	}
}

//: ------

public struct Max<A: ComparableToBottom>: Semigroup, Equatable {
	public let value: A
	
	public init(_ value: A) {
		self.value = value
	}
	
	public static func <> (left: Max, right: Max) -> Max {
		return Max(max(left.value, right.value))
	}
	
	public static func == (left: Max, right: Max) -> Bool {
		return left.value == right.value
	}
}

//: ------

public struct Min<A: ComparableToTop>: Semigroup, Equatable {
	public let value: A
	
	public init(_ value: A) {
		self.value = value
	}
	
	public static func <> (left: Min, right: Min) -> Min {
		return Min(min(left.value, right.value))
	}
	
	public static func == (left: Min, right: Min) -> Bool {
		return left.value == right.value
	}
}

//: ------

public struct And: Semigroup, Equatable, ExpressibleByBooleanLiteral {
	public typealias BooleanLiteralType = Bool

	public let value: Bool

	public init(_ value: Bool) {
		self.value = value
	}

	public init(booleanLiteral value: BooleanLiteralType) {
		self.init(value)
	}

	public static func <> (left: And, right: And) -> And {
		return And(left.value && right.value)
	}

	public static func == (left: And, right: And) -> Bool {
		return left.value == right.value
	}
}

//: ------

public struct Or: Semigroup, Equatable, ExpressibleByBooleanLiteral {
	public typealias BooleanLiteralType = Bool

	public let value: Bool

	public init(_ value: Bool) {
		self.value = value
	}

	public init(booleanLiteral value: BooleanLiteralType) {
		self.init(value)
	}

	public static func <> (left: Or, right: Or) -> Or {
		return Or(left.value || right.value)
	}

	public static func == (left: Or, right: Or) -> Bool {
		return left.value == right.value
	}
}

//: ------

public struct FunctionI<A: Equatable>: Semigroup, EquatableInContext {
	public typealias Context = A
	
	public let call: (A) -> A
	
	public init(_ call: @escaping (A) -> A) {
		self.call = call
	}
	
	public static func <> (left: FunctionI, right: FunctionI) -> FunctionI {
		return FunctionI.init { right.call(left.call($0)) }
	}
	
	public static func == (left: FunctionI, right: FunctionI) -> (Context) -> Bool {
		return { context in left.call(context) == right.call(context) }
	}
}

//: ------

public struct FunctionS<A, S: Semigroup & Equatable>: Semigroup, EquatableInContext {
	public typealias Context = A
	
	public let call: (A) -> S
	
	public init(_ call: @escaping (A) -> S) {
		self.call = call
	}
	
	public static func <> (left: FunctionS, right: FunctionS) -> FunctionS {
		return FunctionS.init { left.call($0) <> right.call($0) }
	}
	
	public static func == (left: FunctionS, right: FunctionS) -> (Context) -> Bool {
		return { context in left.call(context) == right.call(context) }
	}
}

//: ------

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
