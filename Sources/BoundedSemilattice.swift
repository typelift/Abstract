/*:
# Bounded Semilattice

A Bounded Semilattice is a Commutative Monoid in which the operation is idempotent (applying it twice is the same as applying it once), thus:

a <> b <> b = a <> b
*/

public protocol BoundedSemilattice: CommutativeMonoid {}

extension Law where Element: BoundedSemilattice {
	public static func isIdempotent(_ a: Element, _ b: Element) -> Bool {
		return (a <> b <> b) == (a <> b)
	}
}

extension LawInContext where Element: BoundedSemilattice {
	public static func isIdempotent(_ a: Element, _ b: Element) -> (Element.Context) -> Bool {
		return { context in ((a <> b <> b) == (a <> b))(context) }
	}
}

/*:
## Types
*/

extension Max: BoundedSemilattice {}

//: ------

extension Min: BoundedSemilattice {}

//: ------

extension And: BoundedSemilattice {}

//: ------

extension Or: BoundedSemilattice {}

//: ------

public struct FunctionBS<A, M: BoundedSemilattice & Equatable>: BoundedSemilattice, EquatableInContext {
	public typealias Context = A
	
	public let call: (A) -> M
	
	public init(_ call: @escaping (A) -> M) {
		self.call = call
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
