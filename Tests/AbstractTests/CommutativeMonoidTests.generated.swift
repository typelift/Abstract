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

	func testFunctionBS() {
		property("FunctionBS is a CommutativeMonoid") <- forAll { (a: FunctionBSOf<Int,TestStructure>, b: FunctionBSOf<Int,TestStructure>, context: Int) in
			LawInContext<FunctionBS<Int,TestStructure>>.isCommutative(a.get,b.get)(context)
		}
	}

	func testFunctionCM() {
		property("FunctionCM is a CommutativeMonoid") <- forAll { (a: FunctionCMOf<Int,TestStructure>, b: FunctionCMOf<Int,TestStructure>, context: Int) in
			LawInContext<FunctionCM<Int,TestStructure>>.isCommutative(a.get,b.get)(context)
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

	func testOptionalBS() {
		property("OptionalBS is a CommutativeMonoid") <- forAll { (a: OptionalBSOf<TestStructure>, b: OptionalBSOf<TestStructure>) in
			Law<OptionalBS<TestStructure>>.isCommutative(a.get,b.get)
		}
	}

	func testOptionalBSF() {
		property("OptionalBSF is a CommutativeMonoid") <- forAll { (a: OptionalBSFOf<TestFunction>, b: OptionalBSFOf<TestFunction>, context: String) in
			LawInContext<OptionalBSF<TestFunction>>.isCommutative(a.get,b.get)(context)
		}
	}

	func testOptionalCM() {
		property("OptionalCM is a CommutativeMonoid") <- forAll { (a: OptionalCMOf<TestStructure>, b: OptionalCMOf<TestStructure>) in
			Law<OptionalCM<TestStructure>>.isCommutative(a.get,b.get)
		}
	}

	func testOptionalCMF() {
		property("OptionalCMF is a CommutativeMonoid") <- forAll { (a: OptionalCMFOf<TestFunction>, b: OptionalCMFOf<TestFunction>, context: String) in
			LawInContext<OptionalCMF<TestFunction>>.isCommutative(a.get,b.get)(context)
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
		("testFunctionBS",testFunctionBS),
		("testFunctionCM",testFunctionCM),
		("testMax",testMax),
		("testMin",testMin),
		("testMultiply",testMultiply),
		("testOptionalBS",testOptionalBS),
		("testOptionalBSF",testOptionalBSF),
		("testOptionalCM",testOptionalCM),
		("testOptionalCMF",testOptionalCMF),
		("testOr",testOr),
	]
}
