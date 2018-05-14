/*:
# Wrapper

And abstract definition for a type that wraps another, and guarantees both initialization with and access to the wrapped value.

For a wrapper to be *well-behaved* the requirement is that, by retrieving the `WrappedType` from a `Wrapper`, then constructing the `Wrapper` again with the retrieved value, we end up building the same `Wrapper` as before:

A.init(a.unwrap) == a

This means that `Wrapper.init` and `Wrapper.unwrap` must be inverse to each other, thus forming an *isomorphism*. This property is verified in `AbstractTests.swift` for all defined wrappers.
*/

public protocol Wrapper {
	associatedtype WrappedType

	init(_ unwrap: WrappedType)

	var unwrap: WrappedType { get }
}

extension Wrapper {
	public init(unwrap: WrappedType) {
		self.init(unwrap)
	}
}

extension Law where Element: Wrapper {
	public static func isWellBehavedWrapper(_ a: Element) -> Bool {
		return Law.isIsomorphism({ $0.unwrap }, Element.init, a)
	}
}

extension LawInContext where Element: Wrapper {
	public static func isWellBehavedWrapper(_ a: Element) -> (Element.Context) -> Bool {
		return LawInContext.isIsomorphism({ $0.unwrap }, Element.init, a)
	}
}

/*:
If the `WrappedType` element is `Equatable` or `EquatableInContext`, we can define the static `==` function for a `Wrapper` (still, the `Equatable` or `EquatableInContext` conformance must be declared explicitly for every wrapper).
*/

extension Wrapper where WrappedType: Equatable {
	public static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.unwrap == rhs.unwrap
	}
}

extension Wrapper where WrappedType: EquatableInContext {
	public static func == (lhs: Self, rhs: Self) -> (WrappedType.Context) -> Bool {
		return lhs.unwrap == rhs.unwrap
	}
}

public func == <T,A> (lhs: T, rhs: T) -> Bool where T: Wrapper, T.WrappedType == A?, A: Equatable {
	return lhs.unwrap == rhs.unwrap
}

public func == <T,A> (lhs: T, rhs: T) -> Bool where T: Wrapper, T.WrappedType == [A], A: Equatable {
	return lhs.unwrap == rhs.unwrap
}

public func == <T,A> (lhs: T, rhs: T) -> (A.Context) -> Bool where T: Wrapper, T.WrappedType == A?, A: EquatableInContext {
	switch (lhs.unwrap,rhs.unwrap) {
	case (.some(let lhsUnwrap),.some(let rhsUnwrap)):
		return lhsUnwrap == rhsUnwrap
	case (.none,.none):
		return { _ in true }
	default:
		return { _ in false }
	}
}

public func == <T,A> (lhs: T, rhs: T) -> (A.Context) -> Bool where T: Wrapper, T.WrappedType == [A], A: EquatableInContext {
	return { context in
		guard lhs.unwrap.count == rhs.unwrap.count else { return false }
		return zip(lhs.unwrap, rhs.unwrap)
			.map(==)
			.map { $0(context) }
			.reduce(true) { $0 && $1 }
	}
}

/*:
If the `WrappedType` element conforms to `Collection`, we can induce the fundamental methods onto the wrapper (as for `Equatable`, we still need to declare conformance explicitly).
*/

extension Wrapper where WrappedType: Collection {
	public typealias Index = WrappedType.Index
	public typealias Element = WrappedType.Element

	public var startIndex: Index {
		return unwrap.startIndex
	}

	public var endIndex: Index {
		return unwrap.endIndex
	}

	public func index(after i: Index) -> Index {
		return unwrap.index(after: i)
	}

	public subscript(position: Index) -> Element {
		return unwrap[position]
	}
}
