#if SWIFT_PACKAGE
	import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "Int"
extension Set: BoundedSemilattice {
	public static var empty: Set {
		return []
	}

	public static func <> (lhs: Set, rhs: Set) -> Set {
		return lhs.union(rhs)
	}
}

public typealias FreeBoundedSemilattice<A> = Set<A> where A: Hashable
