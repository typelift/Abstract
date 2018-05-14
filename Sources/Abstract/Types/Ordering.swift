#if SWIFT_PACKAGE
	import Operadics
#endif

// sourcery: arbitrary
public enum Ordering {
	case lowerThan
	case equalTo
	case greaterThan
}

/// tested for isomorphism
extension Ordering {
	public func reversed() -> Ordering {
		switch self {
		case .lowerThan:
			return .greaterThan
		case .equalTo:
			return .equalTo
		case .greaterThan:
			return .lowerThan
		}
	}
}

extension Ordering: Semigroup {
	public static func <> (lhs: Ordering, rhs: Ordering) -> Ordering {
		switch (lhs,rhs) {
		case (.lowerThan,_):
			return lhs
		case (.equalTo,_):
			return rhs
		case (.greaterThan,_):
			return lhs
		}
	}
}

extension Ordering: Monoid {
	public static var empty: Ordering {
		return .equalTo
	}
}
