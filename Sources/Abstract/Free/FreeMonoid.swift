#if SWIFT_PACKAGE
import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "TestStructure"
// sourcery: arbitrary
struct FreeMonoid<A>: Wrapper, Monoid {
	typealias WrappedType = Array<A>

	let unwrap: Array<A>
	init(_ value: Array<A>) {
		self.unwrap = value
	}

	static func <> (lhs: FreeMonoid<A>, rhs: FreeMonoid<A>) -> FreeMonoid<A> {
		return FreeMonoid(lhs.unwrap + rhs.unwrap)
	}

	static var empty: FreeMonoid {
		return FreeMonoid([])
	}
}
