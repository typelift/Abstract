#if SWIFT_PACKAGE
import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "Int"
public struct FreeMonoid<A>: Wrapper, Monoid {
	public typealias WrappedType = Array<A>

	public let unwrap: Array<A>
	public init(_ value: Array<A>) {
		self.unwrap = value
	}

	public init(unwrap: Array<A>) {
		self.init(unwrap)
	}

	public static func <> (lhs: FreeMonoid<A>, rhs: FreeMonoid<A>) -> FreeMonoid<A> {
		return FreeMonoid(lhs.unwrap + rhs.unwrap)
	}

	public static var empty: FreeMonoid {
		return FreeMonoid([])
	}
}

extension FreeMonoid: Equatable where A: Equatable {}

extension FreeMonoid: EquatableInContext where A: EquatableInContext {
	public typealias Context = A.Context
}

