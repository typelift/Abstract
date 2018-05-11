#if SWIFT_PACKAGE
	import Operadics
#endif

/*:
`SetM` is a set where `Element` is a `Monoid`. It has a `Semiring` definition where:

- *addition* is set union, and *zero* is the empty set;
- *multiplication* is cartesian product between sets, with elements merged with `<>`, and *one* is the singleton set with `.empty`;

This construction derives from [this article](https://www.sciencedirect.com/science/article/pii/0022000085900492).
*/

// sourcery: fixedTypesForPropertyBasedTests = "String"
public struct SetM<A>: Wrapper & Equatable where A: Hashable & Monoid {
	public typealias WrappedType = Set<A>

	public let unwrap: Set<A>
	public init(_ unwrap: Set<A>) {
		self.unwrap = unwrap
	}
}

//: Conformance derives automatically from the fact that `SetM` wraps a `Set`
extension SetM: Collection {}

extension SetM: Semiring {
	public static func <>+ (lhs: SetM, rhs: SetM) -> SetM {
		return SetM(lhs.unwrap.union(rhs.unwrap))
	}

	public static var zero: SetM {
		return SetM([])
	}

	public static func <>* (lhs: SetM, rhs: SetM) -> SetM {
		var cartesianProduct: Array<A> = []
		cartesianProduct.reserveCapacity(lhs.unwrap.count * rhs.unwrap.count)

		for firstElement in lhs.unwrap {
			for secondElement in rhs.unwrap {
				cartesianProduct.append(firstElement <> secondElement)
			}
		}

		return SetM(Set(cartesianProduct))
	}

	public static var one: SetM {
		return SetM([.empty])
	}
}
