/*:
# Bounded Semilattice

A Bounded Semilattice is a Commutative Monoid in which the operation is idempotent (applying it twice is the same as applying it once), thus:

a <> b <> b = a <> b
*/

#if !XCODE_BUILD
    import Operadics
#endif
    
public protocol BoundedSemilattice: CommutativeMonoid {}

extension Law where Element: BoundedSemilattice {
	public static func isIdempotent(_ a: Element, _ b: Element) -> Bool {
		return (a <> b <> b) == (a <> b)
	}
}

extension LawInContext where Element: BoundedSemilattice {
	public static func isIdempotent(_ a: Element, _ b: Element) -> (Element.Context) -> Bool {
		return (a <> b <> b) == (a <> b)
	}
}

/*:
## Types
*/

extension Max: BoundedSemilattice {}

//: ------

extension Min: BoundedSemilattice {}

//: ------

extension And: BoundedSemilattice {}

//: ------

extension Or: BoundedSemilattice {}

//: ------

// sourcery: arbitraryFunction
// sourcery: arbitraryGenericParameterProtocols = "BoundedSemilattice & Equatable"
// sourcery: fixedTypesForPropertyBasedTests = "Int,TestStructure"
// sourcery: requiredContextForPropertyBasedTests = "Int"
public struct FunctionBS<A, M: BoundedSemilattice & Equatable>: Wrapper, BoundedSemilattice, EquatableInContext {
	public typealias Wrapped = (A) -> M
	public typealias Context = A

	public let unwrap: (A) -> M
	
	public init(_ value: @escaping (A) -> M) {
		self.unwrap = value
	}

	public var call: (A) -> M {
		return unwrap
	}

	public static func <> (left: FunctionBS, right: FunctionBS) -> FunctionBS {
		return FunctionBS.init { left.call($0) <> right.call($0) }
	}
	
	public static var empty: FunctionBS<A, M> {
		return FunctionBS { _ in M.empty }
	}
	
	public static func == (left: FunctionBS, right: FunctionBS) -> (Context) -> Bool {
		return { context in left.call(context) == right.call(context) }
	}
}
