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

struct AddOf<A: Arbitrary & Addable>: Arbitrary {
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

struct EndofunctionOf<A: Arbitrary & CoArbitrary & Hashable>: Arbitrary {
	let get: Endofunction<A>
	
	init(_ value: @escaping (A) -> A) {
		self.get = Endofunction.init(value)
	}
	
	static var arbitrary: Gen<EndofunctionOf<A>> {
		return ArrowOf<A,A>.arbitrary.map { $0.getArrow }.map(EndofunctionOf<A>.init)
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

struct FunctionSROf<A: CoArbitrary & Hashable, SR: Arbitrary & Semiring & Equatable>: Arbitrary where SR.Additive: Equatable, SR.Multiplicative: Equatable {
	let get: FunctionSR<A,SR>

	init(_ value: @escaping (A) -> SR) {
		self.get = FunctionSR.init(value)
	}

	static var arbitrary: Gen<FunctionSROf<A,SR>> {
		return ArrowOf<A,SR>.arbitrary.map { $0.getArrow }.map(FunctionSROf<A,SR>.init)
	}
}

struct TropicalOf<A: Arbitrary & ComparableToTop & Addable>: Arbitrary {
    let get: Tropical<A>
    
    init(_ value: A) {
        self.get = Tropical(value)
    }
    
    public static var arbitrary: Gen<TropicalOf<A>> {
        return A.arbitrary.map(TropicalOf.init)
    }
}
