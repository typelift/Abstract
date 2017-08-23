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

	func testFirstM() {
		property("FirstM is a Semigroup") <- forAll { (a: FirstMOf<TestStructure>, b: FirstMOf<TestStructure>, c: FirstMOf<TestStructure>) in
			Law<FirstM<TestStructure>>.isAssociative(a.get,b.get,c.get)
		}
	}

	func testFunctionBS() {
		property("FunctionBS is a Semigroup") <- forAll { (a: FunctionBSOf<Int,TestStructure>, b: FunctionBSOf<Int,TestStructure>, c: FunctionBSOf<Int,TestStructure>, context: Int) in
			LawInContext<FunctionBS<Int,TestStructure>>.isAssociative(a.get,b.get,c.get)(context)
		}
	}

	func testFunctionCM() {
		property("FunctionCM is a Semigroup") <- forAll { (a: FunctionCMOf<Int,TestStructure>, b: FunctionCMOf<Int,TestStructure>, c: FunctionCMOf<Int,TestStructure>, context: Int) in
			LawInContext<FunctionCM<Int,TestStructure>>.isAssociative(a.get,b.get,c.get)(context)
		}
	}

	func testFunctionM() {
		property("FunctionM is a Semigroup") <- forAll { (a: FunctionMOf<Int,TestStructure>, b: FunctionMOf<Int,TestStructure>, c: FunctionMOf<Int,TestStructure>, context: Int) in
			LawInContext<FunctionM<Int,TestStructure>>.isAssociative(a.get,b.get,c.get)(context)
		}
	}

	func testFunctionS() {
		property("FunctionS is a Semigroup") <- forAll { (a: FunctionSOf<Int,TestStructure>, b: FunctionSOf<Int,TestStructure>, c: FunctionSOf<Int,TestStructure>, context: Int) in
			LawInContext<FunctionS<Int,TestStructure>>.isAssociative(a.get,b.get,c.get)(context)
		}
	}

	func testLast() {
		property("Last is a Semigroup") <- forAll { (a: LastOf<Int>, b: LastOf<Int>, c: LastOf<Int>) in
			Law<Last<Int>>.isAssociative(a.get,b.get,c.get)
		}
	}

	func testLastM() {
		property("LastM is a Semigroup") <- forAll { (a: LastMOf<TestStructure>, b: LastMOf<TestStructure>, c: LastMOf<TestStructure>) in
			Law<LastM<TestStructure>>.isAssociative(a.get,b.get,c.get)
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

	func testOptionalBS() {
		property("OptionalBS is a Semigroup") <- forAll { (a: OptionalBSOf<TestStructure>, b: OptionalBSOf<TestStructure>, c: OptionalBSOf<TestStructure>) in
			Law<OptionalBS<TestStructure>>.isAssociative(a.get,b.get,c.get)
		}
	}

	func testOptionalCM() {
		property("OptionalCM is a Semigroup") <- forAll { (a: OptionalCMOf<TestStructure>, b: OptionalCMOf<TestStructure>, c: OptionalCMOf<TestStructure>) in
			Law<OptionalCM<TestStructure>>.isAssociative(a.get,b.get,c.get)
		}
	}

	func testOptionalM() {
		property("OptionalM is a Semigroup") <- forAll { (a: OptionalMOf<TestStructure>, b: OptionalMOf<TestStructure>, c: OptionalMOf<TestStructure>) in
			Law<OptionalM<TestStructure>>.isAssociative(a.get,b.get,c.get)
		}
	}

	func testOptionalS() {
		property("OptionalS is a Semigroup") <- forAll { (a: OptionalSOf<TestStructure>, b: OptionalSOf<TestStructure>, c: OptionalSOf<TestStructure>) in
			Law<OptionalS<TestStructure>>.isAssociative(a.get,b.get,c.get)
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

	static var allTests = [
		("testAdd",testAdd),
		("testAnd",testAnd),
		("testEndofunction",testEndofunction),
		("testFirst",testFirst),
		("testFirstM",testFirstM),
		("testFunctionBS",testFunctionBS),
		("testFunctionCM",testFunctionCM),
		("testFunctionM",testFunctionM),
		("testFunctionS",testFunctionS),
		("testLast",testLast),
		("testLastM",testLastM),
		("testMax",testMax),
		("testMin",testMin),
		("testMultiply",testMultiply),
		("testOptionalBS",testOptionalBS),
		("testOptionalCM",testOptionalCM),
		("testOptionalM",testOptionalM),
		("testOptionalS",testOptionalS),
		("testOr",testOr),
		("testOrdering",testOrdering),
	]
}
