/*:
# Commutative Monoid

A Commutative Monoid is a Monoid in which the operation is commutative, thus:

a <> b = b <> a
*/

#if SWIFT_PACKAGE
    import Operadics
#endif
    
public protocol CommutativeMonoid: Monoid {}

extension Law {
    public static func isCommutative(_ a: Element, _ b: Element, _ operation: (Element,Element) -> Element) -> Bool {
        return operation(a,b) == operation(b,a)
    }
}

extension Law where Element: CommutativeMonoid {
	public static func isCommutative(_ a: Element, _ b: Element) -> Bool {
		return isCommutative(a, b, <>)
	}
}

extension LawInContext {
    public static func isCommutative(_ a: Element, _ b: Element, _ operation: (Element,Element) -> Element) -> (Element.Context) -> Bool {
        return operation(a,b) == operation(b,a)
    }
}

extension LawInContext where Element: CommutativeMonoid {
	public static func isCommutative(_ a: Element, _ b: Element) -> (Element.Context) -> Bool {
		return isCommutative(a, b, <>)
	}
}
