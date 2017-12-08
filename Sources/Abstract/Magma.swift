/*:
# Magma

A Magma is a type with a composition operation, or in other words, a "binay" operation, that is, an operation that takes two values of a particular type, and returns a value of the same type.

It's a lot simpler and more readable to just define the `<>` (diamond) operator.

The only law that's required is that the operation must be **closed**, that is, there cannot be preconditions that make the operation fail: the operation must be valid for **any** two values of the particular type.

Technically, to prove this, we could test the operation with a large number of random values but that's basically pointless, because any other test will do the exact same thing, by also enforcing other rules.

So let's keep it on word (for now).
*/

#if SWIFT_PACKAGE
    import Operadics
#endif

public protocol Magma {
	static func <> (left: Self, right: Self) -> Self
}
