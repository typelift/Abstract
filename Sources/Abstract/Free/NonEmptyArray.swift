#if SWIFT_PACKAGE
	import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "Int"
public struct NonEmptyArray<A> {
	public let firstElement: A
	public let unwrap: [A]

	public init?(_ values: [A]) {
		guard let first = values.first else { return nil }
		self.firstElement = first
		self.unwrap = values
	}

	public init(_ value: A) {
		self.firstElement = value
		self.unwrap = [value]
	}

	public static func + (lhs: NonEmptyArray, rhs: NonEmptyArray) -> NonEmptyArray {
		return NonEmptyArray.init(lhs.unwrap + rhs.unwrap)!
	}
}

extension NonEmptyArray: Semigroup {
	public static func <> (lhs: NonEmptyArray<A>, rhs: NonEmptyArray<A>) -> NonEmptyArray<A> {
		return lhs + rhs
	}
}

public typealias FreeSemigroup<A> = NonEmptyArray<A>

extension NonEmptyArray: Equatable where A: Equatable {
	public static func == (lhs: NonEmptyArray<A>, rhs: NonEmptyArray<A>) -> Bool {
		return lhs.firstElement == rhs.firstElement
			&& lhs.unwrap == rhs.unwrap
	}
}

extension NonEmptyArray: EquatableInContext where A: EquatableInContext {
	public typealias Context = Element.Context

	public static func == (lhs: NonEmptyArray, rhs: NonEmptyArray) -> (Context) -> Bool {
		return { context in
			zip(lhs, rhs).lazy
				.map(==)
				.map { $0(context) }
				.first(where: { $0 == false })
				== nil
		}
	}
}

//MARK: - Conformance to Collection protocols

extension NonEmptyArray: Collection {
	public var startIndex: Int {
		return unwrap.startIndex
	}

	public var endIndex: Int {
		return unwrap.endIndex
	}

	public func index(after i: Int) -> Int {
		return unwrap.index(after: i)
	}

	public subscript(position: Int) -> A {
		return unwrap[position]
	}
}

extension NonEmptyArray: BidirectionalCollection {
	public func index(before i: Int) -> Int {
		return unwrap.index(before: i)
	}
}

extension NonEmptyArray: RandomAccessCollection {
	/// No other implementation is needed, beacuse Index (Int) is already Strideable
}
