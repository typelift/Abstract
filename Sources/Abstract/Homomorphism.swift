#if SWIFT_PACKAGE
    import Operadics
#endif

/*:
# Homomorphism

Homomorphisms are structure-preserving maps between two algebraic structures of the same type: the word comes from ancient greek and means that it "preserves shape".

A way of graphically visualizing this is that the square consisting of such morphism and the compose operations must **commute**.

  .(A)-------[composition]----->.(B)
  |                             |
  |                             |
  |                  THIS       |
  [transformation]   MUST       [transformation]
  |                  COMMUTE    |
  |                             |
  \/                            \/
  .(A_T)-----[composition]----->.(B_T)

In other words, applying composition between 2 objects and then transforming the result must be the same as tranforming them separately and then composing.
*/

extension Law where Element: Magma {
	public static func isHomomorphism(_ transform: @escaping (Element) -> Element, _ a: Element, _ b: Element) -> Bool {
		return transform(a <> b) == (transform(a) <> transform(b))
	}
}

extension LawInContext where Element: Magma {
	public static func isHomomorphism(_ transform: @escaping (Element) -> Element, _ a: Element, _ b: Element) -> (Element.Context) -> Bool {
		return transform(a <> b) == (transform(a) <> transform(b))
	}
}

//: ------

extension Ordering {
	public var reversed: Ordering {
		switch self {
		case .lowerThan:
			return .greaterThan
		case .equalTo:
			return .equalTo
		case .greaterThan:
			return .lowerThan
		}
	}
}

//: ------

extension FunctionM where M == Ordering {
	public var reversed: FunctionM {
		return FunctionM { self.call($0).reversed }
	}
}
