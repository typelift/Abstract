#if SWIFT_PACKAGE
    import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "String"
public struct Monoidal<A>: Wrapper & Equatable where A: Hashable & Monoid {
    public typealias WrappedType = Set<A>
    
    public let unwrap: Set<A>
    public init(_ unwrap: Set<A>) {
        self.unwrap = unwrap
    }
}

extension Monoidal: Semiring {
    public static func <>+ (lhs: Monoidal, rhs: Monoidal) -> Monoidal {
        return Monoidal(lhs.unwrap.union(rhs.unwrap))
    }
    
    public static var zero: Monoidal {
        return Monoidal([])
    }

    public static func <>* (lhs: Monoidal, rhs: Monoidal) -> Monoidal {
        var cartesianProduct: Array<A> = []
        cartesianProduct.reserveCapacity(lhs.unwrap.count * rhs.unwrap.count)
        
        for firstElement in lhs.unwrap {
            for secondElement in rhs.unwrap {
                cartesianProduct.append(firstElement <> secondElement)
            }
        }
        
        let set = Set(cartesianProduct)

        return Monoidal(set)
    }

    public static var one: Monoidal {
        return Monoidal([.empty])
    }
}
