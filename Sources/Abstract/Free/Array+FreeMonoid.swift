#if SWIFT_PACKAGE
	import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "Int"
extension Array: Monoid {
	public static var empty: Array {
		return []
	}

	public static func <> (left: Array, right: Array) -> Array {
		return left + right
	}
}

public typealias FreeMonoid<A> = Array<A>
