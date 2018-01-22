// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import Abstract
import SwiftCheck


final class MonoidTests: XCTestCase {

	func testAdd() {
		property("Add is a Monoid") <- forAll { (a: AddOf<Int>) in
			Law<Add<Int>>.isNeutralToEmpty(a.get)
		}
	}

	func testAnd() {
		property("And is a Monoid") <- forAll { (a: And) in
			Law<And>.isNeutralToEmpty(a)
		}
	}

	func testArray() {
		property("Array is a Monoid") <- forAll { (a: Array) in
			Law<Array>.isNeutralToEmpty(a)
		}
	}

	func testEndofunction() {
		property("Endofunction is a Monoid") <- forAll { (a: EndofunctionOf<Int>, context: Int) in
			LawInContext<Endofunction<Int>>.isNeutralToEmpty(a.get)(context)
		}
	}

	func testFirstM() {
		property("FirstM is a Monoid") <- forAll { (a: FirstMOf<TestStructure>) in
			Law<FirstM<TestStructure>>.isNeutralToEmpty(a.get)
		}
	}

	func testFunctionBS() {
		property("FunctionBS is a Monoid") <- forAll { (a: FunctionBSOf<Int,TestStructure>, context: Int) in
			LawInContext<FunctionBS<Int,TestStructure>>.isNeutralToEmpty(a.get)(context)
		}
	}

	func testFunctionCM() {
		property("FunctionCM is a Monoid") <- forAll { (a: FunctionCMOf<Int,TestStructure>, context: Int) in
			LawInContext<FunctionCM<Int,TestStructure>>.isNeutralToEmpty(a.get)(context)
		}
	}

	func testFunctionM() {
		property("FunctionM is a Monoid") <- forAll { (a: FunctionMOf<Int,TestStructure>, context: Int) in
			LawInContext<FunctionM<Int,TestStructure>>.isNeutralToEmpty(a.get)(context)
		}
	}

	func testLastM() {
		property("LastM is a Monoid") <- forAll { (a: LastMOf<TestStructure>) in
			Law<LastM<TestStructure>>.isNeutralToEmpty(a.get)
		}
	}

	func testMax() {
		property("Max is a Monoid") <- forAll { (a: MaxOf<Int>) in
			Law<Max<Int>>.isNeutralToEmpty(a.get)
		}
	}

	func testMin() {
		property("Min is a Monoid") <- forAll { (a: MinOf<Int>) in
			Law<Min<Int>>.isNeutralToEmpty(a.get)
		}
	}

	func testMultiply() {
		property("Multiply is a Monoid") <- forAll { (a: MultiplyOf<Int>) in
			Law<Multiply<Int>>.isNeutralToEmpty(a.get)
		}
	}

	func testOptional() {
		property("Optional is a Monoid") <- forAll { (a: Optional) in
			Law<Optional>.isNeutralToEmpty(a)
		}
	}

	func testOptionalBS() {
		property("OptionalBS is a Monoid") <- forAll { (a: OptionalBSOf<TestStructure>) in
			Law<OptionalBS<TestStructure>>.isNeutralToEmpty(a.get)
		}
	}

	func testOptionalBSF() {
		property("OptionalBSF is a Monoid") <- forAll { (a: OptionalBSFOf<TestFunction>, context: String) in
			LawInContext<OptionalBSF<TestFunction>>.isNeutralToEmpty(a.get)(context)
		}
	}

	func testOptionalCM() {
		property("OptionalCM is a Monoid") <- forAll { (a: OptionalCMOf<TestStructure>) in
			Law<OptionalCM<TestStructure>>.isNeutralToEmpty(a.get)
		}
	}

	func testOptionalCMF() {
		property("OptionalCMF is a Monoid") <- forAll { (a: OptionalCMFOf<TestFunction>, context: String) in
			LawInContext<OptionalCMF<TestFunction>>.isNeutralToEmpty(a.get)(context)
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

	func testString() {
		property("String is a Monoid") <- forAll { (a: String) in
			Law<String>.isNeutralToEmpty(a)
		}
	}

	static var allTests = [
		("testAdd",testAdd),
		("testAnd",testAnd),
		("testArray",testArray),
		("testEndofunction",testEndofunction),
		("testFirstM",testFirstM),
		("testFunctionBS",testFunctionBS),
		("testFunctionCM",testFunctionCM),
		("testFunctionM",testFunctionM),
		("testLastM",testLastM),
		("testMax",testMax),
		("testMin",testMin),
		("testMultiply",testMultiply),
		("testOptional",testOptional),
		("testOptionalBS",testOptionalBS),
		("testOptionalBSF",testOptionalBSF),
		("testOptionalCM",testOptionalCM),
		("testOptionalCMF",testOptionalCMF),
		("testOr",testOr),
		("testOrdering",testOrdering),
		("testString",testString),
	]
}
