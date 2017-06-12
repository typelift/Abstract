/*:
# Predicate

A `Predicate` is a function from any type to `And`: it usually represent an assertion that some property is true or false for an instance of a particular type.

Because `And` is a `BoundedSemilattice`, we can express a predicate with a typealias of `FunctionBS`, thus obtaining all the properties.
*/

public typealias Predicate<A> = FunctionBS<A,And>

extension Sequence {
	public func filtered(by predicate: Predicate<Iterator.Element>) -> [Iterator.Element] {
		return filter { predicate.call($0).value }
	}
}
