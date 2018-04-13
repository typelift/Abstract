// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import Abstract
import SwiftCheck


final class MonoidTests: XCTestCase {

	func testAdd() {
		property("Add is a Monoid") <- forAll { (a: AddOf<Int>) in
			Law<Add<Int>>.isNeutralToEmpty(a.get)
		}
	}

	func testAnd() {
		property("And is a Monoid") <- forAll { (a: And) in
			Law<And>.isNeutralToEmpty(a)
		}
	}

	func testArray() {
		property("Array is a Monoid") <- forAll { (a: Array) in
			Law<Array>.isNeutralToEmpty(a)
		}
	}

	func testEndofunction() {
		property("Endofunction is a Monoid") <- forAll { (a: EndofunctionOf<Int>, context: Int) in
			LawInContext<Endofunction<Int>>.isNeutralToEmpty(a.get)(context)
		}
	}

	func testFreeCommutativeMonoid() {
		property("FreeCommutativeMonoid is a Monoid") <- forAll { (a: FreeCommutativeMonoidOf<TestStructure>) in
			Law<FreeCommutativeMonoid<TestStructure>>.isNeutralToEmpty(a.get)
		}
	}

	func testFreeMonoid() {
		property("FreeMonoid is a Monoid") <- forAll { (a: FreeMonoidOf<TestStructure>) in
			Law<FreeMonoid<TestStructure>>.isNeutralToEmpty(a.get)
		}
	}

	func testFunction() {
		property("Function is a Monoid") <- forAll { (a: FunctionOf<Int,TestSemiring>, context: Int) in
			LawInContext<Function<Int,TestSemiring>>.isNeutralToEmpty(a.get)(context)
		}
	}

	func testMax() {
		property("Max is a Monoid") <- forAll { (a: MaxOf<Int>) in
			Law<Max<Int>>.isNeutralToEmpty(a.get)
		}
	}

	func testMin() {
		property("Min is a Monoid") <- forAll { (a: MinOf<Int>) in
			Law<Min<Int>>.isNeutralToEmpty(a.get)
		}
	}

	func testMultiply() {
		property("Multiply is a Monoid") <- forAll { (a: MultiplyOf<Int>) in
			Law<Multiply<Int>>.isNeutralToEmpty(a.get)
		}
	}

	func testOptional() {
		property("Optional is a Monoid") <- forAll { (a: Optional) in
			Law<Optional>.isNeutralToEmpty(a)
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
		property("Update is a Monoid") <- forAll { (a: UpdateOf<>) in
			Law<Update<>>.isNeutralToEmpty(a.get)
		}
	}

	static var allTests = [
		("testAdd",testAdd),
		("testAnd",testAnd),
		("testArray",testArray),
		("testEndofunction",testEndofunction),
		("testFreeCommutativeMonoid",testFreeCommutativeMonoid),
		("testFreeMonoid",testFreeMonoid),
		("testFunction",testFunction),
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
