// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import Abstract
import SwiftCheck


final class CommutativeMonoidTests: XCTestCase {

	func testAdd() {
		property("Add is a CommutativeMonoid") <- forAll { (a: AddOf<Int>, b: AddOf<Int>) in
			Law<Add<Int>>.isCommutative(a.get,b.get)
		}
	}

	func testAnd() {
		property("And is a CommutativeMonoid") <- forAll { (a: And, b: And) in
			Law<And>.isCommutative(a,b)
		}
	}

	func testFreeCommutativeMonoid() {
		property("FreeCommutativeMonoid is a CommutativeMonoid") <- forAll { (a: FreeCommutativeMonoidOf<TestStructure>, b: FreeCommutativeMonoidOf<TestStructure>) in
			Law<FreeCommutativeMonoid<TestStructure>>.isCommutative(a.get,b.get)
		}
	}

	func testFunction() {
		property("Function is a CommutativeMonoid") <- forAll { (a: FunctionOf<Int,TestSemiring>, b: FunctionOf<Int,TestSemiring>, context: Int) in
			LawInContext<Function<Int,TestSemiring>>.isCommutative(a.get,b.get)(context)
		}
	}

	func testMax() {
		property("Max is a CommutativeMonoid") <- forAll { (a: MaxOf<Int>, b: MaxOf<Int>) in
			Law<Max<Int>>.isCommutative(a.get,b.get)
		}
	}

	func testMin() {
		property("Min is a CommutativeMonoid") <- forAll { (a: MinOf<Int>, b: MinOf<Int>) in
			Law<Min<Int>>.isCommutative(a.get,b.get)
		}
	}

	func testMultiply() {
		property("Multiply is a CommutativeMonoid") <- forAll { (a: MultiplyOf<Int>, b: MultiplyOf<Int>) in
			Law<Multiply<Int>>.isCommutative(a.get,b.get)
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
		("testFunction",testFunction),
		("testMax",testMax),
		("testMin",testMin),
		("testMultiply",testMultiply),
		("testOr",testOr),
	]
}
