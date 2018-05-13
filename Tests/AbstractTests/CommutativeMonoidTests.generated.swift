// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import Abstract
import SwiftCheck


final class CommutativeMonoidTests: XCTestCase {

	func testAdd() {
		property("Add is a CommutativeMonoid") <- forAll { (a: Add<Int>, b: Add<Int>) in
			Law<Add<Int>>.isCommutative(a,b)
		}
	}

	func testAnd() {
		property("And is a CommutativeMonoid") <- forAll { (a: And, b: And) in
			Law<And>.isCommutative(a,b)
		}
	}

	func testMax() {
		property("Max is a CommutativeMonoid") <- forAll { (a: Max<Int>, b: Max<Int>) in
			Law<Max<Int>>.isCommutative(a,b)
		}
	}

	func testMin() {
		property("Min is a CommutativeMonoid") <- forAll { (a: Min<Int>, b: Min<Int>) in
			Law<Min<Int>>.isCommutative(a,b)
		}
	}

	func testMultiply() {
		property("Multiply is a CommutativeMonoid") <- forAll { (a: Multiply<Int>, b: Multiply<Int>) in
			Law<Multiply<Int>>.isCommutative(a,b)
		}
	}

	func testMultiset() {
		property("Multiset is a CommutativeMonoid") <- forAll { (a: Multiset<Int>, b: Multiset<Int>) in
			Law<Multiset<Int>>.isCommutative(a,b)
		}
	}

	func testOr() {
		property("Or is a CommutativeMonoid") <- forAll { (a: Or, b: Or) in
			Law<Or>.isCommutative(a,b)
		}
	}

	func testProduct() {
		property("Product is a CommutativeMonoid") <- forAll { (a: Product<TestStructure,TestStructure>, b: Product<TestStructure,TestStructure>) in
			Law<Product<TestStructure,TestStructure>>.isCommutative(a,b)
		}
	}

	func testSet() {
		property("Set is a CommutativeMonoid") <- forAll { (a: Set<Int>, b: Set<Int>) in
			Law<Set<Int>>.isCommutative(a,b)
		}
	}


    func testBoolSemiring() {
        property("Bool is a CommutativeMonoid in regard to the Additive operation") <- forAll { (a: Bool, b: Bool) in
            Law<Bool>.isCommutative(a,b,<>+)
        }
    }

    func testProductSemiring() {
        property("Product is a CommutativeMonoid in regard to the Additive operation") <- forAll { (a: Product<TestStructure,TestStructure>, b: Product<TestStructure,TestStructure>) in
            Law<Product<TestStructure,TestStructure>>.isCommutative(a,b,<>+)
        }
    }

    func testSetMSemiring() {
        property("SetM is a CommutativeMonoid in regard to the Additive operation") <- forAll { (a: SetM<String>, b: SetM<String>) in
            Law<SetM<String>>.isCommutative(a,b,<>+)
        }
    }

    func testTropicalSemiring() {
        property("Tropical is a CommutativeMonoid in regard to the Additive operation") <- forAll { (a: Tropical<Int>, b: Tropical<Int>) in
            Law<Tropical<Int>>.isCommutative(a,b,<>+)
        }
    }


	static var allTests = [
		("testAdd",testAdd),
		("testAnd",testAnd),
		("testMax",testMax),
		("testMin",testMin),
		("testMultiply",testMultiply),
		("testMultiset",testMultiset),
		("testOr",testOr),
		("testProduct",testProduct),
		("testSet",testSet),
        ("testBoolSemiring",testBoolSemiring),
        ("testProductSemiring",testProductSemiring),
        ("testSetMSemiring",testSetMSemiring),
        ("testTropicalSemiring",testTropicalSemiring),
	]
}
