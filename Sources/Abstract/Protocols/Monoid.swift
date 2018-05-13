/*:
# Monoid

A Monoid is a Semigroup with a distinct element that acts as "empty" in respect to the operation.

The empty element (let's called it `e`) has to be neutral to the operation both from lhs and from rhs, thus:

a <> e = e <> a = a
*/

#if SWIFT_PACKAGE
    import Operadics
#endif

public protocol Monoid: Semigroup {
	static var empty: Self { get }
}

extension Law {
    public static func isNeutralToEmpty(_ a: Element, _ empty: Element, _ operation: (Element,Element) -> Element) -> Bool {
        return operation(a,empty) == a && operation(empty,a) == a
    }
}

extension Law where Element: Monoid {
	public static func isNeutralToEmpty(_ a: Element) -> Bool {
		return isNeutralToEmpty(a, .empty, <>)
	}
}

extension LawInContext {
    public static func isNeutralToEmpty(_ a: Element, _ empty: Element, _ operation: @escaping (Element,Element) -> Element) -> (Element.Context) -> Bool {
        return { (operation(a,empty) == a)($0) && (operation(empty,a) == a)($0) }
    }
}

extension LawInContext where Element: Monoid {
	public static func isNeutralToEmpty(_ a: Element) -> (Element.Context) -> Bool {
		return isNeutralToEmpty(a, .empty, <>)
	}
}
