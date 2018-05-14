#if SWIFT_PACKAGE
    import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "TestStructure,TestStructure"
public enum Coproduct<A,B> {
    case left(A)
    case right(B)
    
    public func flip() -> Coproduct<B,A> {
        switch self {
        case let .left(a):
            return .right(a)
        case let .right(b):
            return .left(b)
        }
    }
    
    public func fold <T> (onLeft: (A) -> T, onRight: (B) -> T) -> T {
        switch self {
        case let .left(a):
            return onLeft(a)
        case let .right(b):
            return onRight(b)
        }
    }
}

extension Coproduct: Equatable where A: Equatable, B: Equatable {
    public static func == (lhs: Coproduct, rhs: Coproduct) -> Bool {
        switch (lhs, rhs) {
        case let (.left(lhsValue), .left(rhsValue)):
            return lhsValue == rhsValue
        case let (.right(lhsValue), .right(rhsValue)):
            return lhsValue == rhsValue
        default:
            return false
        }
    }
}

extension Coproduct: EquatableInContext where A: EquatableInContext, B: EquatableInContext {
    public typealias Context = (A.Context, B.Context)
    
    public static func == (lhs: Coproduct, rhs: Coproduct) -> (Context) -> Bool {
        return { context in
            switch (lhs, rhs) {
            case let (.left(lhsValue), .left(rhsValue)):
                return (lhsValue == rhsValue)(context.0)
            case let (.right(lhsValue), .right(rhsValue)):
                return (lhsValue == rhsValue)(context.1)
            default:
                return false
            }
        }
    }
}

/// Coproduct has a biased Semigroup definition (in this case, it's right-biased)
extension Coproduct: Magma where A: Magma, B: Magma {
    public static func <> (lhs: Coproduct<A, B>, rhs: Coproduct<A, B>) -> Coproduct<A, B> {
        switch (lhs,rhs) {
        case let (.right(lhsValue), .right(rhsValue)):
            return .right(lhsValue <> rhsValue)
        case let (.right(lhsValue), .left(_)):
            return .right(lhsValue)
        case let (.left(_), .right(rhsValue)):
            return .right(rhsValue)
        case let (.left(lhsValue), .left(rhsValue)):
            return .left(lhsValue <> rhsValue)
        }
    }
}

extension Coproduct: Semigroup where A: Semigroup, B: Semigroup {}
