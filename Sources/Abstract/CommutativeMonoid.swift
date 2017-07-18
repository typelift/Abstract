/*:
# Commutative Monoid

A Commutative Monoid is a Monoid in which the operation is commutative, thus:

a <> b = b <> a
*/

#if !XCODE_BUILD
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

// sourcery: genericArbitraryTypes = "Int,TestStructure"
// sourcery: requiredContext = "Int"
public struct FunctionCM<A, M: CommutativeMonoid & Equatable>: Wrapper, CommutativeMonoid, EquatableInContext {
	public typealias Wrapped = (A) -> M
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
