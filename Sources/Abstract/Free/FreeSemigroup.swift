#if SWIFT_PACKAGE
	import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "TestStructure"
// sourcery: arbitrary
struct FreeSemigroup<A>: Wrapper, Semigroup {
	typealias WrappedType = Array<A>

	let unwrap: Array<A>
	init(_ value: Array<A>) {
		self.unwrap = value
	}

	static func <> (lhs: FreeSemigroup, rhs: FreeSemigroup) -> FreeSemigroup {
		return FreeSemigroup(lhs.unwrap + rhs.unwrap)
	}
}
