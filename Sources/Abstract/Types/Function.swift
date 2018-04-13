//
//  Function.swift
//  Abstract
//
//  Created by Elviro Rocca on 13/04/18.
//  Copyright © 2018 TypeLift. All rights reserved.
//

#if SWIFT_PACKAGE
	import Operadics
#endif

public struct Function<A,B>: Wrapper {
	public typealias WrappedType = (A) -> B

	public let unwrap: (A) -> B

	public init(_ value: @escaping (A) -> B) {
		self.unwrap = value
	}

	public func call(_ value: A) -> B {
		return unwrap(value)
	}
}

/// this is tested for isomorphism
extension Function where B == Ordering {
	public func reversed() -> Function {
		return Function { self.call($0).reversed() }
	}
}

extension Function: EquatableInContext where B: Equatable {
	public typealias Context = A

	public static func == (left: Function, right: Function) -> (Context) -> Bool {
		return { left.call($0) == right.call($0) }
	}
}

extension Function: Magma where B: Magma {
	public static func <> (left: Function, right: Function) -> Function {
		return Function { left.call($0) <> right.call($0) }
	}
}

// sourcery: fixedTypesForPropertyBasedTests = "Int,TestStructure"
// sourcery: requiredContextForPropertyBasedTests = "Int"
// sourcery: arbitraryFunction
// sourcery: arbitraryGenericParameterProtocols = "Semigroup & Equatable"
extension Function: Semigroup where B: Semigroup {}

// sourcery: fixedTypesForPropertyBasedTests = "Int,TestStructure"
// sourcery: requiredContextForPropertyBasedTests = "Int"
// sourcery: arbitraryFunction
// sourcery: arbitraryGenericParameterProtocols = "Monoid & Equatable"
extension Function: Monoid where B: Monoid {
	public static var empty: Function {
		return Function { _ in B.empty }
	}
}

// sourcery: fixedTypesForPropertyBasedTests = "Int,TestStructure"
// sourcery: requiredContextForPropertyBasedTests = "Int"
// sourcery: arbitraryFunction
// sourcery: arbitraryGenericParameterProtocols = "CommutativeMonoid & Equatable"
extension Function: CommutativeMonoid where B: CommutativeMonoid {}

// sourcery: fixedTypesForPropertyBasedTests = "Int,TestStructure"
// sourcery: requiredContextForPropertyBasedTests = "Int"
// sourcery: arbitraryFunction
// sourcery: arbitraryGenericParameterProtocols = "BoundedSemilattice & Equatable"
extension Function: BoundedSemilattice where B: BoundedSemilattice {}

// sourcery: fixedTypesForPropertyBasedTests = "Int,TestSemiring"
// sourcery: requiredContextForPropertyBasedTests = "Int"
// sourcery: arbitraryFunction
// sourcery: arbitraryGenericParameterProtocols = "Semiring & Equatable"
// sourcery: additionalGenericParameterSubtypeRequirements = "Additive: Equatable"
// sourcery: additionalGenericParameterSubtypeRequirements = "Multiplicative: Equatable"
extension Function: Semiring where B: Semiring {
	public typealias Additive = Function<A,B.Additive>

	public typealias Multiplicative = Function<A,B.Multiplicative>

	public static func <>+ (left: Function<A, B>, right: Function<A, B>) -> Function<A, B> {
		return Function { left.call($0) <>+ right.call($0) }
	}

	public static func <>* (left: Function<A, B>, right: Function<A, B>) -> Function<A, B> {
		return Function { left.call($0) <>* right.call($0) }
	}

	public static var zero: Function<A, B> {
		return Function { _ in B.zero }
	}

	public static var one: Function<A, B> {
		return Function { _ in B.one }
	}
}

