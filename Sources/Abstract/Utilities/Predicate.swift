/*:
# Predicate

A `Predicate` is a function from any type to `Bool`: it usually represent an assertion that some property is true or false for an instance of a particular type.

Because `And` and `Or` are `BoundedSemilattice`, we can express a predicate with a typealias of `FunctionBS`, thus obtaining all the properties.

A full `Predicate` returns a `Bool`, that is a `Semiring`, so we can get a `Semiring` predicate with a typealias of `FunctionSR`.
*/

public typealias PredicateAnd<A> = FunctionBS<A,And>

extension Sequence {
	public func filtered(by predicate: PredicateAnd<Iterator.Element>) -> [Iterator.Element] {
		return filter { predicate.call($0).unwrap }
	}
}

public typealias PredicateOr<A> = FunctionBS<A,Or>

extension Sequence {
	public func filtered(by predicate: PredicateOr<Iterator.Element>) -> [Iterator.Element] {
		return filter { predicate.call($0).unwrap }
	}
}

public typealias Predicate<A> = FunctionSR<A,Bool>

extension Sequence {
	public func filtered(by predicate: Predicate<Iterator.Element>) -> [Iterator.Element] {
		return filter { predicate.call($0) }
	}
}
