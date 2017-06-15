import XCTest
@testable import Abstract
import SwiftCheck

final class AbstractTests: XCTestCase {
	func testWrapper() {
		property("Add is a Wrapper") <- forAll { (a: Int) in
			Law<Add<Int>>.isIsomorphic(a)
		}

		property("Multiply is a Wrapper") <- forAll { (a: Int) in
			Law<Multiply<Int>>.isIsomorphic(a)
		}

		property("Max is a Wrapper") <- forAll { (a: Int) in
			Law<Max<Int>>.isIsomorphic(a)
		}

		property("Min is a Wrapper") <- forAll { (a: Int) in
			Law<Min<Int>>.isIsomorphic(a)
		}

		property("And is a Wrapper") <- forAll { (a: Bool) in
			Law<And>.isIsomorphic(a)
		}

		property("Or is a Wrapper") <- forAll { (a: Bool) in
			Law<Or>.isIsomorphic(a)
		}

		property("Endofunction is a Wrapper") <- forAll { (a: ArrowOf<Int,Int>, context: Int) in
			LawInContext<Endofunction<Int>>.isIsomorphic(a.getArrow, isEqual: { v1, v2 in { v1($0) == v2($0) }})(context)
		}

		property("FunctionS is a Wrapper") <- forAll { (a: ArrowOf<Int,TestStructure>, context: Int) in
			LawInContext<FunctionS<Int,TestStructure>>.isIsomorphic(a.getArrow, isEqual: { v1, v2 in { v1($0) == v2($0) }})(context)
		}

		property("FunctionM is a Wrapper") <- forAll { (a: ArrowOf<Int,TestStructure>, context: Int) in
			LawInContext<FunctionM<Int,TestStructure>>.isIsomorphic(a.getArrow, isEqual: { v1, v2 in { v1($0) == v2($0) }})(context)
		}

		property("FunctionCM is a Wrapper") <- forAll { (a: ArrowOf<Int,TestStructure>, context: Int) in
			LawInContext<FunctionCM<Int,TestStructure>>.isIsomorphic(a.getArrow, isEqual: { v1, v2 in { v1($0) == v2($0) }})(context)
		}

		property("FunctionBS is a Wrapper") <- forAll { (a: ArrowOf<Int,TestStructure>, context: Int) in
			LawInContext<FunctionBS<Int,TestStructure>>.isIsomorphic(a.getArrow, isEqual: { v1, v2 in { v1($0) == v2($0) }})(context)
		}
	}

	func testSemigroup() {
		property("Add is a Semigroup") <- forAll { (a: AddOf<Int>, b: AddOf<Int>, c: AddOf<Int>) in
			Law<Add<Int>>.isAssociative(a.get,b.get,c.get)
		}
		
		property("Multiply is a Semigroup") <- forAll { (a: MultiplyOf<Int>, b: MultiplyOf<Int>, c: MultiplyOf<Int>) in
			Law<Multiply<Int>>.isAssociative(a.get,b.get,c.get)
		}
		
		property("Max is a Semigroup") <- forAll { (a: MaxOf<Int>, b: MaxOf<Int>, c: MaxOf<Int>) in
			Law<Max<Int>>.isAssociative(a.get,b.get,c.get)
		}

		property("Min is a Semigroup") <- forAll { (a: MinOf<Int>, b: MinOf<Int>, c: MinOf<Int>) in
			Law<Min<Int>>.isAssociative(a.get,b.get,c.get)
		}

		property("And is a Semigroup") <- forAll { (a: And, b: And, c: And) in
			Law<And>.isAssociative(a,b,c)
		}

		property("Or is a Semigroup") <- forAll { (a: Or, b: Or, c: Or) in
			Law<Or>.isAssociative(a,b,c)
		}

		property("Endofunction is a Semigroup") <- forAll { (a: EndofunctionOf<Int>, b: EndofunctionOf<Int>, c: EndofunctionOf<Int>, context: Int) in
			LawInContext<Endofunction<Int>>.isAssociative(a.get, b.get, c.get)(context)
		}
		
		property("FunctionS is a Semigroup") <- forAll { (a: FunctionSOf<Int,TestStructure>, b: FunctionSOf<Int,TestStructure>, c: FunctionSOf<Int,TestStructure>, context: Int) in
			LawInContext<FunctionS<Int,TestStructure>>.isAssociative(a.get, b.get, c.get)(context)
		}
		
		property("Ordering is a Semigroup") <- forAll { (a: Ordering, b: Ordering, c: Ordering) in
			Law<Ordering>.isAssociative(a, b, c)
		}
	}
	
	func testMonoid() {
		property("Add is a Monoid") <- forAll { (a: AddOf<Int>) in
			Law<Add<Int>>.isNeutralToEmpty(a.get)
		}
		
		property("Multiply is a Monoid") <- forAll { (a: MultiplyOf<Int>) in
			Law<Multiply<Int>>.isNeutralToEmpty(a.get)
		}

		property("Max is a Monoid") <- forAll { (a: MaxOf<Int>) in
			Law<Max<Int>>.isNeutralToEmpty(a.get)
		}

		property("Min is a Monoid") <- forAll { (a: MinOf<Int>) in
			Law<Min<Int>>.isNeutralToEmpty(a.get)
		}
		
		property("And is a Monoid") <- forAll { (a: And) in
			Law<And>.isNeutralToEmpty(a)
		}

		property("Or is a Monoid") <- forAll { (a: Or) in
			Law<Or>.isNeutralToEmpty(a)
		}

		property("Endofunction is a Monoid") <- forAll { (a: EndofunctionOf<Int>, context: Int) in
			LawInContext<Endofunction<Int>>.isNeutralToEmpty(a.get)(context)
		}

		property("FunctionM is a Monoid") <- forAll { (a: FunctionMOf<Int,TestStructure>, context: Int) in
			LawInContext<FunctionM<Int,TestStructure>>.isNeutralToEmpty(a.get)(context)
		}
		
		property("Ordering is a Monoid") <- forAll { (a: Ordering) in
			Law<Ordering>.isNeutralToEmpty(a)
		}
	}
	
	func testCommutativeMonoid() {
		property("Add is a Commutative Monoid") <- forAll { (a: AddOf<Int>, b: AddOf<Int>) in
			Law<Add<Int>>.isCommutative(a.get,b.get)
		}

		property("Multiply is a Commutative Monoid") <- forAll { (a: MultiplyOf<Int>, b: MultiplyOf<Int>) in
			Law<Multiply<Int>>.isCommutative(a.get,b.get)
		}

		property("Max is a Commutative Monoid") <- forAll { (a: MaxOf<Int>, b: MaxOf<Int>) in
			Law<Max<Int>>.isCommutative(a.get,b.get)
		}

		property("Min is a Commutative Monoid") <- forAll { (a: MinOf<Int>, b: MinOf<Int>) in
			Law<Min<Int>>.isCommutative(a.get,b.get)
		}

		property("And is a Commutative Monoid") <- forAll { (a: And, b: And) in
			Law<And>.isCommutative(a,b)
		}

		property("Or is a Commutative Monoid") <- forAll { (a: Or, b: Or) in
			Law<Or>.isCommutative(a,b)
		}

		property("FunctionCM is a Commutative Monoid") <- forAll { (a: FunctionCMOf<Int,TestStructure>, b: FunctionCMOf<Int,TestStructure>, context: Int) in
			LawInContext<FunctionCM<Int,TestStructure>>.isCommutative(a.get,b.get)(context)
		}
	}
	
	func testBoundedSemilattice() {
		property("Max is a Bounded Semilattice") <- forAll { (a: MaxOf<Int>, b: MaxOf<Int>) in
			Law<Max<Int>>.isIdempotent(a.get,b.get)
		}
		
		property("Min is a Bounded Semilattice") <- forAll { (a: MinOf<Int>, b: MinOf<Int>) in
			Law<Min<Int>>.isIdempotent(a.get,b.get)
		}
		
		property("And is a Bounded Semilattice") <- forAll { (a: And, b: And) in
			Law<And>.isIdempotent(a,b)
		}

		property("Or is a Bounded Semilattice") <- forAll { (a: Or, b: Or) in
			Law<Or>.isIdempotent(a,b)
		}

		property("FunctionBS is a Bounded Semilattice") <- forAll { (a: FunctionBSOf<Int,TestStructure>, b: FunctionBSOf<Int,TestStructure>, context: Int) in
			LawInContext<FunctionBS<Int,TestStructure>>.isIdempotent(a.get,b.get)(context)
		}
	}

	func testSemiring() {
		property("Bool is a Semiring: Distributive") <- forAll { (a: Bool, b: Bool, c: Bool) in
			Law<Bool>.multiplicationIsDistributiveOverAddition(a, b, c)
		}

		property("Bool is a Semiring: Annihilation") <- forAll { (a: Bool) in
			Law<Bool>.zeroAnnihiliatesTheMultiplicative(a)
		}

		property("FunctionSR is a Semiring: Distributive") <- forAll { (a: FunctionSROf<Int,TestSemiring>, b: FunctionSROf<Int,TestSemiring>, c: FunctionSROf<Int,TestSemiring>, context: Int) in
			LawInContext<FunctionSR<Int,TestSemiring>>.multiplicationIsDistributiveOverAddition(a.get, b.get, c.get)(context)
		}

		property("FunctionSR is a Semiring: Annihilation") <- forAll { (a: FunctionSROf<Int,TestSemiring>, context: Int) in
			LawInContext<FunctionSR<Int,TestSemiring>>.zeroAnnihiliatesTheMultiplicative(a.get)(context)
		}
	}

	func testHomomorphism() {
		property("Ordering.reversed is a Homomorphism") <- forAll { (a: Ordering, b: Ordering) in
			Law<Ordering>.isHomomorphism({ $0.reversed }, a, b)
		}
		
		property("Comparison.reversed is a Homomorphism") <- forAll { (a: FunctionMOf<TestProduct,Ordering>, b: FunctionMOf<TestProduct,Ordering>, context: TestProduct) in
			LawInContext<Comparison<Int>>.isHomomorphism({ $0.reversed }, Comparison<Int> { a.get.call(TestProduct.init($0)) }, Comparison<Int> { b.get.call(TestProduct.init($0)) })(context.unwrap)
		}
	}
	
	static var allTests = [
		("testWrapper", testWrapper),
		("testSemigroup", testSemigroup),
		("testMonoid", testMonoid),
		("testCommutativeMonoid",testCommutativeMonoid),
		("testBoundedSemilattice",testBoundedSemilattice),
		("testSemiring",testSemiring),
		("testHomomorphism",testHomomorphism)
	]
}
