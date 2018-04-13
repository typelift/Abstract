/*:
# Isomorphism

In the context of abstract algebra, an *isomomorphism* (from ancient greek: "equal shape") is a *homomorphism* with an inverse operation such that applying both the direct and inverse operations maps an object to itself.

But for all means and purposes it's more convenient to just define an isomorphism by explicitly giving the two operations - defined as inverse to each other - and verifying that applying both produces an object that's equal to the starting one.
*/

extension Law {
	public static func isIsomorphism<A>(_ direct: @escaping (Element) -> A, _ inverse: @escaping (A) -> Element, _ a: Element) -> Bool {
		return inverse(direct(a)) == a
	}
}

extension LawInContext {
	public static func isIsomorphism<A>(_ direct: @escaping (Element) -> A, _ inverse: @escaping (A) -> Element, _ a: Element) -> (Element.Context) -> Bool {
		return inverse(direct(a)) == a
	}
}
