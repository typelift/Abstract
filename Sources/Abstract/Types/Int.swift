#if SWIFT_PACKAGE
    import Operadics
#endif

/// Int is one of the simplest semirings, where addition and multiplication are mapped to the regula arithmentic operations.
extension Int: Semiring {
    public static func <>+ (lhs: Int, rhs: Int) -> Int {
        return lhs + rhs
    }
    
    public static func <>* (lhs: Int, rhs: Int) -> Int {
        return lhs * rhs
    }
}
