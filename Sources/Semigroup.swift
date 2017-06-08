/// a Semigroup is a Magma where the composition operation is associative

public protocol Semigroup: Magma, Equatable {}

/// The Equatable conformance is required by the associativity (we need to be able to say that something "is equal" to something else
/// The associativity requirement can be verified with a function the takes 3 random values of a type that is a Semigroup, and checks the operation

extension Law {
	public static func associative<T>(_ a: T, _ b: T, _ c: T) -> Bool where T: Semigroup {
		return a.composed(b).composed(c) == a.composed(b.composed(c))
	}
}
