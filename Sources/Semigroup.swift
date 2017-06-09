/*:
# Semigroup

A Semigroup is a Magma where the composition operation is associative.
*/

public protocol Semigroup: Magma {}

extension Law where Element: Semigroup {
	public static func associativity(_ a: Element, _ b: Element, _ c: Element) -> Bool {
		return (a <> b <> c) == (a <> (b <> c))
	}
}
