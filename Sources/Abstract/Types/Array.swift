//
//  Array.swift
//  Abstract
//
//  Created by Elviro Rocca on 13/04/18.
//  Copyright © 2018 TypeLift. All rights reserved.
//

#if SWIFT_PACKAGE
	import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "TestStructure"
// sourcery: arbitrary
// sourcery: arbitraryGenericParameterProtocols = "Equatable"
extension Array: Monoid {
	public static var empty: Array {
		return []
	}

	public static func <> (left: Array, right: Array) -> Array {
		return left + right
	}
}
