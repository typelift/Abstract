#if SWIFT_PACKAGE
	import Operadics
#endif

public struct Multiset<A>: Equatable where A: Hashable {
	private var storage: [A : Int] = [:]
	public private(set) var count = 0

	public init() {}

	public init <S> (_ sequence: S) where S: Sequence, S.Iterator.Element == A {
		self.init()
		for item in sequence {
			self.add(item)
		}
	}

	public mutating func add(_ item: A) {
		storage[item, default: 0] += 1
		count += 1
	}

	public mutating func remove(_ item: A) {
		if let currentCount = storage[item] {
			if currentCount > 1 {
				storage[item, default: 2] -= 1
			} else {
				storage[item] = nil
			}
			count -= 1
		}
	}

	public mutating func removeAll(_ item: A) {
		while self.contains(item) {
			remove(item)
		}
	}

	public func count(of item: A) -> Int {
		return storage[item] ?? 0
	}

	public func contains(_ item: A) -> Bool {
		return count(of: item) > 0
	}

	public var anyItem: A? {
		return storage.keys.first
	}

	public var allItems: [A] {
		return Array(storage)
			.flatMap {
				Array.init(repeating: $0.key, count: $0.value)
		}
	}

	public struct Iterator: IteratorProtocol {
		private var multiSet: Multiset
		public init(_ multiSet: Multiset) {
			self.multiSet = multiSet
		}

		public mutating func next() -> (A, Int)? {
			guard let anyItem = multiSet.anyItem else { return nil }
			let count = multiSet.count(of: anyItem)
			multiSet.removeAll(anyItem)
			return (anyItem,count)
		}
	}
}

extension Multiset: ExpressibleByArrayLiteral {
	public init(arrayLiteral elements: A...) {
		self.init(elements)
	}
}

extension Multiset: Sequence {
	public func makeIterator() -> Multiset.Iterator {
		return Multiset.Iterator(self)
	}
}

// sourcery: fixedTypesForPropertyBasedTests = "Int"
extension Multiset: CommutativeMonoid {
	public static var empty: Multiset {
		return []
	}

	public static func <> (lhs: Multiset, rhs: Multiset) -> Multiset {
		return lhs.disjointUnion(rhs)
	}
}

public typealias FreeCommutativeMonoid<A> = Multiset<A> where A: Hashable

//MARK: - Algebra

public extension Multiset {
	func disjointUnion(_ other: Multiset) -> Multiset {
		var m_self = self
		for item in other.allItems {
			m_self.add(item)
		}
		return m_self
	}

	func subtraction(_ other: Multiset) -> Multiset {
		var m_self = self
		for item in other.allItems {
			m_self.remove(item)
		}
		return m_self
	}

	func union(_ other: Multiset) -> Multiset {
		var m_new = Multiset()

		for (item, count) in self {
			let newCount = Swift.max(count, other.count(of: item))
			if newCount > 0 {
				(0..<newCount).forEach { _ in
					m_new.add(item)
				}
			}
		}

		for (item, count) in other where self.contains(item) == false {
			(0..<count).forEach { _ in
				m_new.add(item)
			}
		}

		return m_new
	}

	func intersection(_ other: Multiset) -> Multiset {
		var m_new = Multiset()

		for (item, count) in self {
			let newCount = Swift.min(count, other.count(of: item))
			if newCount > 0 {
				(0..<newCount).forEach { _ in
					m_new.add(item)
				}
			}
		}

		return m_new
	}

	func isSubset(_ other: Multiset) -> Bool {
		for (element,count) in self where other.count(of: element) < count {
			return false
		}
		return true
	}

	func isSuperset(_ other: Multiset) -> Bool {
		for (element,count) in other where self.count(of: element) < count {
			return false
		}
		return true
	}
}
