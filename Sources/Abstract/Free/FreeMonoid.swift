#if SWIFT_PACKAGE
import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "TestStructure"
// sourcery: arbitrary
// sourcery: constrainedArbitraryParameter = "A"
public struct FreeMonoid<A>: Wrapper, Monoid {
	public typealias WrappedType = Array<A>

	public let unwrap: Array<A>
	public init(_ value: Array<A>) {
		self.unwrap = value
	}

	public static func <> (lhs: FreeMonoid<A>, rhs: FreeMonoid<A>) -> FreeMonoid<A> {
		return FreeMonoid(lhs.unwrap + rhs.unwrap)
	}

	public static var empty: FreeMonoid {
		return FreeMonoid([])
	}
}
