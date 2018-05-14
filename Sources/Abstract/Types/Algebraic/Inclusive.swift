#if SWIFT_PACKAGE
    import Operadics
#endif

/// Inclusive is the "inclusive-or" type: represents either something, or somehting else, or both.

// sourcery: fixedTypesForPropertyBasedTests = "TestStructure,TestStructure"
public enum Inclusive<A,B> {
    case left(A)
    case center(A,B)
    case right(B)
    
    public func flip() -> Inclusive<B,A> {
        switch self {
        case let .left(a):
            return .right(a)
        case let .center(a, b):
            return .center(b,a)
        case let .right(b):
            return .left(b)
        }
    }
    
    public func fold <T> (onLeft: @escaping (A) -> T, onCenter: @escaping (A,B) -> T, onRight: @escaping (B) -> T) -> T {
        switch self {
        case let .left(a):
            return onLeft(a)
        case let .center(a, b):
            return onCenter(a,b)
        case let .right(b):
            return onRight(b)
        }
    }
}

extension Inclusive: Equatable where A: Equatable, B: Equatable {
    public static func == (lhs: Inclusive, rhs: Inclusive) -> Bool {
        switch (lhs, rhs) {
        case let (.left(lhsValue),.left(rhsValue)):
            return lhsValue == rhsValue
        case let (.center(lhsValue),.center(rhsValue)):
            return lhsValue == rhsValue
        case let (.right(lhsValue),.right(rhsValue)):
            return lhsValue == rhsValue
        default:
            return false
        }
    }
}

extension Inclusive: EquatableInContext where A: EquatableInContext, B: EquatableInContext {
    public typealias Context = (A.Context, B.Context)
    
    public static func == (lhs: Inclusive, rhs: Inclusive) -> (Context) -> Bool {
        return { context in
            switch (lhs, rhs) {
            case let (.left(lhsValue),.left(rhsValue)):
                return (lhsValue == rhsValue)(context.0)
            case let (.center(lhsValue),.center(rhsValue)):
                return (lhsValue.0 == rhsValue.0)(context.0)
                    && (lhsValue.1 == rhsValue.1)(context.1)
            case let (.right(lhsValue),.right(rhsValue)):
                return (lhsValue == rhsValue)(context.1)
            default:
                return false
            }
        }
    }
}

/// Inclusive has a unbiased Semigroup definition
extension Inclusive: Magma where A: Magma, B: Magma {
    public static func <> (left: Inclusive<A, B>, right: Inclusive<A, B>) -> Inclusive<A, B> {
        switch (left, right) {
        case let (.left(lhsValue),.left(rhsValue)):
            return .left(lhsValue <> rhsValue)
        case let (.left(lhsValue),.center(rhsValue)):
            return .center(lhsValue <> rhsValue.0, rhsValue.1)
        case let (.left(lhsValue),.right(rhsValue)):
            return .center(lhsValue, rhsValue)
        case let (.center(lhsValue),.left(rhsValue)):
            return .center(lhsValue.0 <> rhsValue, lhsValue.1)
        case let (.center(lhsValue),.center(rhsValue)):
            return .center(lhsValue.0 <> rhsValue.0, lhsValue.1 <> rhsValue.1)
        case let (.center(lhsValue),.right(rhsValue)):
            return .center(lhsValue.0, lhsValue.1 <> rhsValue)
        case let (.right(lhsValue),.left(rhsValue)):
            return .center(rhsValue, lhsValue)
        case let (.right(lhsValue),.center(rhsValue)):
            return .center(rhsValue.0, lhsValue <> rhsValue.1)
        case let (.right(lhsValue),.right(rhsValue)):
            return .right(lhsValue <> rhsValue)
        }
    }
}

extension Inclusive: Semigroup where A: Semigroup, B: Semigroup {}
