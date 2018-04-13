/*:
# Monoid

A Monoid is a Semigroup with a distinct element that acts as "empty" in respect to the operation.

The empty element (let's called it `e`) has to be neutral to the operation both from left and from right, thus:

a <> e = e <> a = a
*/

#if SWIFT_PACKAGE
    import Operadics
#endif

public protocol Monoid: Semigroup {
	static var empty: Self { get }
}

extension Law where Element: Monoid {
	public static func isNeutralToEmpty(_ a: Element) -> Bool {
		return (a <> .empty) == a && (.empty <> a) == a
	}
}

extension LawInContext where Element: Monoid {
	public static func isNeutralToEmpty(_ a: Element) -> (Element.Context) -> Bool {
		return { ((a <> .empty) == a)($0) && ((.empty <> a) == a)($0) }
	}
}
