#if SWIFT_PACKAGE
import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "Int"
public struct FreeCommutativeMonoid<A>: Wrapper, CommutativeMonoid {
	public typealias WrappedType = Array<A>

	public let unwrap: Array<A>
	public init(_ value: Array<A>) {
		self.unwrap = value
	}

	public init(unwrap: Array<A>) {
		self.init(unwrap)
	}

	public static func <> (lhs: FreeCommutativeMonoid<A>, rhs: FreeCommutativeMonoid<A>) -> FreeCommutativeMonoid<A> {
		if lhs.unwrap.count > rhs.unwrap.count {
			return FreeCommutativeMonoid(lhs.unwrap + rhs.unwrap)
		} else {
			return FreeCommutativeMonoid(rhs.unwrap + lhs.unwrap)
		}
	}

	public static var empty: FreeCommutativeMonoid {
		return FreeCommutativeMonoid([])
	}
}

extension FreeCommutativeMonoid: Equatable where A: Equatable {}

extension FreeCommutativeMonoid: EquatableInContext where A: EquatableInContext {
	public typealias Context = A.Context
}

