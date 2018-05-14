import XCTest
@testable import Abstract
import SwiftCheck

final class FunctionTests: XCTestCase {
	func testWellBehavedWrapped() {
		property("Function is a well-behaved Wrapper") <- forAll { (a: Function<Int,Int>, context: Int) in
			LawInContext<Function<Int,Int>>.isWellBehavedWrapper(a)(context)
		}
	}

	func testSemigroup() {
		property("Function is a Semigroup") <- forAll { (a: Function<Int,TestStructure>, b: Function<Int,TestStructure>, c: Function<Int,TestStructure>, context: Int) in
			LawInContext<Function<Int,TestStructure>>.isAssociative(a,b,c)(context)
		}
	}

	func testMonoid() {
		property("Function is a Monoid") <- forAll { (a: Function<Int,TestStructure>, context: Int) in
			LawInContext<Function<Int,TestStructure>>.isNeutralToEmpty(a)(context)
		}
	}

	func testCommutativeMonoid() {
		property("Function is a CommutativeMonoid") <- forAll { (a: Function<Int,TestStructure>, b: Function<Int,TestStructure>, context: Int) in
			LawInContext<Function<Int,TestStructure>>.isCommutative(a,b)(context)
		}
	}

	func testBoundedSemilattice() {
		property("Function is a BoundedSemilattice") <- forAll { (a: Function<Int,TestStructure>, b: Function<Int,TestStructure>, context: Int) in
			LawInContext<Function<Int,TestStructure>>.isIdempotent(a,b)(context)
		}
	}

	func testSemiring() {
		property("Function is a Semiring: Distributive") <- forAll { (a: Function<Int,TestStructure>, b: Function<Int,TestStructure>, c: Function<Int,TestStructure>, context: Int) in
			LawInContext<Function<Int,TestStructure>>.multiplicationIsDistributiveOverAddition(a,b,c)(context)
		}

		property("Function is a Semiring: Annihilation") <- forAll { (a: Function<Int,TestStructure>, context: Int) in
			LawInContext<Function<Int,TestStructure>>.zeroAnnihiliatesTheMultiplicative(a)(context)
		}
	}

	static var allTests = [
		("testWellBehavedWrapped",testWellBehavedWrapped),
		("testSemigroup",testSemigroup),
		("testMonoid",testMonoid),
		("testCommutativeMonoid",testCommutativeMonoid),
		("testBoundedSemilattice",testBoundedSemilattice),
		("testSemiring",testSemiring),
	]
}
