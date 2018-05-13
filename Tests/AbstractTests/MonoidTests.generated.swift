// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import Abstract
import SwiftCheck


final class MonoidTests: XCTestCase {

	func testAdd() {
		property("Add is a Monoid") <- forAll { (a: Add<Int>) in
			Law<Add<Int>>.isNeutralToEmpty(a)
		}
	}

	func testAnd() {
		property("And is a Monoid") <- forAll { (a: And) in
			Law<And>.isNeutralToEmpty(a)
		}
	}

	func testArray() {
		property("Array is a Monoid") <- forAll { (a: Array<Int>) in
			Law<Array<Int>>.isNeutralToEmpty(a)
		}
	}

	func testEndofunction() {
		property("Endofunction is a Monoid") <- forAll { (a: Endofunction<Int>, context: Int) in
			LawInContext<Endofunction<Int>>.isNeutralToEmpty(a)(context)
		}
	}

	func testMax() {
		property("Max is a Monoid") <- forAll { (a: Max<Int>) in
			Law<Max<Int>>.isNeutralToEmpty(a)
		}
	}

	func testMin() {
		property("Min is a Monoid") <- forAll { (a: Min<Int>) in
			Law<Min<Int>>.isNeutralToEmpty(a)
		}
	}

	func testMultiply() {
		property("Multiply is a Monoid") <- forAll { (a: Multiply<Int>) in
			Law<Multiply<Int>>.isNeutralToEmpty(a)
		}
	}

	func testMultiset() {
		property("Multiset is a Monoid") <- forAll { (a: Multiset<Int>) in
			Law<Multiset<Int>>.isNeutralToEmpty(a)
		}
	}

	func testOptional() {
		property("Optional is a Monoid") <- forAll { (a: Optional<Int>) in
			Law<Optional<Int>>.isNeutralToEmpty(a)
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

	func testProduct() {
		property("Product is a Monoid") <- forAll { (a: Product<TestStructure,TestStructure>) in
			Law<Product<TestStructure,TestStructure>>.isNeutralToEmpty(a)
		}
	}

	func testSet() {
		property("Set is a Monoid") <- forAll { (a: Set<Int>) in
			Law<Set<Int>>.isNeutralToEmpty(a)
		}
	}

	func testString() {
		property("String is a Monoid") <- forAll { (a: String) in
			Law<String>.isNeutralToEmpty(a)
		}
	}

	func testUpdate() {
		property("Update is a Monoid") <- forAll { (a: Update<Int>) in
			Law<Update<Int>>.isNeutralToEmpty(a)
		}
	}


    func testBoolSemiring() {
        property("Bool is a Monoid in regard to the Additive operation") <- forAll { (a: Bool) in
            Law<Bool>.isNeutralToEmpty(a,.zero,<>+)
        }

        property("Bool is a Monoid in regard to the Additive operation") <- forAll { (a: Bool) in
            Law<Bool>.isNeutralToEmpty(a,.one,<>*)
        }
    }

    func testProductSemiring() {
        property("Product is a Monoid in regard to the Additive operation") <- forAll { (a: Product<TestStructure,TestStructure>) in
            Law<Product<TestStructure,TestStructure>>.isNeutralToEmpty(a,.zero,<>+)
        }

        property("Product is a Monoid in regard to the Multiplicative operation") <- forAll { (a: Product<TestStructure,TestStructure>) in
            Law<Product<TestStructure,TestStructure>>.isNeutralToEmpty(a,.one,<>*)
        }
    }

    func testSetMSemiring() {
        property("SetM is a Monoid in regard to the Additive operation") <- forAll { (a: SetM<String>) in
            Law<SetM<String>>.isNeutralToEmpty(a,.zero,<>+)
        }

        property("SetM is a Monoid in regard to the Multiplicative operation") <- forAll { (a: SetM<String>) in
            Law<SetM<String>>.isNeutralToEmpty(a,.one,<>*)
        }
    }

    func testTropicalSemiring() {
        property("Tropical is a Monoid in regard to the Additive operation") <- forAll { (a: Tropical<Int>) in
            Law<Tropical<Int>>.isNeutralToEmpty(a,.zero,<>+)
        }

        property("Tropical is a Monoid in regard to the Multiplicative operation") <- forAll { (a: Tropical<Int>) in
            Law<Tropical<Int>>.isNeutralToEmpty(a,.one,<>*)
        }
    }

	static var allTests = [
		("testAdd",testAdd),
		("testAnd",testAnd),
		("testArray",testArray),
		("testEndofunction",testEndofunction),
		("testMax",testMax),
		("testMin",testMin),
		("testMultiply",testMultiply),
		("testMultiset",testMultiset),
		("testOptional",testOptional),
		("testOr",testOr),
		("testOrdering",testOrdering),
		("testProduct",testProduct),
		("testSet",testSet),
		("testString",testString),
		("testUpdate",testUpdate),
        ("testBoolSemiring",testBoolSemiring),
        ("testProductSemiring",testProductSemiring),
        ("testSetMSemiring",testSetMSemiring),
        ("testTropicalSemiring",testTropicalSemiring),
	]
}
