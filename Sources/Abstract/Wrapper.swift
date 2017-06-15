/*:
# Wrapper

And abstract definition for a type that wraps another, and guarantees both initialization with and access to the wrapped value.

The requirement is that, by constructing a `Wrapper` with a certain `Wrapped`, we can retrieve exactly the same value, thus:

Wrapped(object).unwrap == object

In a sense it means that the values `Wrapper` and `Wrapped` are *isomorphic*: from an instance of `Wrapper` I can always get a `Wrapped`, then go back to the exact same `Wrapper`, and viceversa. This also means that the functions `Wrapper.init(_:)` and `Wrapper.unwrap` are the inverse of each other, thus forming an *isomorphism*.
*/

public protocol Wrapper {
	associatedtype Wrapped

	init(_ value: Wrapped)

	var unwrap: Wrapped { get }
}

extension Law where Element: Wrapper, Element.Wrapped: Equatable {
	public static func isIsomorphic(_ a: Element.Wrapped) -> Bool {
		return Element.init(a).unwrap == a
	}
}

extension LawInContext where Element: Wrapper {
	public static func isIsomorphic(_ a: Element.Wrapped, isEqual: (Element.Wrapped,Element.Wrapped) -> (Element.Context) -> Bool) -> (Element.Context) -> Bool {
		return isEqual(Element.init(a).unwrap,a)
	}
}
