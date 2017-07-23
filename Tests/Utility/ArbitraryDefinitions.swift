import XCTest
@testable import Abstract
#if !XCODE_BUILD
    import Operadics
#endif
import SwiftCheck

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
	typealias Wrapped = (Int,Int)

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

struct ArbitraryEndofunction<A: Arbitrary & CoArbitrary & Hashable>: Arbitrary {
	let get: Endofunction<A>
	
	init(_ value: @escaping (A) -> A) {
		self.get = Endofunction.init(value)
	}
	
	static var arbitrary: Gen<ArbitraryEndofunction<A>> {
		return ArrowOf<A,A>.arbitrary.map { $0.getArrow }.map(ArbitraryEndofunction<A>.init)
	}
}

struct ArbitraryFunctionS<A: CoArbitrary & Hashable, S: Arbitrary & Semigroup & Equatable>: Arbitrary {
	let get: FunctionS<A,S>
	
	init(_ value: @escaping (A) -> S) {
		self.get = FunctionS.init(value)
	}
	
	static var arbitrary: Gen<ArbitraryFunctionS<A,S>> {
		return ArrowOf<A,S>.arbitrary.map { $0.getArrow }.map(ArbitraryFunctionS<A,S>.init)
	}
}

struct ArbitraryFunctionM<A: CoArbitrary & Hashable, M: Arbitrary & Monoid & Equatable>: Arbitrary {
	let get: FunctionM<A,M>
	
	init(_ value: @escaping (A) -> M) {
		self.get = FunctionM.init(value)
	}
	
	static var arbitrary: Gen<ArbitraryFunctionM<A,M>> {
		return ArrowOf<A,M>.arbitrary.map { $0.getArrow }.map(ArbitraryFunctionM<A,M>.init)
	}
}

struct ArbitraryFunctionCM<A: CoArbitrary & Hashable, M: Arbitrary & CommutativeMonoid & Equatable>: Arbitrary {
	let get: FunctionCM<A,M>
	
	init(_ value: @escaping (A) -> M) {
		self.get = FunctionCM.init(value)
	}
	
	static var arbitrary: Gen<ArbitraryFunctionCM<A,M>> {
		return ArrowOf<A,M>.arbitrary.map { $0.getArrow }.map(ArbitraryFunctionCM<A,M>.init)
	}
}

struct ArbitraryFunctionBS<A: CoArbitrary & Hashable, M: Arbitrary & BoundedSemilattice & Equatable>: Arbitrary {
	let get: FunctionBS<A,M>
	
	init(_ value: @escaping (A) -> M) {
		self.get = FunctionBS.init(value)
	}
	
	static var arbitrary: Gen<ArbitraryFunctionBS<A,M>> {
		return ArrowOf<A,M>.arbitrary.map { $0.getArrow }.map(ArbitraryFunctionBS<A,M>.init)
	}
}

struct ArbitraryFunctionSR<A: CoArbitrary & Hashable, SR: Arbitrary & Semiring & Equatable>: Arbitrary where SR.Additive: Equatable, SR.Multiplicative: Equatable {
	let get: FunctionSR<A,SR>

	init(_ value: @escaping (A) -> SR) {
		self.get = FunctionSR.init(value)
	}

	static var arbitrary: Gen<ArbitraryFunctionSR<A,SR>> {
		return ArrowOf<A,SR>.arbitrary.map { $0.getArrow }.map(ArbitraryFunctionSR<A,SR>.init)
	}
}
