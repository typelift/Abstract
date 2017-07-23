import XCTest
@testable import Abstract
import SwiftCheck

final class HomomorphismTests: XCTestCase {

	func testOrderingReversed() {
		property("Ordering.reversed is a Homomorphism") <- forAll { (a: Ordering, b: Ordering) in
			Law<Ordering>.isHomomorphism({ $0.reversed }, a, b)
		}
	}

	func testComparisonReversed() {
		property("Comparison.reversed is a Homomorphism") <- forAll { (a: FunctionMOf<TestProduct,Ordering>, b: FunctionMOf<TestProduct,Ordering>, context: TestProduct) in
			LawInContext<Comparison<Int>>.isHomomorphism({ $0.reversed }, Comparison<Int> { a.get.call(TestProduct.init($0)) }, Comparison<Int> { b.get.call(TestProduct.init($0)) })(context.unwrap)
		}
	}
	
	static var allTests = [
		("testOrderingReversed",testOrderingReversed),
		("testComparisonReversed",testComparisonReversed)
	]
}
