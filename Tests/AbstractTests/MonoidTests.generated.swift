// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import Abstract
import SwiftCheck


final class MonoidTests: XCTestCase {

	func testAdd() {
	property("Add is a Monoid") <- forAll { (a: ArbitraryAdd<Int>) in
			Law<Add<Int>>.isNeutralToEmpty(a.get)
		}
	}

	func testAnd() {
		property("And is a Monoid") <- forAll { (a: And) in
			Law<And>.isNeutralToEmpty(a)
		}
	}

	func testEndofunction() {
	property("Endofunction is a Monoid") <- forAll { (a: ArbitraryEndofunction<Int>, context: Int) in
			LawInContext<Endofunction<Int>>.isNeutralToEmpty(a.get)(context)
		}
	}

	func testFunctionBS() {
	property("FunctionBS is a Monoid") <- forAll { (a: ArbitraryFunctionBS<Int,TestStructure>, context: Int) in
			LawInContext<FunctionBS<Int,TestStructure>>.isNeutralToEmpty(a.get)(context)
		}
	}

	func testFunctionCM() {
	property("FunctionCM is a Monoid") <- forAll { (a: ArbitraryFunctionCM<Int,TestStructure>, context: Int) in
			LawInContext<FunctionCM<Int,TestStructure>>.isNeutralToEmpty(a.get)(context)
		}
	}

	func testFunctionM() {
	property("FunctionM is a Monoid") <- forAll { (a: ArbitraryFunctionM<Int,TestStructure>, context: Int) in
			LawInContext<FunctionM<Int,TestStructure>>.isNeutralToEmpty(a.get)(context)
		}
	}

	func testMax() {
	property("Max is a Monoid") <- forAll { (a: ArbitraryMax<Int>) in
			Law<Max<Int>>.isNeutralToEmpty(a.get)
		}
	}

	func testMin() {
	property("Min is a Monoid") <- forAll { (a: ArbitraryMin<Int>) in
			Law<Min<Int>>.isNeutralToEmpty(a.get)
		}
	}

	func testMultiply() {
	property("Multiply is a Monoid") <- forAll { (a: ArbitraryMultiply<Int>) in
			Law<Multiply<Int>>.isNeutralToEmpty(a.get)
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

	static var allTests = [
		("testAdd",testAdd),
		("testAnd",testAnd),
		("testEndofunction",testEndofunction),
		("testFunctionBS",testFunctionBS),
		("testFunctionCM",testFunctionCM),
		("testFunctionM",testFunctionM),
		("testMax",testMax),
		("testMin",testMin),
		("testMultiply",testMultiply),
		("testOr",testOr),
		("testOrdering",testOrdering),
	]
}
