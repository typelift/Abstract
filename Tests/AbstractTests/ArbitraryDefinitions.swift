import XCTest
@testable import Abstract
import Operadics
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
		return TestStructure((left.get <> right.get).value)
	}
	
	static var empty: TestStructure {
		return TestStructure(Max<Int>.empty.value)
	}
	
	static func == (left: TestStructure, right: TestStructure) -> Bool {
		return left.get == right.get
	}
}

struct TestProduct: CoArbitrary, Hashable, Arbitrary {
	let value: (Int,Int)
	
	init(_ value: (Int,Int)) {
		self.value = value
	}
	
	static func coarbitrary<C>(_ x: TestProduct) -> ((Gen<C>) -> Gen<C>) {
		return { Int.coarbitrary(x.value.1)(Int.coarbitrary(x.value.0)($0)) }
	}
	
	static func == (left: TestProduct, right: TestProduct) -> Bool {
		return left.value == right.value
	}
	
	var hashValue: Int {
		return "\(value.0),\(value.1)".hashValue
	}
	
	static var arbitrary: Gen<TestProduct> {
		return Gen<TestProduct>.compose { TestProduct.init(($0.generate(),$0.generate())) }
	}
}

struct AddOf<A: Arbitrary & Summable>: Arbitrary {
	let get: Add<A>
	
	init(_ value: A) {
		self.get = Add(value)
	}
	
	static var arbitrary: Gen<AddOf<A>> {
		return A.arbitrary.map(AddOf.init)
	}
}

struct MultiplyOf<A: Arbitrary & Multipliable>: Arbitrary {
	let get: Multiply<A>
	
	init(_ value: A) {
		self.get = Multiply(value)
	}
	
	static var arbitrary: Gen<MultiplyOf<A>> {
		return A.arbitrary.map(MultiplyOf.init)
	}
}

struct MaxOf<A: Arbitrary & ComparableToBottom>: Arbitrary {
	let get: Max<A>
	
	init(_ value: A) {
		self.get = Max(value)
	}
	
	static var arbitrary: Gen<MaxOf<A>> {
		return A.arbitrary.map(MaxOf.init)
	}
}

struct MinOf<A: Arbitrary & ComparableToTop>: Arbitrary {
	let get: Min<A>
	
	init(_ value: A) {
		self.get = Min(value)
	}
	
	static var arbitrary: Gen<MinOf<A>> {
		return A.arbitrary.map(MinOf.init)
	}
}

extension And: Arbitrary {
	public static var arbitrary: Gen<And> {
		return Bool.arbitrary.map(And.init(_:))
	}
}

extension Or: Arbitrary {
	public static var arbitrary: Gen<Or> {
		return Bool.arbitrary.map(Or.init(_:))
	}
}

struct FunctionIOf<A: Arbitrary & CoArbitrary & Hashable>: Arbitrary {
	let get: FunctionI<A>
	
	init(_ value: @escaping (A) -> A) {
		self.get = FunctionI.init(value)
	}
	
	static var arbitrary: Gen<FunctionIOf<A>> {
		return ArrowOf<A,A>.arbitrary.map { $0.getArrow }.map(FunctionIOf<A>.init)
	}
}

struct FunctionSOf<A: CoArbitrary & Hashable, S: Arbitrary & Semigroup & Equatable>: Arbitrary {
	let get: FunctionS<A,S>
	
	init(_ value: @escaping (A) -> S) {
		self.get = FunctionS.init(value)
	}
	
	static var arbitrary: Gen<FunctionSOf<A,S>> {
		return ArrowOf<A,S>.arbitrary.map { $0.getArrow }.map(FunctionSOf<A,S>.init)
	}
}

extension Ordering: Arbitrary {
	public static var arbitrary: Gen<Ordering> {
		return Gen<Int>.fromElements(of: [0,1,2]).map {
			switch $0 {
			case 0:
				return .lowerThan
			case 1:
				return .equalTo
			case 2:
				return .greaterThan
			default:
				fatalError()
			}
		}
	}
}

struct FunctionMOf<A: CoArbitrary & Hashable, M: Arbitrary & Monoid & Equatable>: Arbitrary {
	let get: FunctionM<A,M>
	
	init(_ value: @escaping (A) -> M) {
		self.get = FunctionM.init(value)
	}
	
	static var arbitrary: Gen<FunctionMOf<A,M>> {
		return ArrowOf<A,M>.arbitrary.map { $0.getArrow }.map(FunctionMOf<A,M>.init)
	}
}

struct FunctionCMOf<A: CoArbitrary & Hashable, M: Arbitrary & CommutativeMonoid & Equatable>: Arbitrary {
	let get: FunctionCM<A,M>
	
	init(_ value: @escaping (A) -> M) {
		self.get = FunctionCM.init(value)
	}
	
	static var arbitrary: Gen<FunctionCMOf<A,M>> {
		return ArrowOf<A,M>.arbitrary.map { $0.getArrow }.map(FunctionCMOf<A,M>.init)
	}
}

struct FunctionBSOf<A: CoArbitrary & Hashable, M: Arbitrary & BoundedSemilattice & Equatable>: Arbitrary {
	let get: FunctionBS<A,M>
	
	init(_ value: @escaping (A) -> M) {
		self.get = FunctionBS.init(value)
	}
	
	static var arbitrary: Gen<FunctionBSOf<A,M>> {
		return ArrowOf<A,M>.arbitrary.map { $0.getArrow }.map(FunctionBSOf<A,M>.init)
	}
}

