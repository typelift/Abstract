import XCTest
@testable import Abstract
import SwiftCheck

final class AbstractTests: XCTestCase {
	func testSemigroup() {
		property("Add is a Semigroup") <- forAll { (a: AddOf<Int>, b: AddOf<Int>, c: AddOf<Int>) in
			Law<Add<Int>>.associativity(a.get,b.get,c.get)
		}
		
		property("Multiply is a Semigroup") <- forAll { (a: MultiplyOf<Int>, b: MultiplyOf<Int>, c: MultiplyOf<Int>) in
			Law<Multiply<Int>>.associativity(a.get,b.get,c.get)
		}
		
		property("Max is a Semigroup") <- forAll { (a: MaxOf<Int>, b: MaxOf<Int>, c: MaxOf<Int>) in
			Law<Max<Int>>.associativity(a.get,b.get,c.get)
		}

		property("Min is a Semigroup") <- forAll { (a: MinOf<Int>, b: MinOf<Int>, c: MinOf<Int>) in
			Law<Min<Int>>.associativity(a.get,b.get,c.get)
		}
		
		property("FunctionI is a Semigroup") <- forAll { (a: FunctionIOf<Int>, b: FunctionIOf<Int>, c: FunctionIOf<Int>, context: Int) in
			LawInContext<FunctionI<Int>>.associativity(a.get, b.get, c.get)(context)
		}
		
		property("FunctionS is a Semigroup") <- forAll { (a: FunctionSOf<Int,TestStructure>, b: FunctionSOf<Int,TestStructure>, c: FunctionSOf<Int,TestStructure>, context: Int) in
			LawInContext<FunctionS<Int,TestStructure>>.associativity(a.get, b.get, c.get)(context)
		}
		
		property("Ordering is a Semigroup") <- forAll { (a: Ordering, b: Ordering, c: Ordering) in
			Law<Ordering>.associativity(a, b, c)
		}
	}
	
	func testMonoid() {
		property("Add is a Monoid") <- forAll { (a: AddOf<Int>) in
			Law<Add<Int>>.neutralityToEmpty(a.get)
		}
		
		property("Multiply is a Monoid") <- forAll { (a: MultiplyOf<Int>) in
			Law<Multiply<Int>>.neutralityToEmpty(a.get)
		}

		property("Max is a Monoid") <- forAll { (a: MaxOf<Int>) in
			Law<Max<Int>>.neutralityToEmpty(a.get)
		}

		property("Min is a Monoid") <- forAll { (a: MinOf<Int>) in
			Law<Min<Int>>.neutralityToEmpty(a.get)
		}
		
		property("FunctionM is a Monoid") <- forAll { (a: FunctionMOf<Int,TestStructure>, context: Int) in
			LawInContext<FunctionM<Int,TestStructure>>.neutralityToEmpty(a.get)(context)
		}
		
		property("Ordering is a Monoid") <- forAll { (a: Ordering) in
			Law<Ordering>.neutralityToEmpty(a)
		}
	}
	
	static var allTests = [
		("testSemigroup", testSemigroup),
		("testMonoid", testMonoid)
	]
}
