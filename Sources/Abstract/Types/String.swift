#if SWIFT_PACKAGE
	import Operadics
#endif

extension String: Monoid {
	public static let empty: String = ""

	public static func <> (lhs: String, rhs: String) -> String {
		return lhs + rhs
	}
}
