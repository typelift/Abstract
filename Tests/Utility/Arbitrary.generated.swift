// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import SwiftCheck
@testable import Abstract


// MARK: - Arbitrary for structs and classes

struct AddOf<T>: Arbitrary where T: Arbitrary & Addable {
    let get: Add<T>
    init(_ get: Add<T>) {
        self.get = get
    }

    public static var arbitrary: Gen<AddOf<T>> {
        return Gen<Add<T>>
            .compose {
                Add<T>.init(
                    unwrap: $0.generate()
                )
            }
            .map(AddOf<T>.init)
    }
}

extension And: Arbitrary {
    public static var arbitrary: Gen<And> {
        return Gen<And>
            .compose {
                And.init(
                    unwrap: $0.generate()
                )
        }
    }
}

struct MaxOf<T>: Arbitrary where T: Arbitrary & ComparableToBottom {
    let get: Max<T>
    init(_ get: Max<T>) {
        self.get = get
    }

    public static var arbitrary: Gen<MaxOf<T>> {
        return Gen<Max<T>>
            .compose {
                Max<T>.init(
                    unwrap: $0.generate()
                )
            }
            .map(MaxOf<T>.init)
    }
}

struct MinOf<T>: Arbitrary where T: Arbitrary & ComparableToTop {
    let get: Min<T>
    init(_ get: Min<T>) {
        self.get = get
    }

    public static var arbitrary: Gen<MinOf<T>> {
        return Gen<Min<T>>
            .compose {
                Min<T>.init(
                    unwrap: $0.generate()
                )
            }
            .map(MinOf<T>.init)
    }
}

struct MultiplyOf<T>: Arbitrary where T: Arbitrary & Multipliable {
    let get: Multiply<T>
    init(_ get: Multiply<T>) {
        self.get = get
    }

    public static var arbitrary: Gen<MultiplyOf<T>> {
        return Gen<Multiply<T>>
            .compose {
                Multiply<T>.init(
                    unwrap: $0.generate()
                )
            }
            .map(MultiplyOf<T>.init)
    }
}

extension Or: Arbitrary {
    public static var arbitrary: Gen<Or> {
        return Gen<Or>
            .compose {
                Or.init(
                    unwrap: $0.generate()
                )
        }
    }
}

struct TropicalOf<T>: Arbitrary where T: Arbitrary & ComparableToTop & Addable {
    let get: Tropical<T>
    init(_ get: Tropical<T>) {
        self.get = get
    }

    public static var arbitrary: Gen<TropicalOf<T>> {
        return Gen<Tropical<T>>
            .compose {
                Tropical<T>.init(
                    unwrap: $0.generate()
                )
            }
            .map(TropicalOf<T>.init)
    }
}

// MARK: - Arbitrary for enums

extension Ordering: Arbitrary {
    public static var arbitrary: Gen<Ordering> {
        return Gen<Ordering>.one(of: [
            Gen.pure(Ordering.lowerThan),
            Gen.pure(Ordering.equalTo),
            Gen.pure(Ordering.greaterThan)
        ])
    }
}

// MARK: - Arbitrary for function wrappers

struct FunctionBSOf<S,T>: Arbitrary where S: CoArbitrary & Hashable, T: Arbitrary & BoundedSemilattice & Equatable {
	let get: FunctionBS<S,T>
	init(_ value: @escaping (S) -> T) {
		self.get = FunctionBS.init(value)
	}

	public static var arbitrary: Gen<FunctionBSOf<S,T>> {
		return ArrowOf<S,T>.arbitrary.map { $0.getArrow }.map(FunctionBSOf<S,T>.init)
	}
}

struct FunctionCMOf<S,T>: Arbitrary where S: CoArbitrary & Hashable, T: Arbitrary & CommutativeMonoid & Equatable {
	let get: FunctionCM<S,T>
	init(_ value: @escaping (S) -> T) {
		self.get = FunctionCM.init(value)
	}

	public static var arbitrary: Gen<FunctionCMOf<S,T>> {
		return ArrowOf<S,T>.arbitrary.map { $0.getArrow }.map(FunctionCMOf<S,T>.init)
	}
}

struct FunctionMOf<S,T>: Arbitrary where S: CoArbitrary & Hashable, T: Arbitrary & Monoid & Equatable {
	let get: FunctionM<S,T>
	init(_ value: @escaping (S) -> T) {
		self.get = FunctionM.init(value)
	}

	public static var arbitrary: Gen<FunctionMOf<S,T>> {
		return ArrowOf<S,T>.arbitrary.map { $0.getArrow }.map(FunctionMOf<S,T>.init)
	}
}

struct FunctionSOf<S,T>: Arbitrary where S: CoArbitrary & Hashable, T: Arbitrary & Semigroup & Equatable {
	let get: FunctionS<S,T>
	init(_ value: @escaping (S) -> T) {
		self.get = FunctionS.init(value)
	}

	public static var arbitrary: Gen<FunctionSOf<S,T>> {
		return ArrowOf<S,T>.arbitrary.map { $0.getArrow }.map(FunctionSOf<S,T>.init)
	}
}

struct FunctionSROf<S,T>: Arbitrary where S: CoArbitrary & Hashable, T: Arbitrary & Semiring & Equatable,  T.Multiplicative: Equatable,  T.Additive: Equatable {
	let get: FunctionSR<S,T>
	init(_ value: @escaping (S) -> T) {
		self.get = FunctionSR.init(value)
	}

	public static var arbitrary: Gen<FunctionSROf<S,T>> {
		return ArrowOf<S,T>.arbitrary.map { $0.getArrow }.map(FunctionSROf<S,T>.init)
	}
}
