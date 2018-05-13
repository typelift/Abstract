#if SWIFT_PACKAGE
	import Operadics
#endif

// sourcery: ignore = "Wrapper"
// sourcery: ignore = "Semigroup"
// sourcery: ignore = "Monoid"
// sourcery: ignore = "CommutativeMonoid"
// sourcery: ignore = "BoundedSemilattice"
// sourcery: ignore = "Semiring"
public struct Function<A,B>: Wrapper {
	public typealias WrappedType = (A) -> B

	public let unwrap: (A) -> B

	public init(_ value: @escaping (A) -> B) {
		self.unwrap = value
	}

	public func call(_ value: A) -> B {
		return unwrap(value)
	}
}

/// this is tested for isomorphism
extension Function where B == Ordering {
	public func reversed() -> Function {
		return Function { self.call($0).reversed() }
	}
}

extension Function: EquatableInContext where B: Equatable {
	public typealias Context = A

	public static func == (lhs: Function, rhs: Function) -> (Context) -> Bool {
		return { lhs.call($0) == rhs.call($0) }
	}
}

extension Function: Magma where B: Magma {
	public static func <> (lhs: Function, rhs: Function) -> Function {
		return Function { lhs.call($0) <> rhs.call($0) }
	}
}

extension Function: Semigroup where B: Semigroup {}

extension Function: Monoid where B: Monoid {
	public static var empty: Function {
		return Function { _ in B.empty }
	}
}

extension Function: CommutativeMonoid where B: CommutativeMonoid {}

extension Function: BoundedSemilattice where B: BoundedSemilattice {}

extension Function: Semiring where B: Semiring {
	public static func <>+ (lhs: Function<A, B>, rhs: Function<A, B>) -> Function<A, B> {
		return Function { lhs.call($0) <>+ rhs.call($0) }
	}

	public static func <>* (lhs: Function<A, B>, rhs: Function<A, B>) -> Function<A, B> {
		return Function { lhs.call($0) <>* rhs.call($0) }
	}

	public static var zero: Function<A, B> {
		return Function { _ in B.zero }
	}

	public static var one: Function<A, B> {
		return Function { _ in B.one }
	}
}

