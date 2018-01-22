// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import SwiftCheck
@testable import Abstract


// MARK: - Arbitrary for structs and classes

struct AddOf<T>: Arbitrary where T: Arbitrary & Addable & Equatable {
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

extension Array: Arbitrary {
    public static var arbitrary: Gen<Array> {
        return Gen<Array>
            .compose {
                Array.init(
                )
        }
    }
}

struct FirstOf<T>: Arbitrary where T: Arbitrary & Equatable {
    let get: First<T>
    init(_ get: First<T>) {
        self.get = get
    }

    public static var arbitrary: Gen<FirstOf<T>> {
        return Gen<First<T>>
            .compose {
                First<T>.init(
                    unwrap: $0.generate()
                )
            }
            .map(FirstOf<T>.init)
    }
}

struct FirstMOf<T>: Arbitrary where T: Arbitrary & Monoid & Equatable {
    let get: FirstM<T>
    init(_ get: FirstM<T>) {
        self.get = get
    }

    public static var arbitrary: Gen<FirstMOf<T>> {
        return Gen<FirstM<T>>
            .compose {
                FirstM<T>.init(
                    unwrap: $0.generate()
                )
            }
            .map(FirstMOf<T>.init)
    }
}

struct FreeSemigroupOf<T>: Arbitrary where T: Arbitrary {
    let get: FreeSemigroup<T>
    init(_ get: FreeSemigroup<T>) {
        self.get = get
    }

    public static var arbitrary: Gen<FreeSemigroupOf<T>> {
        return Gen<FreeSemigroup<T>>
            .compose {
                FreeSemigroup<T>.init(
                    unwrap: $0.generate(using: ArrayOf<A>.arbitrary.map { $0.getArray })
                )
            }
            .map(FreeSemigroupOf<T>.init)
    }
}

struct LastOf<T>: Arbitrary where T: Arbitrary & Equatable {
    let get: Last<T>
    init(_ get: Last<T>) {
        self.get = get
    }

    public static var arbitrary: Gen<LastOf<T>> {
        return Gen<Last<T>>
            .compose {
                Last<T>.init(
                    unwrap: $0.generate()
                )
            }
            .map(LastOf<T>.init)
    }
}

struct LastMOf<T>: Arbitrary where T: Arbitrary & Monoid & Equatable {
    let get: LastM<T>
    init(_ get: LastM<T>) {
        self.get = get
    }

    public static var arbitrary: Gen<LastMOf<T>> {
        return Gen<LastM<T>>
            .compose {
                LastM<T>.init(
                    unwrap: $0.generate()
                )
            }
            .map(LastMOf<T>.init)
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

extension Optional: Arbitrary {
    public static var arbitrary: Gen<Optional> {
        return Gen<Optional>
            .compose {
                Optional.init(
                )
        }
    }
}

struct OptionalBSOf<T>: Arbitrary where T: Arbitrary & BoundedSemilattice & Equatable {
    let get: OptionalBS<T>
    init(_ get: OptionalBS<T>) {
        self.get = get
    }

    public static var arbitrary: Gen<OptionalBSOf<T>> {
        return Gen<OptionalBS<T>>
            .compose {
                OptionalBS<T>.init(
                    unwrap: $0.generate(using: OptionalOf<T>.arbitrary.map { $0.getOptional })
                )
            }
            .map(OptionalBSOf<T>.init)
    }
}

struct OptionalBSFOf<T>: Arbitrary where T: Arbitrary & BoundedSemilattice & EquatableInContext {
    let get: OptionalBSF<T>
    init(_ get: OptionalBSF<T>) {
        self.get = get
    }

    public static var arbitrary: Gen<OptionalBSFOf<T>> {
        return Gen<OptionalBSF<T>>
            .compose {
                OptionalBSF<T>.init(
                    unwrap: $0.generate(using: OptionalOf<T>.arbitrary.map { $0.getOptional })
                )
            }
            .map(OptionalBSFOf<T>.init)
    }
}

struct OptionalCMOf<T>: Arbitrary where T: Arbitrary & CommutativeMonoid & Equatable {
    let get: OptionalCM<T>
    init(_ get: OptionalCM<T>) {
        self.get = get
    }

    public static var arbitrary: Gen<OptionalCMOf<T>> {
        return Gen<OptionalCM<T>>
            .compose {
                OptionalCM<T>.init(
                    unwrap: $0.generate(using: OptionalOf<T>.arbitrary.map { $0.getOptional })
                )
            }
            .map(OptionalCMOf<T>.init)
    }
}

struct OptionalCMFOf<T>: Arbitrary where T: Arbitrary & CommutativeMonoid & EquatableInContext {
    let get: OptionalCMF<T>
    init(_ get: OptionalCMF<T>) {
        self.get = get
    }

    public static var arbitrary: Gen<OptionalCMFOf<T>> {
        return Gen<OptionalCMF<T>>
            .compose {
                OptionalCMF<T>.init(
                    unwrap: $0.generate(using: OptionalOf<T>.arbitrary.map { $0.getOptional })
                )
            }
            .map(OptionalCMFOf<T>.init)
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

struct FunctionOf<S,T>: Arbitrary where S: CoArbitrary & Hashable, T: Arbitrary & Semigroup & Equatable {
	let get: Function<S,T>
	init(_ value: @escaping (S) -> T) {
		self.get = Function.init(value)
	}

	public static var arbitrary: Gen<FunctionOf<S,T>> {
		return ArrowOf<S,T>.arbitrary.map { $0.getArrow }.map(FunctionOf<S,T>.init)
	}
}

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

struct FunctionSROf<S,T>: Arbitrary where S: CoArbitrary & Hashable, T: Arbitrary & Semiring & Equatable,  T.Multiplicative: Equatable,  T.Additive: Equatable {
	let get: FunctionSR<S,T>
	init(_ value: @escaping (S) -> T) {
		self.get = FunctionSR.init(value)
	}

	public static var arbitrary: Gen<FunctionSROf<S,T>> {
		return ArrowOf<S,T>.arbitrary.map { $0.getArrow }.map(FunctionSROf<S,T>.init)
	}
}
