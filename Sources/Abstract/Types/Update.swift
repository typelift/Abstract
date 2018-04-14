#if SWIFT_PACKAGE
	import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "Int"
// sourcery: arbitrary
// sourcery: constrainedArbitraryParameter = "A"
public struct Update<A>: Wrapper {
	public typealias WrappedType = Optional<A>

	public let unwrap: Optional<A>

	public init(_ value: Optional<A>) {
		self.unwrap = value
	}
}

extension Update: Equatable where A: Equatable {}

extension Update: EquatableInContext where A: EquatableInContext {
	public typealias Context = A.Context
}

extension Update: Semigroup {
	public static func <> (lhs: Update, rhs: Update) -> Update {
		return Update(rhs.unwrap ?? lhs.unwrap)
	}
}

extension Update: Monoid {
	public static var empty: Update {
		return Update(nil)
	}
}
