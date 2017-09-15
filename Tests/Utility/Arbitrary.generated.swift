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

struct ArrayEqOf<T>: Arbitrary where T: Arbitrary & Equatable {
    let get: ArrayEq<T>
    init(_ get: ArrayEq<T>) {
        self.get = get
    }

    public static var arbitrary: Gen<ArrayEqOf<T>> {
        return Gen<ArrayEq<T>>
            .compose {
                ArrayEq<T>.init(
                    unwrap: $0.generate(using: ArrayOf<T>.arbitrary.map { $0.getArray })
                )
            }
            .map(ArrayEqOf<T>.init)
    }
}

struct ArrayEqFOf<T>: Arbitrary where T: Arbitrary & EquatableInContext {
    let get: ArrayEqF<T>
    init(_ get: ArrayEqF<T>) {
        self.get = get
    }

    public static var arbitrary: Gen<ArrayEqFOf<T>> {
        return Gen<ArrayEqF<T>>
            .compose {
                ArrayEqF<T>.init(
                    unwrap: $0.generate(using: ArrayOf<T>.arbitrary.map { $0.getArray })
                )
            }
            .map(ArrayEqFOf<T>.init)
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

struct FirstFOf<T>: Arbitrary where T: Arbitrary & EquatableInContext {
    let get: FirstF<T>
    init(_ get: FirstF<T>) {
        self.get = get
    }

    public static var arbitrary: Gen<FirstFOf<T>> {
        return Gen<FirstF<T>>
            .compose {
                FirstF<T>.init(
                    unwrap: $0.generate()
                )
            }
            .map(FirstFOf<T>.init)
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

struct LastFOf<T>: Arbitrary where T: Arbitrary & EquatableInContext {
    let get: LastF<T>
    init(_ get: LastF<T>) {
        self.get = get
    }

    public static var arbitrary: Gen<LastFOf<T>> {
        return Gen<LastF<T>>
            .compose {
                LastF<T>.init(
                    unwrap: $0.generate()
                )
            }
            .map(LastFOf<T>.init)
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

struct OptionalEqOf<T>: Arbitrary where T: Arbitrary & Equatable {
    let get: OptionalEq<T>
    init(_ get: OptionalEq<T>) {
        self.get = get
    }

    public static var arbitrary: Gen<OptionalEqOf<T>> {
        return Gen<OptionalEq<T>>
            .compose {
                OptionalEq<T>.init(
                    unwrap: $0.generate(using: OptionalOf<T>.arbitrary.map { $0.getOptional })
                )
            }
            .map(OptionalEqOf<T>.init)
    }
}

struct OptionalEqFOf<T>: Arbitrary where T: Arbitrary & EquatableInContext {
    let get: OptionalEqF<T>
    init(_ get: OptionalEqF<T>) {
        self.get = get
    }

    public static var arbitrary: Gen<OptionalEqFOf<T>> {
        return Gen<OptionalEqF<T>>
            .compose {
                OptionalEqF<T>.init(
                    unwrap: $0.generate(using: OptionalOf<T>.arbitrary.map { $0.getOptional })
                )
            }
            .map(OptionalEqFOf<T>.init)
    }
}

struct OptionalMOf<T>: Arbitrary where T: Arbitrary & Semigroup & Equatable {
    let get: OptionalM<T>
    init(_ get: OptionalM<T>) {
        self.get = get
    }

    public static var arbitrary: Gen<OptionalMOf<T>> {
        return Gen<OptionalM<T>>
            .compose {
                OptionalM<T>.init(
                    unwrap: $0.generate(using: OptionalOf<T>.arbitrary.map { $0.getOptional })
                )
            }
            .map(OptionalMOf<T>.init)
    }
}

struct OptionalMFOf<T>: Arbitrary where T: Arbitrary & Semigroup & EquatableInContext {
    let get: OptionalMF<T>
    init(_ get: OptionalMF<T>) {
        self.get = get
    }

    public static var arbitrary: Gen<OptionalMFOf<T>> {
        return Gen<OptionalMF<T>>
            .compose {
                OptionalMF<T>.init(
                    unwrap: $0.generate(using: OptionalOf<T>.arbitrary.map { $0.getOptional })
                )
            }
            .map(OptionalMFOf<T>.init)
    }
}

struct OptionalSOf<T>: Arbitrary where T: Arbitrary & Semigroup & Equatable {
    let get: OptionalS<T>
    init(_ get: OptionalS<T>) {
        self.get = get
    }

    public static var arbitrary: Gen<OptionalSOf<T>> {
        return Gen<OptionalS<T>>
            .compose {
                OptionalS<T>.init(
                    unwrap: $0.generate(using: OptionalOf<T>.arbitrary.map { $0.getOptional })
                )
            }
            .map(OptionalSOf<T>.init)
    }
}

struct OptionalSFOf<T>: Arbitrary where T: Arbitrary & Semigroup & EquatableInContext {
    let get: OptionalSF<T>
    init(_ get: OptionalSF<T>) {
        self.get = get
    }

    public static var arbitrary: Gen<OptionalSFOf<T>> {
        return Gen<OptionalSF<T>>
            .compose {
                OptionalSF<T>.init(
                    unwrap: $0.generate()
                )
            }
            .map(OptionalSFOf<T>.init)
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
