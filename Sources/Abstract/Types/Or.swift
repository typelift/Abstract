//
//  Or.swift
//  Abstract
//
//  Created by Elviro Rocca on 13/04/18.
//  Copyright © 2018 TypeLift. All rights reserved.
//

#if SWIFT_PACKAGE
	import Operadics
#endif

// sourcery: arbitrary
public struct Or: Wrapper, Equatable {
	public typealias WrappedType = Bool

	public let unwrap: Bool

	public init(_ value: Bool) {
		self.unwrap = value
	}
}

extension Or: ExpressibleByBooleanLiteral {
	public typealias BooleanLiteralType = Bool

	public init(booleanLiteral value: BooleanLiteralType) {
		self.init(value)
	}
}

extension Or: Semigroup {
	public static func <> (left: Or, right: Or) -> Or {
		return Or(left.unwrap || right.unwrap)
	}
}

extension Or: Monoid {
	public static var empty: Or {
		return false
	}
}

extension Or: CommutativeMonoid {}

extension Or: BoundedSemilattice {}
