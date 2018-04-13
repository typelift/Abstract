// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import Abstract
import SwiftCheck


final class SemigroupTests: XCTestCase {

	func testAdd() {
		property("Add is a Semigroup") <- forAll { (a: AddOf<Int>, b: AddOf<Int>, c: AddOf<Int>) in
			Law<Add<Int>>.isAssociative(a.get,b.get,c.get)
		}
	}

	func testAnd() {
		property("And is a Semigroup") <- forAll { (a: And, b: And, c: And) in
			Law<And>.isAssociative(a,b,c)
		}
	}

	func testArray() {
		property("Array is a Semigroup") <- forAll { (a: Array, b: Array, c: Array) in
			Law<Array>.isAssociative(a,b,c)
		}
	}

	func testEndofunction() {
		property("Endofunction is a Semigroup") <- forAll { (a: EndofunctionOf<Int>, b: EndofunctionOf<Int>, c: EndofunctionOf<Int>, context: Int) in
			LawInContext<Endofunction<Int>>.isAssociative(a.get,b.get,c.get)(context)
		}
	}

	func testFirst() {
		property("First is a Semigroup") <- forAll { (a: FirstOf<Int>, b: FirstOf<Int>, c: FirstOf<Int>) in
			Law<First<Int>>.isAssociative(a.get,b.get,c.get)
		}
	}

	func testFreeCommutativeMonoid() {
		property("FreeCommutativeMonoid is a Semigroup") <- forAll { (a: FreeCommutativeMonoidOf<TestStructure>, b: FreeCommutativeMonoidOf<TestStructure>, c: FreeCommutativeMonoidOf<TestStructure>) in
			Law<FreeCommutativeMonoid<TestStructure>>.isAssociative(a.get,b.get,c.get)
		}
	}

	func testFreeMonoid() {
		property("FreeMonoid is a Semigroup") <- forAll { (a: FreeMonoidOf<TestStructure>, b: FreeMonoidOf<TestStructure>, c: FreeMonoidOf<TestStructure>) in
			Law<FreeMonoid<TestStructure>>.isAssociative(a.get,b.get,c.get)
		}
	}

	func testFreeSemigroup() {
		property("FreeSemigroup is a Semigroup") <- forAll { (a: FreeSemigroupOf<TestStructure>, b: FreeSemigroupOf<TestStructure>, c: FreeSemigroupOf<TestStructure>) in
			Law<FreeSemigroup<TestStructure>>.isAssociative(a.get,b.get,c.get)
		}
	}

	func testFunction() {
		property("Function is a Semigroup") <- forAll { (a: FunctionOf<Int,TestSemiring>, b: FunctionOf<Int,TestSemiring>, c: FunctionOf<Int,TestSemiring>, context: Int) in
			LawInContext<Function<Int,TestSemiring>>.isAssociative(a.get,b.get,c.get)(context)
		}
	}

	func testLast() {
		property("Last is a Semigroup") <- forAll { (a: LastOf<Int>, b: LastOf<Int>, c: LastOf<Int>) in
			Law<Last<Int>>.isAssociative(a.get,b.get,c.get)
		}
	}

	func testMax() {
		property("Max is a Semigroup") <- forAll { (a: MaxOf<Int>, b: MaxOf<Int>, c: MaxOf<Int>) in
			Law<Max<Int>>.isAssociative(a.get,b.get,c.get)
		}
	}

	func testMin() {
		property("Min is a Semigroup") <- forAll { (a: MinOf<Int>, b: MinOf<Int>, c: MinOf<Int>) in
			Law<Min<Int>>.isAssociative(a.get,b.get,c.get)
		}
	}

	func testMultiply() {
		property("Multiply is a Semigroup") <- forAll { (a: MultiplyOf<Int>, b: MultiplyOf<Int>, c: MultiplyOf<Int>) in
			Law<Multiply<Int>>.isAssociative(a.get,b.get,c.get)
		}
	}

	func testOptional() {
		property("Optional is a Semigroup") <- forAll { (a: Optional, b: Optional, c: Optional) in
			Law<Optional>.isAssociative(a,b,c)
		}
	}

	func testOr() {
		property("Or is a Semigroup") <- forAll { (a: Or, b: Or, c: Or) in
			Law<Or>.isAssociative(a,b,c)
		}
	}

	func testOrdering() {
		property("Ordering is a Semigroup") <- forAll { (a: Ordering, b: Ordering, c: Ordering) in
			Law<Ordering>.isAssociative(a,b,c)
		}
	}

	func testString() {
		property("String is a Semigroup") <- forAll { (a: String, b: String, c: String) in
			Law<String>.isAssociative(a,b,c)
		}
	}

	func testUpdate() {
		property("Update is a Semigroup") <- forAll { (a: UpdateOf<>, b: UpdateOf<>, c: UpdateOf<>) in
			Law<Update<>>.isAssociative(a.get,b.get,c.get)
		}
	}

	static var allTests = [
		("testAdd",testAdd),
		("testAnd",testAnd),
		("testArray",testArray),
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
		("testOptional",testOptional),
		("testOr",testOr),
		("testOrdering",testOrdering),
		("testString",testString),
		("testUpdate",testUpdate),
	]
}
