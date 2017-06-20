/*:
# Adapters

Some extensions to the standard library, to make for easier implementations of abstract data types.
*/

//: ------

public protocol Addable: Equatable {
	static func add (_ left: Self, _ right: Self) -> Self
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
	public static func add(_ left: Int, _ right: Int) -> Int {
		switch (left,right) {
		case (Int.max,_):
			return Int.max
		case (_,Int.max):
			return Int.max
		default:
			return left + right
		}
	}

	public static let zero = Int(0)
}

extension UInt: Addable {
	public static func add(_ left: UInt, _ right: UInt) -> UInt {
		switch (left,right) {
		case (UInt.max,_):
			return UInt.max
		case (_,UInt.max):
			return UInt.max
		default:
			return left + right
		}
	}

	public static let zero = UInt(0)
}

extension Float: Addable {
	public static func add(_ left: Float, _ right: Float) -> Float { return left + right }
	public static let zero = Float(0)
}

extension Double: Addable {
	public static func add(_ left: Double, _ right: Double) -> Double { return left + right }
	public static let zero = Double(0)
}

//: ------

public protocol Multipliable: Equatable {
	static func multiply (_ left: Self, _ right: Self) -> Self
	static var one: Self { get }
}

extension Int: Multipliable {
	public static func multiply(_ left: Int, _ right: Int) -> Int { return left * right }
	public static let one = Int(1)
}

extension UInt: Multipliable {
	public static func multiply(_ left: UInt, _ right: UInt) -> UInt { return left * right }
	public static let one = UInt(1)
}

extension Float: Multipliable {
	public static func multiply(_ left: Float, _ right: Float) -> Float { return left * right }
	public static let one = Float(1)
}

extension Double: Multipliable {
	public static func multiply(_ left: Double, _ right: Double) -> Double { return left * right }
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
