#if SWIFT_PACKAGE
    import Operadics
#endif

// sourcery: fixedTypesForPropertyBasedTests = "TestStructure,TestStructure"
public enum Coproduct<A,B> {
    case left(A)
    case right(B)
    
    public func fold <T> (onLeft: (A) -> T, onRight: (B) -> T) -> T {
        switch self {
        case .left(let a):
            return onLeft(a)
        case .right(let b):
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

/// A Coproduct of semirings forms a Semiring where the "+" operation is biased towards the right case,
/// while the "*" operation is biased towards the left case.
extension Coproduct: Semiring where A: Semiring, B: Semiring {
    public static func <>+ (left: Coproduct<A, B>, right: Coproduct<A, B>) -> Coproduct<A, B> {
        switch (left, right) {
        case let (.left(lhsValue), .left(rhsValue)):
            return .left(lhsValue <>+ rhsValue)
        case let (.left(_), .right(rhsValue)):
            return .right(rhsValue)
        case let (.right(lhsValue), .left(_)):
            return .right(lhsValue)
        case let (.right(lhsValue), .right(rhsValue)):
            return .right(lhsValue <>* rhsValue)
        }
    }
    
    public static var zero: Coproduct<A, B> {
        return .left(.zero)
    }
    
    public static func <>* (left: Coproduct<A, B>, right: Coproduct<A, B>) -> Coproduct<A, B> {
        switch (left, right) {
        case let (.left(lhsValue), .left(rhsValue)):
            return .left(lhsValue <>* rhsValue)
        case let (.left(lhsValue), .right(_)):
            return .left(lhsValue)
        case let (.right(_), .left(rhsValue)):
            return .left(rhsValue)
        case let (.right(lhsValue), .right(rhsValue)):
            return .right(lhsValue <>+ rhsValue)
        }
    }
    
    public static var one: Coproduct<A, B> {
        return .right(.one)
    }
}
