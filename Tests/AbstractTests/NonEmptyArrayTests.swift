import XCTest
@testable import Abstract
import SwiftCheck

final class NonEmptyArrayTests: XCTestCase {
	func testArrayIsomorphism() {
		property("NonEmptyArray is isomorphic to an non empty Array") <- forAll { (a: Array<Int>) in
			(a.isEmpty == false) ==> {
				NonEmptyArray(a)!.unwrap == a
			}
		}
	}

	static var allTests = [
		("testArrayIsomorphism",testArrayIsomorphism)
	]
}
