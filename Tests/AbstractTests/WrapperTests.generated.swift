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

	func testArrayEq() {
		property("ArrayEq is a well-behaved Wrapper") <- forAll { (a: ArrayEqOf<TestStructure>) in
			Law<ArrayEq<TestStructure>>.isWellBehavedWrapper(a.get)
		}
	}

	func testArrayEqF() {
		property("ArrayEqF is a well-behaved Wrapper") <- forAll { (a: ArrayEqFOf<TestFunction>, context: String) in
			LawInContext<ArrayEqF<TestFunction>>.isWellBehavedWrapper(a.get)(context)
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

	func testFirstF() {
		property("FirstF is a well-behaved Wrapper") <- forAll { (a: FirstFOf<TestFunction>, context: String) in
			LawInContext<FirstF<TestFunction>>.isWellBehavedWrapper(a.get)(context)
		}
	}

	func testFirstM() {
		property("FirstM is a well-behaved Wrapper") <- forAll { (a: FirstMOf<TestStructure>) in
			Law<FirstM<TestStructure>>.isWellBehavedWrapper(a.get)
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

	func testFunctionS() {
		property("FunctionS is a well-behaved Wrapper") <- forAll { (a: FunctionSOf<Int,TestStructure>, context: Int) in
			LawInContext<FunctionS<Int,TestStructure>>.isWellBehavedWrapper(a.get)(context)
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

	func testLastF() {
		property("LastF is a well-behaved Wrapper") <- forAll { (a: LastFOf<TestFunction>, context: String) in
			LawInContext<LastF<TestFunction>>.isWellBehavedWrapper(a.get)(context)
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

	func testOptionalEq() {
		property("OptionalEq is a well-behaved Wrapper") <- forAll { (a: OptionalEqOf<TestStructure>) in
			Law<OptionalEq<TestStructure>>.isWellBehavedWrapper(a.get)
		}
	}

	func testOptionalEqF() {
		property("OptionalEqF is a well-behaved Wrapper") <- forAll { (a: OptionalEqFOf<TestFunction>, context: String) in
			LawInContext<OptionalEqF<TestFunction>>.isWellBehavedWrapper(a.get)(context)
		}
	}

	func testOptionalM() {
		property("OptionalM is a well-behaved Wrapper") <- forAll { (a: OptionalMOf<TestStructure>) in
			Law<OptionalM<TestStructure>>.isWellBehavedWrapper(a.get)
		}
	}

	func testOptionalMF() {
		property("OptionalMF is a well-behaved Wrapper") <- forAll { (a: OptionalMFOf<TestFunction>, context: String) in
			LawInContext<OptionalMF<TestFunction>>.isWellBehavedWrapper(a.get)(context)
		}
	}

	func testOptionalS() {
		property("OptionalS is a well-behaved Wrapper") <- forAll { (a: OptionalSOf<TestStructure>) in
			Law<OptionalS<TestStructure>>.isWellBehavedWrapper(a.get)
		}
	}

	func testOptionalSF() {
		property("OptionalSF is a well-behaved Wrapper") <- forAll { (a: OptionalSFOf<TestFunction>, context: String) in
			LawInContext<OptionalSF<TestFunction>>.isWellBehavedWrapper(a.get)(context)
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
		("testArrayEq",testArrayEq),
		("testArrayEqF",testArrayEqF),
		("testEndofunction",testEndofunction),
		("testFirst",testFirst),
		("testFirstF",testFirstF),
		("testFirstM",testFirstM),
		("testFunctionBS",testFunctionBS),
		("testFunctionCM",testFunctionCM),
		("testFunctionM",testFunctionM),
		("testFunctionS",testFunctionS),
		("testFunctionSR",testFunctionSR),
		("testLast",testLast),
		("testLastF",testLastF),
		("testLastM",testLastM),
		("testMax",testMax),
		("testMin",testMin),
		("testMultiply",testMultiply),
		("testOptionalBS",testOptionalBS),
		("testOptionalBSF",testOptionalBSF),
		("testOptionalCM",testOptionalCM),
		("testOptionalCMF",testOptionalCMF),
		("testOptionalEq",testOptionalEq),
		("testOptionalEqF",testOptionalEqF),
		("testOptionalM",testOptionalM),
		("testOptionalMF",testOptionalMF),
		("testOptionalS",testOptionalS),
		("testOptionalSF",testOptionalSF),
		("testOr",testOr),
		("testTropical",testTropical),
	]
}
