// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import Abstract
import SwiftCheck


final class SemigroupTests: XCTestCase {

	func testAdd() {
		property("Add is a Semigroup") <- forAll { (a: ArbitraryAdd<Int>, b: ArbitraryAdd<Int>, c: ArbitraryAdd<Int>) in
			Law<Add<Int>>.isAssociative(a.get,b.get,c.get)
		}
	}

	func testAnd() {
		property("And is a Semigroup") <- forAll { (a: And, b: And, c: And) in
			Law<And>.isAssociative(a,b,c)
		}
	}

	func testEndofunction() {
		property("Endofunction is a Semigroup") <- forAll { (a: ArbitraryEndofunction<Int>, b: ArbitraryEndofunction<Int>, c: ArbitraryEndofunction<Int>, context: Int) in
			LawInContext<Endofunction<Int>>.isAssociative(a.get,b.get,c.get)(context)
		}
	}

	func testFunctionBS() {
		property("FunctionBS is a Semigroup") <- forAll { (a: ArbitraryFunctionBS<Int,TestStructure>, b: ArbitraryFunctionBS<Int,TestStructure>, c: ArbitraryFunctionBS<Int,TestStructure>, context: Int) in
			LawInContext<FunctionBS<Int,TestStructure>>.isAssociative(a.get,b.get,c.get)(context)
		}
	}

	func testFunctionCM() {
		property("FunctionCM is a Semigroup") <- forAll { (a: ArbitraryFunctionCM<Int,TestStructure>, b: ArbitraryFunctionCM<Int,TestStructure>, c: ArbitraryFunctionCM<Int,TestStructure>, context: Int) in
			LawInContext<FunctionCM<Int,TestStructure>>.isAssociative(a.get,b.get,c.get)(context)
		}
	}

	func testFunctionM() {
		property("FunctionM is a Semigroup") <- forAll { (a: ArbitraryFunctionM<Int,TestStructure>, b: ArbitraryFunctionM<Int,TestStructure>, c: ArbitraryFunctionM<Int,TestStructure>, context: Int) in
			LawInContext<FunctionM<Int,TestStructure>>.isAssociative(a.get,b.get,c.get)(context)
		}
	}

	func testFunctionS() {
		property("FunctionS is a Semigroup") <- forAll { (a: ArbitraryFunctionS<Int,TestStructure>, b: ArbitraryFunctionS<Int,TestStructure>, c: ArbitraryFunctionS<Int,TestStructure>, context: Int) in
			LawInContext<FunctionS<Int,TestStructure>>.isAssociative(a.get,b.get,c.get)(context)
		}
	}

	func testMax() {
		property("Max is a Semigroup") <- forAll { (a: ArbitraryMax<Int>, b: ArbitraryMax<Int>, c: ArbitraryMax<Int>) in
			Law<Max<Int>>.isAssociative(a.get,b.get,c.get)
		}
	}

	func testMin() {
		property("Min is a Semigroup") <- forAll { (a: ArbitraryMin<Int>, b: ArbitraryMin<Int>, c: ArbitraryMin<Int>) in
			Law<Min<Int>>.isAssociative(a.get,b.get,c.get)
		}
	}

	func testMultiply() {
		property("Multiply is a Semigroup") <- forAll { (a: ArbitraryMultiply<Int>, b: ArbitraryMultiply<Int>, c: ArbitraryMultiply<Int>) in
			Law<Multiply<Int>>.isAssociative(a.get,b.get,c.get)
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
		("testFunctionBS",testFunctionBS),
		("testFunctionCM",testFunctionCM),
		("testFunctionM",testFunctionM),
		("testFunctionS",testFunctionS),
		("testMax",testMax),
		("testMin",testMin),
		("testMultiply",testMultiply),
		("testOr",testOr),
		("testOrdering",testOrdering),
	]
}
