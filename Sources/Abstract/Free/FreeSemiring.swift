#if SWIFT_PACKAGE
	import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "Int"
public struct FreeSemiring<A>: Wrapper, Semiring {
	public typealias WrappedType = Array<A>
	public typealias Additive = FreeCommutativeMonoid<A>
	public typealias Multiplicative = FreeMonoid<A>

	public let unwrap: Array<A>
	public init(_ value: Array<A>) {
		self.unwrap = value
	}

	public init(unwrap: Array<A>) {
		self.init(unwrap)
	}
}

extension FreeSemiring: Equatable where A: Equatable {}

extension FreeSemiring: EquatableInContext where A: EquatableInContext {
	public typealias Context = A.Context
}

