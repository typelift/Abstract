// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import Abstract
import SwiftCheck


final class WrapperTests: XCTestCase {

	func testAdd() {
		property("Add is a well-behaved Wrapper") <- forAll { (a: Add<Int>) in
			Law<Add<Int>>.isWellBehavedWrapper(a)
		}
	}

	func testAnd() {
		property("And is a well-behaved Wrapper") <- forAll { (a: And) in
			Law<And>.isWellBehavedWrapper(a)
		}
	}

	func testEndofunction() {
		property("Endofunction is a well-behaved Wrapper") <- forAll { (a: Endofunction<Int>, context: Int) in
			LawInContext<Endofunction<Int>>.isWellBehavedWrapper(a)(context)
		}
	}

	func testFirst() {
		property("First is a well-behaved Wrapper") <- forAll { (a: First<Int>) in
			Law<First<Int>>.isWellBehavedWrapper(a)
		}
	}

	func testLast() {
		property("Last is a well-behaved Wrapper") <- forAll { (a: Last<Int>) in
			Law<Last<Int>>.isWellBehavedWrapper(a)
		}
	}

	func testMax() {
		property("Max is a well-behaved Wrapper") <- forAll { (a: Max<Int>) in
			Law<Max<Int>>.isWellBehavedWrapper(a)
		}
	}

	func testMin() {
		property("Min is a well-behaved Wrapper") <- forAll { (a: Min<Int>) in
			Law<Min<Int>>.isWellBehavedWrapper(a)
		}
	}

	func testMultiply() {
		property("Multiply is a well-behaved Wrapper") <- forAll { (a: Multiply<Int>) in
			Law<Multiply<Int>>.isWellBehavedWrapper(a)
		}
	}

	func testOr() {
		property("Or is a well-behaved Wrapper") <- forAll { (a: Or) in
			Law<Or>.isWellBehavedWrapper(a)
		}
	}

	func testTropical() {
		property("Tropical is a well-behaved Wrapper") <- forAll { (a: Tropical<Int>) in
			Law<Tropical<Int>>.isWellBehavedWrapper(a)
		}
	}

	func testUpdate() {
		property("Update is a well-behaved Wrapper") <- forAll { (a: Update<Int>) in
			Law<Update<Int>>.isWellBehavedWrapper(a)
		}
	}

	static var allTests = [
		("testAdd",testAdd),
		("testAnd",testAnd),
		("testEndofunction",testEndofunction),
		("testFirst",testFirst),
		("testLast",testLast),
		("testMax",testMax),
		("testMin",testMin),
		("testMultiply",testMultiply),
		("testOr",testOr),
		("testTropical",testTropical),
		("testUpdate",testUpdate),
	]
}
