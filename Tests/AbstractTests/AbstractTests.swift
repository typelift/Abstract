import XCTest
@testable import Abstract
import SwiftCheck

final class AbstractTests: XCTestCase {
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
