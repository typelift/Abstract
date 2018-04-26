#if SWIFT_PACKAGE
	import Operadics
#endif

extension String: Monoid {
	public static let empty: String = ""

	public static func <> (left: String, right: String) -> String {
		return left + right
	}
}
