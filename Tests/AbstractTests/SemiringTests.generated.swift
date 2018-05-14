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

	func testProduct() {
		property("Product is a Semiring: Distributive") <- forAll { (a: Product<TestStructure,TestStructure>, b: Product<TestStructure,TestStructure>, c: Product<TestStructure,TestStructure>) in
			Law<Product<TestStructure,TestStructure>>.multiplicationIsDistributiveOverAddition(a,b,c)
		}

		property("Product is a Semiring: Annihilation") <- forAll { (a: Product<TestStructure,TestStructure>) in
			Law<Product<TestStructure,TestStructure>>.zeroAnnihiliatesTheMultiplicative(a)
		}
	}

	func testSetM() {
		property("SetM is a Semiring: Distributive") <- forAll { (a: SetM<String>, b: SetM<String>, c: SetM<String>) in
			Law<SetM<String>>.multiplicationIsDistributiveOverAddition(a,b,c)
		}

		property("SetM is a Semiring: Annihilation") <- forAll { (a: SetM<String>) in
			Law<SetM<String>>.zeroAnnihiliatesTheMultiplicative(a)
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
		("testProduct",testProduct),
		("testSetM",testSetM),
		("testTropical",testTropical),
	]
}
