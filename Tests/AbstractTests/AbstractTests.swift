import XCTest
@testable import Abstract
import SwiftCheck

final class AbstractTests: XCTestCase {
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
        
        property("Tropical is a Semiring: Distributive") <- forAll { (a: TropicalOf<Int>, b: TropicalOf<Int>, c: TropicalOf<Int>) in
            Law<Tropical<Int>>.multiplicationIsDistributiveOverAddition(a.get, b.get, c.get)
        }
        
        property("Tropical is a Semiring: Annihilation") <- forAll { (a: TropicalOf<Int>) in
            Law<Tropical<Int>>.zeroAnnihiliatesTheMultiplicative(a.get)
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
		("testSemiring",testSemiring),
		("testHomomorphism",testHomomorphism)
	]
}
