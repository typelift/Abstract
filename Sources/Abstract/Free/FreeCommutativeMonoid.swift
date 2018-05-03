#if SWIFT_PACKAGE
	import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "Int"
public struct FreeCommutativeMonoid<A>: Wrapper, CommutativeMonoid where A: Hashable {
	public typealias WrappedType = Multiset<A>

	public let unwrap: Multiset<A>
	public init(_ unwrap: Multiset<A>) {
		self.unwrap = unwrap
	}

	public init(_ value: A) {
		self.unwrap = Multiset([value])
	}

	public static func <> (lhs: FreeCommutativeMonoid<A>, rhs: FreeCommutativeMonoid<A>) -> FreeCommutativeMonoid<A> {
		return FreeCommutativeMonoid(lhs.unwrap.disjointUnion(rhs.unwrap))
	}

	public static var empty: FreeCommutativeMonoid {
		return FreeCommutativeMonoid([])
	}
}

extension FreeCommutativeMonoid: Equatable {}

//extension FreeCommutativeMonoid: EquatableInContext where A: EquatableInContext {
//	public typealias Context = A.Context
//}

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


//public struct FreeSemiring<A>: Semiring where A: Hashable {
//	public typealias WrappedType = Multiset<A>
//
//	public let unwrap: Multiset<A>
//	public init(_ unwrap: Multiset<A>) {
//		self.unwrap = unwrap
//	}
//
//	public init(_ value: A) {
//		self.unwrap = Multiset<A>([value])
//	}
//
//	public static func <>+ (left: FreeSemiring<A>, right: FreeSemiring<A>) -> FreeSemiring<A> {
//		return FreeSemiring((FreeCommutativeMonoid<A>(left.unwrap.0) <> FreeCommutativeMonoid<A>(right.unwrap.0)))
//	}
//
//	public static func <>* (left: FreeSemiring<A>, right: FreeSemiring<A>) -> FreeSemiring<A> {
//		<#code#>
//	}
//
//	public static var zero: FreeSemiring<A>
//
//	public static var one: FreeSemiring<A>
//
//	public typealias Additive = FreeCommutativeMonoid<A>
//	public typealias Multiplicative = FreeMonoid<A>
//}
