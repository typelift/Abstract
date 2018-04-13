//
//  EndoFunction.swift
//  Abstract
//
//  Created by Elviro Rocca on 13/04/18.
//  Copyright © 2018 TypeLift. All rights reserved.
//

#if SWIFT_PACKAGE
	import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "Int"
// sourcery: requiredContextForPropertyBasedTests = "Int"
public struct Endofunction<A>: Wrapper {
	public typealias WrappedType = (A) -> A

	public let unwrap: (A) -> A

	public init(_ value: @escaping (A) -> A) {
		self.unwrap = value
	}

	public func call(_ value: A) -> A {
		return unwrap(value)
	}
}

extension Endofunction {
	public func toFunction() -> Function<A,A> {
		return Function<A,A>(unwrap)
	}
}

extension Endofunction: EquatableInContext where A: Equatable {
	public typealias Context = A

	public static func == (left: Endofunction, right: Endofunction) -> (Context) -> Bool {
		return { left.call($0) == right.call($0) }
	}
}

extension Endofunction: Semigroup {
	public static func <> (left: Endofunction, right: Endofunction) -> Endofunction {
		return Endofunction.init { right.call(left.call($0)) }
	}
}

extension Endofunction: Monoid {
	public static var empty: Endofunction<A> {
		return Endofunction<A> { $0 }
	}
}
