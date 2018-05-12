/*:
A Tropical semiring is just a fancy name for a (min, +)-semiring. This semiring is called tropical to honor the Brazillian mathematician, Imre Simon, who founded tropical mathematics.
*/

// sourcery: fixedTypesForPropertyBasedTests = "Int"
// sourcery: arbitrary
// sourcery: constrainedArbitraryParameter = "A"
// sourcery: arbitraryGenericParameterProtocols = "ComparableToTop & Addable"
public struct Tropical<A>: Wrapper, AutoSemiringWrapper where A: ComparableToTop & Addable {
	public typealias WrappedType = A
	public typealias Additive = Min<A>
	public typealias Multiplicative = Add<A>

	public let unwrap: A

	public init(_ value: A) {
		self.unwrap = value
	}
}

extension Tropical: Equatable where A: Equatable {}

extension Tropical: EquatableInContext where A: EquatableInContext {
	public typealias Context = A.Context
}
