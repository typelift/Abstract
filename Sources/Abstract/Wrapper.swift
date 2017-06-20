/*:
# Wrapper

And abstract definition for a type that wraps another, and guarantees both initialization with and access to the wrapped value.

For a wrapper to be *well-behaved* the requirement is that, by retrieving the `Wrapped` from a `Wrapper`, then constructing the `Wrapper` again with the retrieved value, we end up building the same `Wrapper` as before:

A.init(a.unwrap) == a

This means that `Wrapper.init` and `Wrapper.unwrap` must be inverse to each other, thus forming an *isomorphism*. This property is verified in `AbstractTests.swift` for all defined wrappers.
*/

public protocol Wrapper {
	associatedtype Wrapped

	init(_ value: Wrapped)

	var unwrap: Wrapped { get }
}

extension Law where Element: Wrapper {
	public static func isWellBehavedWrapper(_ a: Element) -> Bool {
		return Law.isIsomorphism({ $0.unwrap }, Element.init, a)
	}
}

extension LawInContext where Element: Wrapper {
	public static func isWellBehavedWrapper(_ a: Element) -> (Element.Context) -> Bool {
		return LawInContext.isIsomorphism({ $0.unwrap }, Element.init, a)
	}
}
