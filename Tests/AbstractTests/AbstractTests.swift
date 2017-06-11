import XCTest
@testable import Abstract
import SwiftCheck

final class AbstractTests: XCTestCase {
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

		property("Bool is a Semigroup") <- forAll { (a: Bool, b: Bool, c: Bool) in
			Law<Bool>.isAssociative(a,b,c)
		}

		property("FunctionI is a Semigroup") <- forAll { (a: FunctionIOf<Int>, b: FunctionIOf<Int>, c: FunctionIOf<Int>, context: Int) in
			LawInContext<FunctionI<Int>>.isAssociative(a.get, b.get, c.get)(context)
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
		
		property("Bool is a Monoid") <- forAll { (a: Bool) in
			Law<Bool>.isNeutralToEmpty(a)
		}
		
		property("FunctionI is a Monoid") <- forAll { (a: FunctionIOf<Int>, context: Int) in
			LawInContext<FunctionI<Int>>.isNeutralToEmpty(a.get)(context)
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

		property("Bool is a Commutative Monoid") <- forAll { (a: Bool, b: Bool) in
			Law<Bool>.isCommutative(a,b)
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
		
		property("Bool is a Bounded Semilattice") <- forAll { (a: Bool, b: Bool) in
			Law<Bool>.isIdempotent(a,b)
		}
		
		property("FunctionBS is a Bounded Semilattice") <- forAll { (a: FunctionBSOf<Int,TestStructure>, b: FunctionBSOf<Int,TestStructure>, context: Int) in
			LawInContext<FunctionBS<Int,TestStructure>>.isIdempotent(a.get,b.get)(context)
		}
	}
	
	func testHomomorphism() {
		property("Ordering.reversed is a Homomorphism") <- forAll { (a: Ordering, b: Ordering) in
			Law<Ordering>.isHomomorphism({ $0.reversed }, a, b)
		}
		
		property("Comparison.reversed is a Homomorphism") <- forAll { (a: FunctionMOf<TestProduct,Ordering>, b: FunctionMOf<TestProduct,Ordering>, context: TestProduct) in
			LawInContext<Comparison<Int>>.isHomomorphism({ $0.reversed }, Comparison<Int> { a.get.call(TestProduct.init($0)) }, Comparison<Int> { b.get.call(TestProduct.init($0)) })(context.value)
		}
	}
	
	static var allTests = [
		("testSemigroup", testSemigroup),
		("testMonoid", testMonoid),
		("testCommutativeMonoid",testCommutativeMonoid),
		("testBoundedSemilattice",testBoundedSemilattice),
		("testHomomorphism",testHomomorphism)
	]
}
