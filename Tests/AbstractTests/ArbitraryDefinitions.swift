import XCTest
@testable import Abstract
import SwiftCheck

struct TestStructure: Arbitrary, Monoid, Equatable {
	let value: Int
	
	init(_ value: Int) {
		self.value = value
	}
	
	static var arbitrary: Gen<TestStructure> {
		return Int.arbitrary.map(TestStructure.init)
	}
	
	static func <> (left: TestStructure, right: TestStructure) -> TestStructure {
		return TestStructure((Add(left.value) <> Add(right.value)).value)
	}
	
	static var e: TestStructure {
		return TestStructure(Add<Int>.e.value)
	}
	
	static func == (left: TestStructure, right: TestStructure) -> Bool {
		return Add(left.value) == Add(right.value)
	}
}

struct AddOf<T: Arbitrary & Summable>: Arbitrary {
	let get: Add<T>
	
	init(_ value: T) {
		self.get = Add(value)
	}
	
	static var arbitrary: Gen<AddOf<T>> {
		return T.arbitrary.map(AddOf.init)
	}
}

struct MultiplyOf<T: Arbitrary & Multipliable>: Arbitrary {
	let get: Multiply<T>
	
	init(_ value: T) {
		self.get = Multiply(value)
	}
	
	static var arbitrary: Gen<MultiplyOf<T>> {
		return T.arbitrary.map(MultiplyOf.init)
	}
}

struct MaxOf<T: Arbitrary & ComparableToBottom>: Arbitrary {
	let get: Max<T>
	
	init(_ value: T) {
		self.get = Max(value)
	}
	
	static var arbitrary: Gen<MaxOf<T>> {
		return T.arbitrary.map(MaxOf.init)
	}
}

struct MinOf<T: Arbitrary & ComparableToTop>: Arbitrary {
	let get: Min<T>
	
	init(_ value: T) {
		self.get = Min(value)
	}
	
	static var arbitrary: Gen<MinOf<T>> {
		return T.arbitrary.map(MinOf.init)
	}
}

struct FunctionIOf<T: Arbitrary & CoArbitrary & Hashable>: Arbitrary {
	let get: FunctionI<T>
	
	init(_ value: @escaping (T) -> T) {
		self.get = FunctionI.init(value)
	}
	
	static var arbitrary: Gen<FunctionIOf<T>> {
		return ArrowOf<T,T>.arbitrary.map { $0.getArrow }.map(FunctionIOf<T>.init)
	}
}

struct FunctionSOf<T: CoArbitrary & Hashable, S: Arbitrary & Semigroup & Equatable>: Arbitrary {
	let get: FunctionS<T,S>
	
	init(_ value: @escaping (T) -> S) {
		self.get = FunctionS.init(value)
	}
	
	static var arbitrary: Gen<FunctionSOf<T,S>> {
		return ArrowOf<T,S>.arbitrary.map { $0.getArrow }.map(FunctionSOf<T,S>.init)
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

struct FunctionMOf<T: CoArbitrary & Hashable, M: Arbitrary & Monoid & Equatable>: Arbitrary {
	let get: FunctionM<T,M>
	
	init(_ value: @escaping (T) -> M) {
		self.get = FunctionM.init(value)
	}
	
	static var arbitrary: Gen<FunctionMOf<T,M>> {
		return ArrowOf<T,M>.arbitrary.map { $0.getArrow }.map(FunctionMOf<T,M>.init)
	}
}
