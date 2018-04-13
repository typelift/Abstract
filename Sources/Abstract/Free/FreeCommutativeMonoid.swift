#if SWIFT_PACKAGE
import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "TestStructure"
// sourcery: arbitrary
// sourcery: constrainedArbitraryParameter = "A"
public struct FreeCommutativeMonoid<A>: Wrapper, CommutativeMonoid {
	public typealias WrappedType = Array<A>

	public let unwrap: Array<A>
	public init(_ value: Array<A>) {
		self.unwrap = value
	}

	public static func <> (lhs: FreeCommutativeMonoid<A>, rhs: FreeCommutativeMonoid<A>) -> FreeCommutativeMonoid<A> {
		if lhs.unwrap.count > rhs.unwrap.count {
			return FreeCommutativeMonoid(lhs.unwrap)
		} else {
			return FreeCommutativeMonoid(rhs.unwrap)
		}
	}

	public static var empty: FreeCommutativeMonoid {
		return FreeCommutativeMonoid([])
	}
}
