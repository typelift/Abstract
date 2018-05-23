import XCTest
@testable import Abstract
import SwiftCheck

final class MultisetTests: XCTestCase {

	func testAlgebraSubsetSuperset() {
		property("A multiset with a sample of elements from another is subset of another") <- forAll { (a: Multiset<Int>) in
			var sample = Multiset<Int>()
			let maxCount = Gen.fromElements(in: 0...a.count).generate

			for item in a.allItems where sample.count < maxCount {
				sample.add(item)
			}

			return sample.isSubset(a)
		}

		property("An enlarged multiset based on another is superset of another") <- forAll { (a: Multiset<Int>, more: Array<Int>) in
			var enlarged = a

			for item in more {
				enlarged.add(item)
			}

			return enlarged.isSuperset(a)
		}
	}

	func testAlgebraDisjointUnion() {
		property("Count of elements is added on multiset disjoint union") <- forAll { (a: Multiset<Int>, b: Multiset<Int>) in
			a.disjointUnion(b).count == a.count + b.count
		}

		property("Each multiset is subset of a multiset disjoint union") <- forAll { (a: Multiset<Int>, b: Multiset<Int>) in
			let union = a.disjointUnion(b)

			return a.isSubset(union)
				&& b.isSubset(union)
		}
	}

	func testAlgebraSubtraction() {
		property("Count of elements is less that or equal on multiset subtraction") <- forAll { (a: Multiset<Int>, b: Multiset<Int>) in
			a.subtraction(b).count <= a.count
		}

		property("A multiset is superset of a multiset subtraction") <- forAll { (a: Multiset<Int>, b: Multiset<Int>) in
			let subtraction = a.subtraction(b)

			return a.isSuperset(subtraction)
		}
	}

	func testAlgebraUnion() {
		property("Count of elements is greater than or equal on multiset union") <- forAll { (a: Multiset<Int>, b: Multiset<Int>) in
			let union = a.union(b)

			return union.count >= a.count
				&& union.count >= b.count
		}

		property("Each multiset is subset of a multiset union") <- forAll { (a: Multiset<Int>, b: Multiset<Int>) in
			let union = a.union(b)

			return a.isSubset(union)
				&& b.isSubset(union)
		}
	}

	func testAlgebraIntersection() {
		property("Count of elements is less that or equal on multiset intersection") <- forAll { (a: Multiset<Int>, b: Multiset<Int>) in
			let intersection = a.intersection(b)

			return intersection.count <= a.count
				&& intersection.count <= b.count
		}

		property("Each multiset is superset of a multiset intersection") <- forAll { (a: Multiset<Int>, b: Multiset<Int>) in
			let intersection = a.intersection(b)

			return a.isSuperset(intersection)
				&& b.isSuperset(intersection)
		}
	}

	static var allTests = [
		("testAlgebraSubsetSuperset",testAlgebraSubsetSuperset),
		("testAlgebraDisjointUnion",testAlgebraDisjointUnion),
		("testAlgebraSubtraction",testAlgebraSubtraction),
		("testAlgebraUnion",testAlgebraUnion),
		("testAlgebraIntersection",testAlgebraIntersection)
	]
}
