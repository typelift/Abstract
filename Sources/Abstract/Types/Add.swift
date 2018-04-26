#if SWIFT_PACKAGE
	import Operadics
#endif

// sourcery: wrapperEquatable
// sourcery: fixedTypesForPropertyBasedTests = "Int"
// sourcery: arbitrary
// sourcery: constrainedArbitraryParameter = "A"
// sourcery: arbitraryGenericParameterProtocols = "Addable"
public struct Add<A>: Wrapper where A: Addable {
	public typealias WrappedType = A

	public let unwrap: A

	public init(_ value: A) {
		self.unwrap = value
	}
}

extension Add: Semigroup {
	public static func <> (left: Add, right: Add) -> Add {
		return Add.init(A.add(left.unwrap,right.unwrap))
	}
}

extension Add: Monoid {
	public static var empty: Add {
		return Add.init(A.zero)
	}
}

extension Add: CommutativeMonoid {}
