/// a Magma is a type with a composition operation; no particular rules are given

public protocol Magma {
	func composed(_ other: Self) -> Self
}
