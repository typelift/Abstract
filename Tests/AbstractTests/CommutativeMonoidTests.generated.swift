// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import Abstract
import SwiftCheck


final class CommutativeMonoidTests: XCTestCase {

	func testAdd() {
		property("Add is a CommutativeMonoid") <- forAll { (a: ArbitraryAdd<Int>, b: ArbitraryAdd<Int>) in
			Law<Add<Int>>.isCommutative(a.get,b.get)
		}
	}

	func testAnd() {
		property("And is a CommutativeMonoid") <- forAll { (a: And, b: And) in
			Law<And>.isCommutative(a,b)
		}
	}

	func testFunctionBS() {
		property("FunctionBS is a CommutativeMonoid") <- forAll { (a: ArbitraryFunctionBS<Int,TestStructure>, b: ArbitraryFunctionBS<Int,TestStructure>, context: Int) in
			LawInContext<FunctionBS<Int,TestStructure>>.isCommutative(a.get,b.get)(context)
		}
	}

	func testFunctionCM() {
		property("FunctionCM is a CommutativeMonoid") <- forAll { (a: ArbitraryFunctionCM<Int,TestStructure>, b: ArbitraryFunctionCM<Int,TestStructure>, context: Int) in
			LawInContext<FunctionCM<Int,TestStructure>>.isCommutative(a.get,b.get)(context)
		}
	}

	func testMax() {
		property("Max is a CommutativeMonoid") <- forAll { (a: ArbitraryMax<Int>, b: ArbitraryMax<Int>) in
			Law<Max<Int>>.isCommutative(a.get,b.get)
		}
	}

	func testMin() {
		property("Min is a CommutativeMonoid") <- forAll { (a: ArbitraryMin<Int>, b: ArbitraryMin<Int>) in
			Law<Min<Int>>.isCommutative(a.get,b.get)
		}
	}

	func testMultiply() {
		property("Multiply is a CommutativeMonoid") <- forAll { (a: ArbitraryMultiply<Int>, b: ArbitraryMultiply<Int>) in
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
		("testFunctionBS",testFunctionBS),
		("testFunctionCM",testFunctionCM),
		("testMax",testMax),
		("testMin",testMin),
		("testMultiply",testMultiply),
		("testOr",testOr),
	]
}
