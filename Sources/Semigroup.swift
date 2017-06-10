/*:
# Semigroup

A Semigroup is a Magma where the composition operation is associative, which means that multiple operations in sequence can happen in any time order.

To put it simply: (a <> b) <> c = a <> (b <> c)
*/

public protocol Semigroup: Magma {}

extension Law where Element: Semigroup {
	public static func associativity(_ a: Element, _ b: Element, _ c: Element) -> Bool {
		return (a <> b <> c) == (a <> (b <> c))
	}
}

extension LawInContext where Element: Semigroup {
	public static func associativity(_ a: Element, _ b: Element, _ c: Element) -> (Element.Context) -> Bool {
		return (a <> b <> c) == (a <> (b <> c))
	}
}

/*:
# Types

Here are some types that form a relevant Semigroup along with a specific operation.

Each type is tested for associativity in `AbstractTests.swift`, and for testing purposes every type is made to conform to `Equatable`.
*/

//: ------

public struct Add<T: Summable>: Semigroup, Equatable {
	public let value: T
	
	init(_ value: T) {
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

public struct Multiply<T: Multipliable>: Semigroup, Equatable {
	public let value: T
	
	public init(_ value: T) {
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

public struct Max<T: ComparableToBottom>: Semigroup, Equatable {
	public let value: T
	
	public init(_ value: T) {
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

public struct Min<T: ComparableToTop>: Semigroup, Equatable {
	public let value: T
	
	public init(_ value: T) {
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

public struct FunctionI<T: Equatable>: Semigroup, EquatableInContext {
	public typealias Context = T
	
	public let call: (T) -> T
	
	public init(_ call: @escaping (T) -> T) {
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

public struct FunctionS<T, S: Semigroup & Equatable>: Semigroup, EquatableInContext {
	public typealias Context = T
	
	public let call: (T) -> S
	
	public init(_ call: @escaping (T) -> S) {
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

public enum Ordering: Semigroup, Equatable {
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
	
	public static func == (left: Ordering, right: Ordering) -> Bool {
		switch (left,right) {
		case (.lowerThan,.lowerThan):
			return true
		case (.equalTo,.equalTo):
			return true
		case (.greaterThan,.greaterThan):
			return true
		default:
			return false
		}
	}
}
