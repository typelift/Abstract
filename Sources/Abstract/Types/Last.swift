//
//  Last.swift
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
// sourcery: arbitraryGenericParameterProtocols = "Equatable"
public struct Last<A>: Wrapper {
	public typealias WrappedType = A

	public let unwrap: A

	public init(_ value: A) {
		self.unwrap = value
	}
}

extension Last: Semigroup {
	public static func <> (left: Last, right: Last) -> Last {
		return right
	}
}
