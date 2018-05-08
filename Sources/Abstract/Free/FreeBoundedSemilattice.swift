#if SWIFT_PACKAGE
	import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "Int"
public struct FreeBoundedSemilattice<A>: Wrapper, BoundedSemilattice where A: Hashable {
	public typealias WrappedType = Multiset<A>

	public let unwrap: Multiset<A>
	public init(_ unwrap: Multiset<A>) {
		self.unwrap = unwrap
	}

	public init(_ value: A) {
		self.unwrap = Multiset([value])
	}

	public static func <> (lhs: FreeBoundedSemilattice<A>, rhs: FreeBoundedSemilattice<A>) -> FreeBoundedSemilattice<A> {
		return FreeBoundedSemilattice(lhs.unwrap.union(rhs.unwrap))
	}

	public static var empty: FreeBoundedSemilattice {
		return FreeBoundedSemilattice([])
	}
}

extension FreeBoundedSemilattice: Equatable {}
