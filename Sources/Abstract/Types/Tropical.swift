//
//  Tropical.swift
//  Abstract
//
//  Created by Elviro Rocca on 13/04/18.
//  Copyright © 2018 TypeLift. All rights reserved.
//

import Foundation

/*:
A Tropical semiring is just a fancy name for a (min, +)-semiring. This semiring is called tropical to honor the Brazillian mathematician, Imre Simon, who founded tropical mathematics.
*/

// sourcery: fixedTypesForPropertyBasedTests = "Int"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "ComparableToTop & Addable"
public struct Tropical<A: ComparableToTop & Addable & Equatable>: Wrapper, Semiring, Equatable {
	public typealias WrappedType = A
	public typealias Additive = Min<A>
	public typealias Multiplicative = Add<A>

	public let unwrap: A

	public init(_ value: A) {
		self.unwrap = value
	}
}
