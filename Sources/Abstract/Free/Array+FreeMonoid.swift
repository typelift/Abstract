#if SWIFT_PACKAGE
	import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "Int"
extension Array: Monoid {
	public static var empty: Array {
		return []
	}

	public static func <> (lhs: Array, rhs: Array) -> Array {
		return lhs + rhs
	}
}

public typealias FreeMonoid<A> = Array<A>
