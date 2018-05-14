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

	public static func == (lhs: Endofunction, rhs: Endofunction) -> (Context) -> Bool {
		return { lhs.call($0) == rhs.call($0) }
	}
}

extension Endofunction: Semigroup {
	public static func <> (lhs: Endofunction, rhs: Endofunction) -> Endofunction {
		return Endofunction.init { rhs.call(lhs.call($0)) }
	}
}

extension Endofunction: Monoid {
	public static var empty: Endofunction<A> {
		return Endofunction<A> { $0 }
	}
}
