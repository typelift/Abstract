#if SWIFT_PACKAGE
	import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "Int"
extension Set: BoundedSemilattice {
	public static var empty: Set {
		return []
	}

	public static func <> (left: Set, right: Set) -> Set {
		return left.union(right)
	}
}

public typealias FreeBoundedSemilattice<A> = Set<A> where A: Hashable
