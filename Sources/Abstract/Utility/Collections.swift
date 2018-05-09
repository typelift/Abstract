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

extension Set {
    static func cartesianMerge <First,Second> (_ first: Set<First>, _ second: Set<Second>, _ merge: (First,Second) -> Element) -> Set {
        var cartesianProduct: Array<Element> = []
        cartesianProduct.reserveCapacity(first.count * second.count)

        for firstElement in first {
            for secondElement in second {
                cartesianProduct.append(merge(firstElement,secondElement))
            }
        }

        return Set(cartesianProduct)
    }
}
