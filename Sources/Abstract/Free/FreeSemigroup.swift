#if SWIFT_PACKAGE
	import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "Int"
public struct FreeSemigroup<A>: Semigroup {
	public let unwrap: Array<A>
	private init(unwrap: Array<A>) {
		self.unwrap = unwrap
	}

	public init(_ value: A) {
		self.unwrap = [value]
	}

	public static func <> (lhs: FreeSemigroup, rhs: FreeSemigroup) -> FreeSemigroup {
		return FreeSemigroup(unwrap: lhs.unwrap + rhs.unwrap)
	}
}

extension FreeSemigroup: Equatable where A: Equatable {
	public static func == (lhs: FreeSemigroup, rhs: FreeSemigroup) -> Bool {
		return lhs.unwrap == rhs.unwrap
	}
}

extension FreeSemigroup: EquatableInContext where A: EquatableInContext {
	public typealias Context = A.Context

	public static func == (lhs: FreeSemigroup, rhs: FreeSemigroup) -> (Context) -> Bool {
		return lhs.unwrap == rhs.unwrap
	}
}
