#if SWIFT_PACKAGE
	import Operadics
#endif

// sourcery: wrapperEquatable
// sourcery: fixedTypesForPropertyBasedTests = "Int"
// sourcery: arbitrary
// sourcery: constrainedArbitraryParameter = "A"
// sourcery: arbitraryGenericParameterProtocols = "ComparableToTop"
public struct Min<A>: Wrapper where A: ComparableToTop {
	public typealias WrappedType = A

	public let unwrap: A

	public init(_ value: A) {
		self.unwrap = value
	}
}

extension Min: Semigroup {
	public static func <> (left: Min, right: Min) -> Min {
		return Min(min(left.unwrap, right.unwrap))
	}
}

extension Min: Monoid {
	public static var empty: Min<A> {
		return Min(A.max)
	}
}

extension Min: CommutativeMonoid {}

extension Min: BoundedSemilattice {}
