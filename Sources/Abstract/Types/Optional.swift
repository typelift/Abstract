#if SWIFT_PACKAGE
	import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "Int"
extension Optional: Monoid {
	public static func <> (lhs: Optional, rhs: Optional) -> Optional {
		return lhs ?? rhs
	}

	public static var empty: Optional {
		return nil
	}
}
