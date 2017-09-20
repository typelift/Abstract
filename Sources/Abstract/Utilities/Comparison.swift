/*:
# Comparison

A `Comparison` is a function from any tuple of equal types that are `Comparable` (so, in a total order) to `Ordering`: it tells us which value of the tuple is greater than the other, or eventually if they are ordered the same.

Because `Ordering` is a `Monoid`, we can express a comparison with a typealias of `FunctionM`, thus obtaining all the monoid properties.
*/

public typealias Comparison<A> = FunctionM<(A,A),Ordering>

extension Comparable {
	public static var comparison: Comparison<Self> {
		return .init { (left, right) in
			if left < right {
				return .lowerThan
			} else if left > right {
				return .greaterThan
			} else {
				return .equalTo
			}
		}
	}
}

extension Sequence {
	public func ordered(by comparison: Comparison<Iterator.Element>) -> [Iterator.Element] {
		return sorted { comparison.call(($0,$1)) == .lowerThan }
	}
}
