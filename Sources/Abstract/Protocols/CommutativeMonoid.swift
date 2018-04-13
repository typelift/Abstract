/*:
# Commutative Monoid

A Commutative Monoid is a Monoid in which the operation is commutative, thus:

a <> b = b <> a
*/

#if SWIFT_PACKAGE
    import Operadics
#endif
    
public protocol CommutativeMonoid: Monoid {}

extension Law where Element: CommutativeMonoid {
	public static func isCommutative(_ a: Element, _ b: Element) -> Bool {
		return (a <> b) == (b <> a)
	}
}

extension LawInContext where Element: CommutativeMonoid {
	public static func isCommutative(_ a: Element, _ b: Element) -> (Element.Context) -> Bool {
		return (a <> b) == (b <> a)
	}
}
