// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import Abstract
import SwiftCheck


final class MonoidTests: XCTestCase {

	func testAdd() {
		property("Add is a Monoid") <- forAll { (a: Add<Int>) in
			Law<Add<Int>>.isNeutralToEmpty(a)
		}
	}

	func testAnd() {
		property("And is a Monoid") <- forAll { (a: And) in
			Law<And>.isNeutralToEmpty(a)
		}
	}

	func testArray() {
		property("Array is a Monoid") <- forAll { (a: Array<Int>) in
			Law<Array<Int>>.isNeutralToEmpty(a)
		}
	}

	func testEndofunction() {
		property("Endofunction is a Monoid") <- forAll { (a: Endofunction<Int>, context: Int) in
			LawInContext<Endofunction<Int>>.isNeutralToEmpty(a)(context)
		}
	}

	func testFreeBoundedSemilattice() {
		property("FreeBoundedSemilattice is a Monoid") <- forAll { (a: FreeBoundedSemilattice<Int>) in
			Law<FreeBoundedSemilattice<Int>>.isNeutralToEmpty(a)
		}
	}

	func testFreeCommutativeMonoid() {
		property("FreeCommutativeMonoid is a Monoid") <- forAll { (a: FreeCommutativeMonoid<Int>) in
			Law<FreeCommutativeMonoid<Int>>.isNeutralToEmpty(a)
		}
	}

	func testMax() {
		property("Max is a Monoid") <- forAll { (a: Max<Int>) in
			Law<Max<Int>>.isNeutralToEmpty(a)
		}
	}

	func testMin() {
		property("Min is a Monoid") <- forAll { (a: Min<Int>) in
			Law<Min<Int>>.isNeutralToEmpty(a)
		}
	}

	func testMultiply() {
		property("Multiply is a Monoid") <- forAll { (a: Multiply<Int>) in
			Law<Multiply<Int>>.isNeutralToEmpty(a)
		}
	}

	func testOptional() {
		property("Optional is a Monoid") <- forAll { (a: Optional<Int>) in
			Law<Optional<Int>>.isNeutralToEmpty(a)
		}
	}

	func testOr() {
		property("Or is a Monoid") <- forAll { (a: Or) in
			Law<Or>.isNeutralToEmpty(a)
		}
	}

	func testOrdering() {
		property("Ordering is a Monoid") <- forAll { (a: Ordering) in
			Law<Ordering>.isNeutralToEmpty(a)
		}
	}

	func testString() {
		property("String is a Monoid") <- forAll { (a: String) in
			Law<String>.isNeutralToEmpty(a)
		}
	}

	func testUpdate() {
		property("Update is a Monoid") <- forAll { (a: Update<Int>) in
			Law<Update<Int>>.isNeutralToEmpty(a)
		}
	}

	static var allTests = [
		("testAdd",testAdd),
		("testAnd",testAnd),
		("testArray",testArray),
		("testEndofunction",testEndofunction),
		("testFreeBoundedSemilattice",testFreeBoundedSemilattice),
		("testFreeCommutativeMonoid",testFreeCommutativeMonoid),
		("testMax",testMax),
		("testMin",testMin),
		("testMultiply",testMultiply),
		("testOptional",testOptional),
		("testOr",testOr),
		("testOrdering",testOrdering),
		("testString",testString),
		("testUpdate",testUpdate),
	]
}
