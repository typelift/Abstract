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

	static var allTests = [
		("testAdd",testAdd),
		("testAnd",testAnd),
		("testEndofunction",testEndofunction),
		("testFunctionBS",testFunctionBS),
		("testFunctionCM",testFunctionCM),
		("testFunctionM",testFunctionM),
		("testFunctionS",testFunctionS),
		("testFunctionSR",testFunctionSR),
		("testMax",testMax),
		("testMin",testMin),
		("testMultiply",testMultiply),
		("testOr",testOr),
		("testTropical",testTropical),
	]
}
