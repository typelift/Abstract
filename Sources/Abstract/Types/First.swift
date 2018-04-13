//
//  First.swift
//  Abstract
//
//  Created by Elviro Rocca on 13/04/18.
//  Copyright © 2018 TypeLift. All rights reserved.
//

import Foundation

// sourcery: wrapperEquatable
// sourcery: fixedTypesForPropertyBasedTests = "Int"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "Equatable"
public struct First<A>: Wrapper {
	public typealias WrappedType = A

	public let unwrap: A

	public init(_ value: A) {
		self.unwrap = value
	}
}

extension First: Semigroup {
	public static func <> (left: First, right: First) -> First {
		return left
	}
}
