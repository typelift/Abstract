//
//  Ordering.swift
//  Abstract
//
//  Created by Elviro Rocca on 13/04/18.
//  Copyright © 2018 TypeLift. All rights reserved.
//

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
	public static func <> (left: Ordering, right: Ordering) -> Ordering {
		switch (left,right) {
		case (.lowerThan,_):
			return left
		case (.equalTo,_):
			return right
		case (.greaterThan,_):
			return left
		}
	}
}

extension Ordering: Monoid {
	public static var empty: Ordering {
		return .equalTo
	}
}
