#if SWIFT_PACKAGE
    import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "TestStructure,TestStructure"
public struct Product<A,B> {
    public let first: A
    public let second: B
    
    public init(_ first: A, _ second: B) {
        self.first = first
        self.second = second
    }
    
    public func flip() -> Product<B,A> {
        return Product<B,A>(second,first)
    }
    
    public func fold <T> (_ onBoth: (A,B) -> T) -> T {
        return onBoth(first,second)
    }
}

extension Product: Equatable where A: Equatable, B: Equatable {
    public static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.first == rhs.first
            && lhs.second == rhs.second
    }
}

extension Product: EquatableInContext where A: EquatableInContext, B: EquatableInContext {
    public typealias Context = (A.Context, B.Context)
    
    public static func == (lhs: Product, rhs: Product) -> (Context) -> Bool{
        return { context in
            return (lhs.first == rhs.first)(context.0)
                && (lhs.second == rhs.second)(context.1)
        }
    }
}

extension Product: Magma where A: Magma, B: Magma {
    public static func <> (lhs: Product, rhs: Product) -> Product {
        return Product(
            lhs.first <> rhs.first,
            lhs.second <> rhs.second
        )
    }
}

extension Product: Semigroup where A: Semigroup, B: Semigroup {}

extension Product: Monoid where A: Monoid, B: Monoid {
    public static var empty: Product {
        return Product(A.empty, B.empty)
    }
}

extension Product: CommutativeMonoid where A: CommutativeMonoid, B: CommutativeMonoid {}

extension Product: BoundedSemilattice where A: BoundedSemilattice, B: BoundedSemilattice {}

extension Product: Semiring where A: Semiring, B: Semiring {
    public static func <>+ (lhs: Product, rhs: Product) -> Product {
        return Product(
            lhs.first <>+ rhs.first,
            lhs.second <>+ rhs.second
        )
    }
    
    public static var zero: Product {
        return Product(A.zero, B.zero)
    }

    public static func <>* (lhs: Product, rhs: Product) -> Product {
        return Product(
            lhs.first <>* rhs.first,
            lhs.second <>* rhs.second
        )
    }

    public static var one: Product {
        return Product(A.one, B.one)
    }
}
