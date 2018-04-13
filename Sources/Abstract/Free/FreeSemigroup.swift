#if SWIFT_PACKAGE
	import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "TestStructure"
// sourcery: arbitrary
// sourcery: constrainedArbitraryParameter = "A"
public struct FreeSemigroup<A>: Wrapper, Semigroup {
	public typealias WrappedType = Array<A>

	public let unwrap: Array<A>
	public init(_ value: Array<A>) {
		self.unwrap = value
	}

	public static func <> (lhs: FreeSemigroup, rhs: FreeSemigroup) -> FreeSemigroup {
		return FreeSemigroup(lhs.unwrap + rhs.unwrap)
	}
}
