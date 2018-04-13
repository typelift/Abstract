// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import SwiftCheck
@testable import Abstract


// MARK: - Arbitrary for structs and classes

extension Add: Arbitrary where : Arbitrary {
	public static var arbitrary: Gen<Add> {
		return Gen<Add>
			.compose {
				Add.init(
                    unwrap: $0.generate()
				)
		}
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

extension First: Arbitrary where : Arbitrary {
	public static var arbitrary: Gen<First> {
		return Gen<First>
			.compose {
				First.init(
                    unwrap: $0.generate()
				)
		}
	}
}

extension FreeCommutativeMonoid: Arbitrary where A: Arbitrary {
	public static var arbitrary: Gen<FreeCommutativeMonoid> {
		return Gen<FreeCommutativeMonoid>
			.compose {
				FreeCommutativeMonoid.init(
                    unwrap: $0.generate(using: ArrayOf<A>.arbitrary.map { $0.getArray })
				)
		}
	}
}

extension FreeMonoid: Arbitrary where : Arbitrary {
	public static var arbitrary: Gen<FreeMonoid> {
		return Gen<FreeMonoid>
			.compose {
				FreeMonoid.init(
                    unwrap: $0.generate(using: ArrayOf<A>.arbitrary.map { $0.getArray })
				)
		}
	}
}

extension FreeSemigroup: Arbitrary where : Arbitrary {
	public static var arbitrary: Gen<FreeSemigroup> {
		return Gen<FreeSemigroup>
			.compose {
				FreeSemigroup.init(
                    unwrap: $0.generate(using: ArrayOf<A>.arbitrary.map { $0.getArray })
				)
		}
	}
}

extension Last: Arbitrary where : Arbitrary {
	public static var arbitrary: Gen<Last> {
		return Gen<Last>
			.compose {
				Last.init(
                    unwrap: $0.generate()
				)
		}
	}
}

extension Max: Arbitrary where : Arbitrary {
	public static var arbitrary: Gen<Max> {
		return Gen<Max>
			.compose {
				Max.init(
                    unwrap: $0.generate()
				)
		}
	}
}

extension Min: Arbitrary where : Arbitrary {
	public static var arbitrary: Gen<Min> {
		return Gen<Min>
			.compose {
				Min.init(
                    unwrap: $0.generate()
				)
		}
	}
}

extension Multiply: Arbitrary where : Arbitrary {
	public static var arbitrary: Gen<Multiply> {
		return Gen<Multiply>
			.compose {
				Multiply.init(
                    unwrap: $0.generate()
				)
		}
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

extension Tropical: Arbitrary where : Arbitrary {
	public static var arbitrary: Gen<Tropical> {
		return Gen<Tropical>
			.compose {
				Tropical.init(
                    unwrap: $0.generate()
				)
		}
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

struct FunctionOf<S,T>: Arbitrary where S: CoArbitrary & Hashable, T: Arbitrary & Semiring & Equatable,  T.Multiplicative: Equatable,  T.Additive: Equatable {
	let get: Function<S,T>
	init(_ value: @escaping (S) -> T) {
		self.get = Function.init(value)
	}

	public static var arbitrary: Gen<FunctionOf<S,T>> {
		return ArrowOf<S,T>.arbitrary.map { $0.getArrow }.map(FunctionOf<S,T>.init)
	}
}
