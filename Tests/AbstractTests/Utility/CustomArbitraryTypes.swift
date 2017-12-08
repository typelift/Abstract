import XCTest
@testable import Abstract
import SwiftCheck
#if SWIFT_PACKAGE
	import Operadics
#endif

struct TestStructure: Arbitrary, BoundedSemilattice, Equatable {
	let get: Max<Int>
	
	init(_ value: Int) {
		self.get = Max(value)
	}
	
	static var arbitrary: Gen<TestStructure> {
		return Int.arbitrary.map(TestStructure.init)
	}
	
	static func <> (left: TestStructure, right: TestStructure) -> TestStructure {
		return TestStructure((left.get <> right.get).unwrap)
	}
	
	static var empty: TestStructure {
		return TestStructure(Max<Int>.empty.unwrap)
	}
	
	static func == (left: TestStructure, right: TestStructure) -> Bool {
		return left.get == right.get
	}
}

struct TestFunction: Arbitrary, BoundedSemilattice, EquatableInContext {
	typealias Context = String
	let get: FunctionBS<String,Max<Int>>

	init(_ value: @escaping (String) -> Max<Int>) {
		self.get = FunctionBS.init(value)
	}

	static var arbitrary: Gen<TestFunction> {
		return ArrowOf<String,MaxOf<Int>>.arbitrary
			.map { f in { f.getArrow($0).get } }
			.map(TestFunction.init)
	}

	static func <> (left: TestFunction, right: TestFunction) -> TestFunction {
		return TestFunction((left.get <> right.get).unwrap)
	}

	static var empty: TestFunction {
		return TestFunction.init { _ in Max<Int>.empty }
	}

	static func == (left: TestFunction, right: TestFunction) -> (Context) -> Bool {
		return left.get == right.get
	}
}

struct TestSemiring: Arbitrary, Semiring, Equatable {
	typealias Additive = Bool.Additive
	typealias Multiplicative = Bool.Multiplicative

	let get: Bool

	init(_ value: Bool) {
		self.get = value
	}

	static var arbitrary: Gen<TestSemiring> {
		return Bool.arbitrary.map(TestSemiring.init)
	}

	static func <>+(left: TestSemiring, right: TestSemiring) -> TestSemiring {
		return TestSemiring(left.get <>+ right.get)
	}

	static func <>*(left: TestSemiring, right: TestSemiring) -> TestSemiring {
		return TestSemiring(left.get <>* right.get)
	}

	static var zero: TestSemiring {
		return TestSemiring(Bool.zero)
	}

	static var one: TestSemiring {
		return TestSemiring(Bool.one)
	}

	static func == (left: TestSemiring, right: TestSemiring) -> Bool {
		return left.get == right.get
	}
}

struct TestProduct: CoArbitrary, Hashable, Arbitrary, Wrapper {
	typealias WrappedType = (Int,Int)

	let unwrap: (Int,Int)
	
	init(_ value: (Int,Int)) {
		self.unwrap = value
	}
	
	static func coarbitrary<C>(_ x: TestProduct) -> ((Gen<C>) -> Gen<C>) {
		return { Int.coarbitrary(x.unwrap.1)(Int.coarbitrary(x.unwrap.0)($0)) }
	}
	
	static func == (left: TestProduct, right: TestProduct) -> Bool {
		return left.unwrap == right.unwrap
	}
	
	var hashValue: Int {
		return "\(unwrap.0),\(unwrap.1)".hashValue
	}
	
	static var arbitrary: Gen<TestProduct> {
		return Gen<TestProduct>.compose { TestProduct.init(($0.generate(),$0.generate())) }
	}
}

struct EndofunctionOf<A: Arbitrary & CoArbitrary & Hashable>: Arbitrary {
	let get: Endofunction<A>
	
	init(_ value: @escaping (A) -> A) {
		self.get = Endofunction.init(value)
	}
	
	static var arbitrary: Gen<EndofunctionOf<A>> {
		return ArrowOf<A,A>.arbitrary.map { $0.getArrow }.map(EndofunctionOf<A>.init)
	}
}
