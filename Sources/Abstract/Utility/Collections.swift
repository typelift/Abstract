/*:
# Collections

Becuase we have a way to generically "compose" things, we can derive a bunch of interesting operations on collections of such things.
*/

#if SWIFT_PACKAGE
    import Operadics
#endif

extension Sequence where Iterator.Element: Magma {
	public func concatenatedWith(initial: Iterator.Element) -> Iterator.Element {
		return reduce(initial, <>)
	}
}

extension Sequence where Iterator.Element: Monoid {
	public func concatenated() -> Iterator.Element {
		return concatenatedWith(initial: Iterator.Element.empty)
	}
}

extension Sequence {
    public static func cartesian <First,Second> (_ first: First, _ second: Second) -> Array<(First.Iterator.Element,Second.Iterator.Element)> where First: Sequence, Second: Sequence, Iterator.Element == (First.Iterator.Element,Second.Iterator.Element) {
        var cartesianProduct: Array<(First.Iterator.Element,Second.Iterator.Element)> = []
        cartesianProduct.reserveCapacity(first.underestimatedCount * second.underestimatedCount)
        
        for firstElement in first {
            for secondElement in second {
                cartesianProduct.append((firstElement,secondElement))
            }
        }
        
        return cartesianProduct
    }
}
