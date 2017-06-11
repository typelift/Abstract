/*:
# Predicate

A `Predicate` is a function from any type to `Bool`: it usually represent an assertion that some property is true or false for an instance of a particular type.

Because `Bool` is a `Monoid`, we can express a predicate with a typealias of `FunctionM`, thus obtaining all the monoid properties.
*/

public typealias Predicate<A> = FunctionM<A,Bool>

extension Sequence {
	public func filtered(by predicate: Predicate<Iterator.Element>) -> [Iterator.Element] {
		return filter(predicate.call)
	}
}
