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
