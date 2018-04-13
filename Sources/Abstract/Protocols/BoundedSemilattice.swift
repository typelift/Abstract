/*:
# Bounded Semilattice

A Bounded Semilattice is a Commutative Monoid in which the operation is idempotent (applying it twice is the same as applying it once), thus:

a <> b <> b = a <> b
*/

#if SWIFT_PACKAGE
    import Operadics
#endif
    
public protocol BoundedSemilattice: CommutativeMonoid {}

extension Law where Element: BoundedSemilattice {
	public static func isIdempotent(_ a: Element, _ b: Element) -> Bool {
		return (a <> b <> b) == (a <> b)
	}
}

extension LawInContext where Element: BoundedSemilattice {
	public static func isIdempotent(_ a: Element, _ b: Element) -> (Element.Context) -> Bool {
		return (a <> b <> b) == (a <> b)
	}
}
