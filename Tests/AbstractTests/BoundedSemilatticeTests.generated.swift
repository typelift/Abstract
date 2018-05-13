// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import Abstract
import SwiftCheck


final class BoundedSemilatticeTests: XCTestCase {

	func testAnd() {
		property("And is a BoundedSemilattice") <- forAll { (a: And, b: And) in
			Law<And>.isIdempotent(a,b)
		}
	}

	func testMax() {
		property("Max is a BoundedSemilattice") <- forAll { (a: Max<Int>, b: Max<Int>) in
			Law<Max<Int>>.isIdempotent(a,b)
		}
	}

	func testMin() {
		property("Min is a BoundedSemilattice") <- forAll { (a: Min<Int>, b: Min<Int>) in
			Law<Min<Int>>.isIdempotent(a,b)
		}
	}

	func testOr() {
		property("Or is a BoundedSemilattice") <- forAll { (a: Or, b: Or) in
			Law<Or>.isIdempotent(a,b)
		}
	}

	func testProduct() {
		property("Product is a BoundedSemilattice") <- forAll { (a: Product<TestStructure,TestStructure>, b: Product<TestStructure,TestStructure>) in
			Law<Product<TestStructure,TestStructure>>.isIdempotent(a,b)
		}
	}

	func testSet() {
		property("Set is a BoundedSemilattice") <- forAll { (a: Set<Int>, b: Set<Int>) in
			Law<Set<Int>>.isIdempotent(a,b)
		}
	}

	static var allTests = [
		("testAnd",testAnd),
		("testMax",testMax),
		("testMin",testMin),
		("testOr",testOr),
		("testProduct",testProduct),
		("testSet",testSet),
	]
}
