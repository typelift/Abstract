/*:
# Wrapper

And abstract definition for a type that wraps another, and guarantees both initialization with and access to the wrapped value.

The requirement is that, by constructing a `Wrapper` with a certain `Wrapped`, we can retrieve exactly the same value, thus:

Wrapped(object).value == object

In a sense it means that the function `Wrapper.init(_:)` is isomorphic: from an instance of `Wrapper` I can always get a `Wrapped` and viceversa.
*/

public protocol Wrapper {
	associatedtype Wrapped

	init(_ value: Wrapped)

	var value: Wrapped { get }
}

extension Law where Element: Wrapper, Element.Wrapped: Equatable {
	public static func isIsomorphic(_ a: Element.Wrapped) -> Bool {
		return Element.init(a).value == a
	}
}

extension LawInContext where Element: Wrapper {
	public static func isIsomorphic(_ a: Element.Wrapped, isEqual: (Element.Wrapped,Element.Wrapped) -> (Element.Context) -> Bool) -> (Element.Context) -> Bool {
		return isEqual(Element.init(a).value,a)
	}
}
