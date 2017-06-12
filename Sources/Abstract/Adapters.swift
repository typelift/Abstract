/*:
# Adapters

Some extensions to the standard library, to make for easier implementations of abstract data types.
*/

//: ------

public protocol Summable: Equatable {
	static func + (left: Self, right: Self) -> Self
	static var zero: Self { get }
}

extension Int: Summable { public static let zero = Int(0) }
extension UInt: Summable { public static let zero = UInt(0) }
extension Float: Summable { public static let zero = Float(0) }
extension Double: Summable { public static let zero = Double(0) }

//: ------

public protocol Multipliable: Equatable {
	static func * (left: Self, right: Self) -> Self
	static var one: Self { get }
}

extension Int: Multipliable { public static let one = Int(1) }
extension UInt: Multipliable { public static let one = UInt(1) }
extension Float: Multipliable { public static let one = Float(1) }
extension Double: Multipliable { public static let one = Double(1) }

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
