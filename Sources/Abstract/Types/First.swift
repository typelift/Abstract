#if SWIFT_PACKAGE
	import Operadics
#endif

// sourcery: wrapperEquatable
// sourcery: fixedTypesForPropertyBasedTests = "Int"
// sourcery: arbitrary
// sourcery: constrainedArbitraryParameter = "A"
public struct First<A>: Wrapper {
	public typealias WrappedType = A

	public let unwrap: A

	public init(_ value: A) {
		self.unwrap = value
	}
}

extension First: Semigroup {
	public static func <> (lhs: First, rhs: First) -> First {
		return lhs
	}
}
