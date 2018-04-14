// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import Abstract
import SwiftCheck


final class CommutativeMonoidTests: XCTestCase {

	func testAdd() {
		property("Add is a CommutativeMonoid") <- forAll { (a: Add<Int>, b: Add<Int>) in
			Law<Add<Int>>.isCommutative(a,b)
		}
	}

	func testAnd() {
		property("And is a CommutativeMonoid") <- forAll { (a: And, b: And) in
			Law<And>.isCommutative(a,b)
		}
	}

	func testFreeCommutativeMonoid() {
		property("FreeCommutativeMonoid is a CommutativeMonoid") <- forAll { (a: FreeCommutativeMonoid<Int>, b: FreeCommutativeMonoid<Int>) in
			Law<FreeCommutativeMonoid<Int>>.isCommutative(a,b)
		}
	}

	func testMax() {
		property("Max is a CommutativeMonoid") <- forAll { (a: Max<Int>, b: Max<Int>) in
			Law<Max<Int>>.isCommutative(a,b)
		}
	}

	func testMin() {
		property("Min is a CommutativeMonoid") <- forAll { (a: Min<Int>, b: Min<Int>) in
			Law<Min<Int>>.isCommutative(a,b)
		}
	}

	func testMultiply() {
		property("Multiply is a CommutativeMonoid") <- forAll { (a: Multiply<Int>, b: Multiply<Int>) in
			Law<Multiply<Int>>.isCommutative(a,b)
		}
	}

	func testOr() {
		property("Or is a CommutativeMonoid") <- forAll { (a: Or, b: Or) in
			Law<Or>.isCommutative(a,b)
		}
	}

	static var allTests = [
		("testAdd",testAdd),
		("testAnd",testAnd),
		("testFreeCommutativeMonoid",testFreeCommutativeMonoid),
		("testMax",testMax),
		("testMin",testMin),
		("testMultiply",testMultiply),
		("testOr",testOr),
	]
}
