/*:
# Semigroup

A Semigroup is a Magma where the composition operation is associative, which means that multiple operations in sequence can happen in any time order.

To put it simply: (a <> b) <> c = a <> (b <> c)
*/

#if SWIFT_PACKAGE
    import Operadics
#endif

public protocol Semigroup: Magma {}

extension Law {
    public static func isAssociative(_ a: Element, _ b: Element, _ c: Element, _ operation: (Element,Element) -> Element) -> Bool {
        return operation(operation(a,b),c) == operation(a,operation(b,c))
    }
}

extension Law where Element: Semigroup {
	public static func isAssociative(_ a: Element, _ b: Element, _ c: Element) -> Bool {
		return isAssociative(a, b, c, <>)
	}
}

extension LawInContext {
    public static func isAssociative(_ a: Element, _ b: Element, _ c: Element, _ operation: (Element,Element) -> Element) -> (Element.Context) -> Bool {
        return operation(operation(a,b),c) == operation(a,operation(b,c))
    }
}

extension LawInContext where Element: Semigroup {
	public static func isAssociative(_ a: Element, _ b: Element, _ c: Element) -> (Element.Context) -> Bool {
        return isAssociative(a, b, c, <>)
	}
}
