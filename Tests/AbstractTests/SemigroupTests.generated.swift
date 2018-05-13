// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import Abstract
import SwiftCheck


final class SemigroupTests: XCTestCase {

	func testAdd() {
		property("Add is a Semigroup") <- forAll { (a: Add<Int>, b: Add<Int>, c: Add<Int>) in
			Law<Add<Int>>.isAssociative(a,b,c)
		}
	}

	func testAnd() {
		property("And is a Semigroup") <- forAll { (a: And, b: And, c: And) in
			Law<And>.isAssociative(a,b,c)
		}
	}

	func testArray() {
		property("Array is a Semigroup") <- forAll { (a: Array<Int>, b: Array<Int>, c: Array<Int>) in
			Law<Array<Int>>.isAssociative(a,b,c)
		}
	}

	func testCoproduct() {
		property("Coproduct is a Semigroup") <- forAll { (a: Coproduct<TestStructure,TestStructure>, b: Coproduct<TestStructure,TestStructure>, c: Coproduct<TestStructure,TestStructure>) in
			Law<Coproduct<TestStructure,TestStructure>>.isAssociative(a,b,c)
		}
	}

	func testEndofunction() {
		property("Endofunction is a Semigroup") <- forAll { (a: Endofunction<Int>, b: Endofunction<Int>, c: Endofunction<Int>, context: Int) in
			LawInContext<Endofunction<Int>>.isAssociative(a,b,c)(context)
		}
	}

	func testFirst() {
		property("First is a Semigroup") <- forAll { (a: First<Int>, b: First<Int>, c: First<Int>) in
			Law<First<Int>>.isAssociative(a,b,c)
		}
	}

	func testInclusive() {
		property("Inclusive is a Semigroup") <- forAll { (a: Inclusive<TestStructure,TestStructure>, b: Inclusive<TestStructure,TestStructure>, c: Inclusive<TestStructure,TestStructure>) in
			Law<Inclusive<TestStructure,TestStructure>>.isAssociative(a,b,c)
		}
	}

	func testLast() {
		property("Last is a Semigroup") <- forAll { (a: Last<Int>, b: Last<Int>, c: Last<Int>) in
			Law<Last<Int>>.isAssociative(a,b,c)
		}
	}

	func testMax() {
		property("Max is a Semigroup") <- forAll { (a: Max<Int>, b: Max<Int>, c: Max<Int>) in
			Law<Max<Int>>.isAssociative(a,b,c)
		}
	}

	func testMin() {
		property("Min is a Semigroup") <- forAll { (a: Min<Int>, b: Min<Int>, c: Min<Int>) in
			Law<Min<Int>>.isAssociative(a,b,c)
		}
	}

	func testMultiply() {
		property("Multiply is a Semigroup") <- forAll { (a: Multiply<Int>, b: Multiply<Int>, c: Multiply<Int>) in
			Law<Multiply<Int>>.isAssociative(a,b,c)
		}
	}

	func testMultiset() {
		property("Multiset is a Semigroup") <- forAll { (a: Multiset<Int>, b: Multiset<Int>, c: Multiset<Int>) in
			Law<Multiset<Int>>.isAssociative(a,b,c)
		}
	}

	func testNonEmptyArray() {
		property("NonEmptyArray is a Semigroup") <- forAll { (a: NonEmptyArray<Int>, b: NonEmptyArray<Int>, c: NonEmptyArray<Int>) in
			Law<NonEmptyArray<Int>>.isAssociative(a,b,c)
		}
	}

	func testOptional() {
		property("Optional is a Semigroup") <- forAll { (a: Optional<Int>, b: Optional<Int>, c: Optional<Int>) in
			Law<Optional<Int>>.isAssociative(a,b,c)
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

	func testProduct() {
		property("Product is a Semigroup") <- forAll { (a: Product<TestStructure,TestStructure>, b: Product<TestStructure,TestStructure>, c: Product<TestStructure,TestStructure>) in
			Law<Product<TestStructure,TestStructure>>.isAssociative(a,b,c)
		}
	}

	func testSet() {
		property("Set is a Semigroup") <- forAll { (a: Set<Int>, b: Set<Int>, c: Set<Int>) in
			Law<Set<Int>>.isAssociative(a,b,c)
		}
	}

	func testString() {
		property("String is a Semigroup") <- forAll { (a: String, b: String, c: String) in
			Law<String>.isAssociative(a,b,c)
		}
	}

	func testUpdate() {
		property("Update is a Semigroup") <- forAll { (a: Update<Int>, b: Update<Int>, c: Update<Int>) in
			Law<Update<Int>>.isAssociative(a,b,c)
		}
	}


    func testBoolSemiring() {
        property("Bool is a Semigroup in regard to the Additive operation") <- forAll { (a: Bool, b: Bool, c: Bool) in
            Law<Bool>.isAssociative(a,b,c,<>+)
        }

        property("Bool is a Semigroup in regard to the Multiplicative operation") <- forAll { (a: Bool, b: Bool, c: Bool) in
            Law<Bool>.isAssociative(a,b,c,<>*)
        }
    }

    func testProductSemiring() {
        property("Product is a Semigroup in regard to the Additive operation") <- forAll { (a: Product<TestStructure,TestStructure>, b: Product<TestStructure,TestStructure>, c: Product<TestStructure,TestStructure>) in
            Law<Product<TestStructure,TestStructure>>.isAssociative(a,b,c,<>+)
        }

        property("Product is a Semigroup in regard to the Multiplicative operation") <- forAll { (a: Product<TestStructure,TestStructure>, b: Product<TestStructure,TestStructure>, c: Product<TestStructure,TestStructure>) in
            Law<Product<TestStructure,TestStructure>>.isAssociative(a,b,c,<>*)
        }
    }

    func testSetMSemiring() {
        property("SetM is a Semigroup in regard to the Additive operation") <- forAll { (a: SetM<String>, b: SetM<String>, c: SetM<String>) in
            Law<SetM<String>>.isAssociative(a,b,c,<>+)
        }

        property("SetM is a Semigroup in regard to the Multiplicative operation") <- forAll { (a: SetM<String>, b: SetM<String>, c: SetM<String>) in
            Law<SetM<String>>.isAssociative(a,b,c,<>*)
        }
    }

    func testTropicalSemiring() {
        property("Tropical is a Semigroup in regard to the Additive operation") <- forAll { (a: Tropical<Int>, b: Tropical<Int>, c: Tropical<Int>) in
            Law<Tropical<Int>>.isAssociative(a,b,c,<>+)
        }

        property("Tropical is a Semigroup in regard to the Multiplicative operation") <- forAll { (a: Tropical<Int>, b: Tropical<Int>, c: Tropical<Int>) in
            Law<Tropical<Int>>.isAssociative(a,b,c,<>*)
        }
    }

	static var allTests = [
		("testAdd",testAdd),
		("testAnd",testAnd),
		("testArray",testArray),
		("testCoproduct",testCoproduct),
		("testEndofunction",testEndofunction),
		("testFirst",testFirst),
		("testInclusive",testInclusive),
		("testLast",testLast),
		("testMax",testMax),
		("testMin",testMin),
		("testMultiply",testMultiply),
		("testMultiset",testMultiset),
		("testNonEmptyArray",testNonEmptyArray),
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
