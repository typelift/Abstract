/*
# Magma

A Magma is a type with a composition operation, or in other words, a "binay" operation, that is, an operation that takes two values of a particular type, and returns a value of the same type.

It's a lot simpler and more readable to just define the `<>` (diamond) operator.

The only law that's required is that the operation must be **closed**, that is, there cannot be preconditions that make the operation fail: the operation must be valid for **any** two values of the particular type.
*/

infix operator <> : AdditionPrecedence

public protocol Magma {
	static func <> (left: Self, right: Self) -> Self
}
