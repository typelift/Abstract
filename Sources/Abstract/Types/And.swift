//
//  And.swift
//  Abstract
//
//  Created by Elviro Rocca on 13/04/18.
//  Copyright © 2018 TypeLift. All rights reserved.
//

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
	public static func <> (left: And, right: And) -> And {
		return And(left.unwrap && right.unwrap)
	}
}

extension And: Monoid {
	public static var empty: And {
		return true
	}
}

extension And: CommutativeMonoid {}

extension And: BoundedSemilattice {}

