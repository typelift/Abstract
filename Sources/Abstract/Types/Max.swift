//
//  Max.swift
//  Abstract
//
//  Created by Elviro Rocca on 13/04/18.
//  Copyright © 2018 TypeLift. All rights reserved.
//

#if SWIFT_PACKAGE
	import Operadics
#endif

// sourcery: wrapperEquatable
// sourcery: fixedTypesForPropertyBasedTests = "Int"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "ComparableToBottom"
public struct Max<A>: Wrapper where A: ComparableToBottom {
	public typealias WrappedType = A

	public let unwrap: A

	public init(_ value: A) {
		self.unwrap = value
	}
}

extension Max: Semigroup {
	public static func <> (left: Max, right: Max) -> Max {
		return Max(max(left.unwrap, right.unwrap))
	}
}

extension Max: Monoid {
	public static var empty: Max<A> {
		return Max(A.min)
	}
}

extension Max: CommutativeMonoid {}

extension Max: BoundedSemilattice {}
