// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import Abstract
import SwiftCheck


final class SemiringTests: XCTestCase {

	func testBool() {
		property("Bool is a Semiring: Distributive") <- forAll { (a: Bool, b: Bool, c: Bool) in
			Law<Bool>.multiplicationIsDistributiveOverAddition(a,b,c)
		}

		property("Bool is a Semiring: Annihilation") <- forAll { (a: Bool) in
			Law<Bool>.zeroAnnihiliatesTheMultiplicative(a)
		}
	}

	func testFunctionSR() {
		property("FunctionSR is a Semiring: Distributive") <- forAll { (a: ArbitraryFunctionSR<Int,TestSemiring>, b: ArbitraryFunctionSR<Int,TestSemiring>, c: ArbitraryFunctionSR<Int,TestSemiring>, context: Int) in
			LawInContext<FunctionSR<Int,TestSemiring>>.multiplicationIsDistributiveOverAddition(a.get,b.get,c.get)(context)
		}

		property("FunctionSR is a Semiring: Annihilation") <- forAll { (a: ArbitraryFunctionSR<Int,TestSemiring>, context: Int) in
			LawInContext<FunctionSR<Int,TestSemiring>>.zeroAnnihiliatesTheMultiplicative(a.get)(context)
		}
	}

	func testTropical() {
		property("Tropical is a Semiring: Distributive") <- forAll { (a: ArbitraryTropical<Int>, b: ArbitraryTropical<Int>, c: ArbitraryTropical<Int>) in
			Law<Tropical<Int>>.multiplicationIsDistributiveOverAddition(a.get,b.get,c.get)
		}

		property("Tropical is a Semiring: Annihilation") <- forAll { (a: ArbitraryTropical<Int>) in
			Law<Tropical<Int>>.zeroAnnihiliatesTheMultiplicative(a.get)
		}
	}

	static var allTests = [
		("testBool",testBool),
		("testFunctionSR",testFunctionSR),
		("testTropical",testTropical),
	]
}
