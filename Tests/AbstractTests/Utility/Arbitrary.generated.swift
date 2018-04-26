// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import SwiftCheck
@testable import Abstract


// MARK: - Arbitrary for structs and classes

extension Add: Arbitrary where A: Arbitrary {
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

extension First: Arbitrary where A: Arbitrary {
	public static var arbitrary: Gen<First> {
		return Gen<First>
			.compose {
				First.init(
                    unwrap: $0.generate()
				)
		}
	}
}

extension Last: Arbitrary where A: Arbitrary {
	public static var arbitrary: Gen<Last> {
		return Gen<Last>
			.compose {
				Last.init(
                    unwrap: $0.generate()
				)
		}
	}
}

extension Max: Arbitrary where A: Arbitrary {
	public static var arbitrary: Gen<Max> {
		return Gen<Max>
			.compose {
				Max.init(
                    unwrap: $0.generate()
				)
		}
	}
}

extension Min: Arbitrary where A: Arbitrary {
	public static var arbitrary: Gen<Min> {
		return Gen<Min>
			.compose {
				Min.init(
                    unwrap: $0.generate()
				)
		}
	}
}

extension Multiply: Arbitrary where A: Arbitrary {
	public static var arbitrary: Gen<Multiply> {
		return Gen<Multiply>
			.compose {
				Multiply.init(
                    unwrap: $0.generate()
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

extension Tropical: Arbitrary where A: Arbitrary {
	public static var arbitrary: Gen<Tropical> {
		return Gen<Tropical>
			.compose {
				Tropical.init(
                    unwrap: $0.generate()
				)
		}
	}
}

extension Update: Arbitrary where A: Arbitrary {
	public static var arbitrary: Gen<Update> {
		return Gen<Update>
			.compose {
				Update.init(
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
