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

	func testFreeSemiring() {
		property("FreeSemiring is a Semiring: Distributive") <- forAll { (a: FreeSemiring<Int>, b: FreeSemiring<Int>, c: FreeSemiring<Int>) in
			Law<FreeSemiring<Int>>.multiplicationIsDistributiveOverAddition(a,b,c)
		}

		property("FreeSemiring is a Semiring: Annihilation") <- forAll { (a: FreeSemiring<Int>) in
			Law<FreeSemiring<Int>>.zeroAnnihiliatesTheMultiplicative(a)
		}
	}

	func testTropical() {
		property("Tropical is a Semiring: Distributive") <- forAll { (a: Tropical<Int>, b: Tropical<Int>, c: Tropical<Int>) in
			Law<Tropical<Int>>.multiplicationIsDistributiveOverAddition(a,b,c)
		}

		property("Tropical is a Semiring: Annihilation") <- forAll { (a: Tropical<Int>) in
			Law<Tropical<Int>>.zeroAnnihiliatesTheMultiplicative(a)
		}
	}

	static var allTests = [
		("testBool",testBool),
		("testFreeSemiring",testFreeSemiring),
		("testTropical",testTropical),
	]
}
