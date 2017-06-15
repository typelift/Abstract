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

public struct Add<A: Summable>: Wrapper, Semigroup, Equatable {
	public typealias Wrapped = A

	public let unwrap: A
	
	public init(_ value: A) {
		self.unwrap = value
	}
	
	public static func <> (left: Add, right: Add) -> Add {
		return Add(left.unwrap + right.unwrap)
	}
	
	public static func == (left: Add, right: Add) -> Bool {
		return left.unwrap == right.unwrap
	}
}

//: ------

public struct Multiply<A: Multipliable>: Wrapper, Semigroup, Equatable {
	public typealias Wrapped = A

	public let unwrap: A
	
	public init(_ value: A) {
		self.unwrap = value
	}
	
	public static func <> (left: Multiply, right: Multiply) -> Multiply {
		return Multiply(left.unwrap * right.unwrap)
	}
	
	public static func == (left: Multiply, right: Multiply) -> Bool {
		return left.unwrap == right.unwrap
	}
}

//: ------

public struct Max<A: ComparableToBottom>: Wrapper, Semigroup, Equatable {
	public typealias Wrapped = A

	public let unwrap: A
	
	public init(_ value: A) {
		self.unwrap = value
	}
	
	public static func <> (left: Max, right: Max) -> Max {
		return Max(max(left.unwrap, right.unwrap))
	}
	
	public static func == (left: Max, right: Max) -> Bool {
		return left.unwrap == right.unwrap
	}
}

//: ------

public struct Min<A: ComparableToTop>: Wrapper, Semigroup, Equatable {
	public typealias Wrapped = A

	public let unwrap: A
	
	public init(_ value: A) {
		self.unwrap = value
	}
	
	public static func <> (left: Min, right: Min) -> Min {
		return Min(min(left.unwrap, right.unwrap))
	}
	
	public static func == (left: Min, right: Min) -> Bool {
		return left.unwrap == right.unwrap
	}
}

//: ------

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

	public static func == (left: And, right: And) -> Bool {
		return left.unwrap == right.unwrap
	}
}

//: ------

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

	public static func == (left: Or, right: Or) -> Bool {
		return left.unwrap == right.unwrap
	}
}

//: ------

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
		return { context in left.call(context) == right.call(context) }
	}
}

//: ------

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
