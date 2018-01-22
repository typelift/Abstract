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

	func testFirstM() {
		property("FirstM is a well-behaved Wrapper") <- forAll { (a: FirstMOf<TestStructure>) in
			Law<FirstM<TestStructure>>.isWellBehavedWrapper(a.get)
		}
	}

	func testFreeSemigroup() {
		property("FreeSemigroup is a well-behaved Wrapper") <- forAll { (a: FreeSemigroupOf<TestStructure>) in
			Law<FreeSemigroup<TestStructure>>.isWellBehavedWrapper(a.get)
		}
	}

	func testFunction() {
		property("Function is a well-behaved Wrapper") <- forAll { (a: FunctionOf<Int,TestStructure>, context: Int) in
			LawInContext<Function<Int,TestStructure>>.isWellBehavedWrapper(a.get)(context)
		}
	}

	func testFunctionBS() {
		property("FunctionBS is a well-behaved Wrapper") <- forAll { (a: FunctionBSOf<Int,TestStructure>, context: Int) in
			LawInContext<FunctionBS<Int,TestStructure>>.isWellBehavedWrapper(a.get)(context)
		}
	}

	func testFunctionCM() {
		property("FunctionCM is a well-behaved Wrapper") <- forAll { (a: FunctionCMOf<Int,TestStructure>, context: Int) in
			LawInContext<FunctionCM<Int,TestStructure>>.isWellBehavedWrapper(a.get)(context)
		}
	}

	func testFunctionM() {
		property("FunctionM is a well-behaved Wrapper") <- forAll { (a: FunctionMOf<Int,TestStructure>, context: Int) in
			LawInContext<FunctionM<Int,TestStructure>>.isWellBehavedWrapper(a.get)(context)
		}
	}

	func testFunctionSR() {
		property("FunctionSR is a well-behaved Wrapper") <- forAll { (a: FunctionSROf<Int,TestSemiring>, context: Int) in
			LawInContext<FunctionSR<Int,TestSemiring>>.isWellBehavedWrapper(a.get)(context)
		}
	}

	func testLast() {
		property("Last is a well-behaved Wrapper") <- forAll { (a: LastOf<Int>) in
			Law<Last<Int>>.isWellBehavedWrapper(a.get)
		}
	}

	func testLastM() {
		property("LastM is a well-behaved Wrapper") <- forAll { (a: LastMOf<TestStructure>) in
			Law<LastM<TestStructure>>.isWellBehavedWrapper(a.get)
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

	func testOptionalBS() {
		property("OptionalBS is a well-behaved Wrapper") <- forAll { (a: OptionalBSOf<TestStructure>) in
			Law<OptionalBS<TestStructure>>.isWellBehavedWrapper(a.get)
		}
	}

	func testOptionalBSF() {
		property("OptionalBSF is a well-behaved Wrapper") <- forAll { (a: OptionalBSFOf<TestFunction>, context: String) in
			LawInContext<OptionalBSF<TestFunction>>.isWellBehavedWrapper(a.get)(context)
		}
	}

	func testOptionalCM() {
		property("OptionalCM is a well-behaved Wrapper") <- forAll { (a: OptionalCMOf<TestStructure>) in
			Law<OptionalCM<TestStructure>>.isWellBehavedWrapper(a.get)
		}
	}

	func testOptionalCMF() {
		property("OptionalCMF is a well-behaved Wrapper") <- forAll { (a: OptionalCMFOf<TestFunction>, context: String) in
			LawInContext<OptionalCMF<TestFunction>>.isWellBehavedWrapper(a.get)(context)
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

	static var allTests = [
		("testAdd",testAdd),
		("testAnd",testAnd),
		("testEndofunction",testEndofunction),
		("testFirst",testFirst),
		("testFirstM",testFirstM),
		("testFreeSemigroup",testFreeSemigroup),
		("testFunction",testFunction),
		("testFunctionBS",testFunctionBS),
		("testFunctionCM",testFunctionCM),
		("testFunctionM",testFunctionM),
		("testFunctionSR",testFunctionSR),
		("testLast",testLast),
		("testLastM",testLastM),
		("testMax",testMax),
		("testMin",testMin),
		("testMultiply",testMultiply),
		("testOptionalBS",testOptionalBS),
		("testOptionalBSF",testOptionalBSF),
		("testOptionalCM",testOptionalCM),
		("testOptionalCMF",testOptionalCMF),
		("testOr",testOr),
		("testTropical",testTropical),
	]
}
