/*:
# Adapters

Some extensions to the standard library, to make for easier implementations of abstract data types.
*/

//: ------

public protocol Addable {
	static func add (_ lhs: Self, _ rhs: Self) -> Self
	static var zero: Self { get }
}

/*:
`add` has a special definition for `Int` and `UInt`, caused by the fact that the `.max` element MUST have the semantics of *infinite*, and has to act accordingly, that is:

Int.max + a = a + Int.max = Int.max
UInt.max + a = a + UInt.max = UInt.max

This is particularly important for the `Tropical<A>` semiring: without this axiom the `zeroAnnihiliatesTheMultiplicative` law cannot be enforced.

Note that this special definition of `add` has to be given for any type that is both `Addable` and `ComparableToTop`, but there's no way to generically define that in Swift.
*/

extension Int: Addable {
	public static func add(_ lhs: Int, _ rhs: Int) -> Int {
		switch (lhs,rhs) {
		case (Int.max,_):
			return Int.max
		case (_,Int.max):
			return Int.max
		default:
			return lhs + rhs
		}
	}

	public static let zero = Int(0)
}

extension UInt: Addable {
	public static func add(_ lhs: UInt, _ rhs: UInt) -> UInt {
		switch (lhs,rhs) {
		case (UInt.max,_):
			return UInt.max
		case (_,UInt.max):
			return UInt.max
		default:
			return lhs + rhs
		}
	}

	public static let zero = UInt(0)
}

extension Float: Addable {
	public static func add(_ lhs: Float, _ rhs: Float) -> Float { return lhs + rhs }
	public static let zero = Float(0)
}

extension Double: Addable {
	public static func add(_ lhs: Double, _ rhs: Double) -> Double { return lhs + rhs }
	public static let zero = Double(0)
}

//: ------

public protocol Multipliable {
	static func multiply (_ lhs: Self, _ rhs: Self) -> Self
	static var one: Self { get }
}

extension Int: Multipliable {
	public static func multiply(_ lhs: Int, _ rhs: Int) -> Int { return lhs * rhs }
	public static let one = Int(1)
}

extension UInt: Multipliable {
	public static func multiply(_ lhs: UInt, _ rhs: UInt) -> UInt { return lhs * rhs }
	public static let one = UInt(1)
}

extension Float: Multipliable {
	public static func multiply(_ lhs: Float, _ rhs: Float) -> Float { return lhs * rhs }
	public static let one = Float(1)
}

extension Double: Multipliable {
	public static func multiply(_ lhs: Double, _ rhs: Double) -> Double { return lhs * rhs }
	public static let one = Double(1)
}

//: ------

public protocol ComparableToTop: Comparable {
	static var max: Self { get }
}

extension Int: ComparableToTop {}
extension UInt: ComparableToTop {}

//: ------

public protocol ComparableToBottom: Comparable {
	static var min: Self { get }
}

extension Int: ComparableToBottom {}
extension UInt: ComparableToBottom {}

//: ------
