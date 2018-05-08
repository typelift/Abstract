#if SWIFT_PACKAGE
	import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "Int"
public struct FreeCommutativeMonoid<A>: Wrapper, CommutativeMonoid where A: Hashable {
	public typealias WrappedType = Multiset<A>

	public let unwrap: Multiset<A>
	public init(_ unwrap: Multiset<A>) {
		self.unwrap = unwrap
	}

	public init(_ value: A) {
		self.unwrap = Multiset([value])
	}

	public static func <> (lhs: FreeCommutativeMonoid<A>, rhs: FreeCommutativeMonoid<A>) -> FreeCommutativeMonoid<A> {
		return FreeCommutativeMonoid(lhs.unwrap.disjointUnion(rhs.unwrap))
	}

	public static var empty: FreeCommutativeMonoid {
		return FreeCommutativeMonoid([])
	}
}

extension FreeCommutativeMonoid: Equatable {}
