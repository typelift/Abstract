// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import Abstract
import SwiftCheck


final class WrapperTests: XCTestCase {

	func testAdd() {
		property("Add is a well-behaved Wrapper") <- forAll { (a: AddOf<Int>) in
			Law<Add<Int>>.isWellBehavedWrapper(a.get)
		}
	}

	func testAnd() {
		property("And is a well-behaved Wrapper") <- forAll { (a: And) in
			Law<And>.isWellBehavedWrapper(a)
		}
	}

	func testEndofunction() {
		property("Endofunction is a well-behaved Wrapper") <- forAll { (a: EndofunctionOf<Int>, context: Int) in
			LawInContext<Endofunction<Int>>.isWellBehavedWrapper(a.get)(context)
		}
	}

	func testFirst() {
		property("First is a well-behaved Wrapper") <- forAll { (a: FirstOf<Int>) in
			Law<First<Int>>.isWellBehavedWrapper(a.get)
		}
	}

	func testFreeCommutativeMonoid() {
		property("FreeCommutativeMonoid is a well-behaved Wrapper") <- forAll { (a: FreeCommutativeMonoidOf<TestStructure>) in
			Law<FreeCommutativeMonoid<TestStructure>>.isWellBehavedWrapper(a.get)
		}
	}

	func testFreeMonoid() {
		property("FreeMonoid is a well-behaved Wrapper") <- forAll { (a: FreeMonoidOf<TestStructure>) in
			Law<FreeMonoid<TestStructure>>.isWellBehavedWrapper(a.get)
		}
	}

	func testFreeSemigroup() {
		property("FreeSemigroup is a well-behaved Wrapper") <- forAll { (a: FreeSemigroupOf<TestStructure>) in
			Law<FreeSemigroup<TestStructure>>.isWellBehavedWrapper(a.get)
		}
	}

	func testFunction() {
		property("Function is a well-behaved Wrapper") <- forAll { (a: FunctionOf<Int,TestSemiring>, context: Int) in
			LawInContext<Function<Int,TestSemiring>>.isWellBehavedWrapper(a.get)(context)
		}
	}

	func testLast() {
		property("Last is a well-behaved Wrapper") <- forAll { (a: LastOf<Int>) in
			Law<Last<Int>>.isWellBehavedWrapper(a.get)
		}
	}

	func testMax() {
		property("Max is a well-behaved Wrapper") <- forAll { (a: MaxOf<Int>) in
			Law<Max<Int>>.isWellBehavedWrapper(a.get)
		}
	}

	func testMin() {
		property("Min is a well-behaved Wrapper") <- forAll { (a: MinOf<Int>) in
			Law<Min<Int>>.isWellBehavedWrapper(a.get)
		}
	}

	func testMultiply() {
		property("Multiply is a well-behaved Wrapper") <- forAll { (a: MultiplyOf<Int>) in
			Law<Multiply<Int>>.isWellBehavedWrapper(a.get)
		}
	}

	func testOr() {
		property("Or is a well-behaved Wrapper") <- forAll { (a: Or) in
			Law<Or>.isWellBehavedWrapper(a)
		}
	}

	func testTropical() {
		property("Tropical is a well-behaved Wrapper") <- forAll { (a: TropicalOf<Int>) in
			Law<Tropical<Int>>.isWellBehavedWrapper(a.get)
		}
	}

	func testUpdate() {
		property("Update is a well-behaved Wrapper") <- forAll { (a: UpdateOf<>) in
			Law<Update<>>.isWellBehavedWrapper(a.get)
		}
	}

	static var allTests = [
		("testAdd",testAdd),
		("testAnd",testAnd),
		("testEndofunction",testEndofunction),
		("testFirst",testFirst),
		("testFreeCommutativeMonoid",testFreeCommutativeMonoid),
		("testFreeMonoid",testFreeMonoid),
		("testFreeSemigroup",testFreeSemigroup),
		("testFunction",testFunction),
		("testLast",testLast),
		("testMax",testMax),
		("testMin",testMin),
		("testMultiply",testMultiply),
		("testOr",testOr),
		("testTropical",testTropical),
		("testUpdate",testUpdate),
	]
}
