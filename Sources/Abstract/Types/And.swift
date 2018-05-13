#if SWIFT_PACKAGE
	import Operadics
#endif

// sourcery: arbitrary
public struct And: Wrapper, Equatable {
	public typealias WrappedType = Bool

	public let unwrap: Bool

	public init(_ value: Bool) {
		self.unwrap = value
	}
}

extension And: ExpressibleByBooleanLiteral {
	public typealias BooleanLiteralType = Bool

	public init(booleanLiteral value: BooleanLiteralType) {
		self.init(value)
	}
}

extension And: Semigroup {
	public static func <> (lhs: And, rhs: And) -> And {
		return And(lhs.unwrap && rhs.unwrap)
	}
}

extension And: Monoid {
	public static var empty: And {
		return true
	}
}

extension And: CommutativeMonoid {}

extension And: BoundedSemilattice {}

