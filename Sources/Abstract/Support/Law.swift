/*:
# Law
	
The "Law" namespace. 

Laws are basically equations that express a particular "invariant", that is, a rule that must be always fulfilled, or in other words, an equality that must be always true.

Thus, for any law to be enforced for a particular type (the `Element` parameter), it's required that the type conforms to `Equatable`, so that an equation can be written and solved.
*/

public enum Law<Element: Equatable> {}

/*:
Some types will require a context to verify the laws (for example, functions).
*/

public protocol EquatableInContext {
	associatedtype Context
	
	static func == (lhs: Self, rhs: Self) -> (Context) -> Bool
}

public enum LawInContext<Element: EquatableInContext> {}

//: ------

extension Optional: EquatableInContext where Wrapped: EquatableInContext {
	public typealias Context = Wrapped.Context

	public static func == (lhs: Optional, rhs: Optional) -> (Context) -> Bool {
		switch (lhs,rhs) {
		case (.some(let lhs), .some(let rhs)):
			return lhs == rhs
		case (.none,.none):
			return { _ in true }
		default:
			return { _ in false }
		}
	}
}

//: ------

extension Array: EquatableInContext where Element: EquatableInContext {
	public typealias Context = Element.Context

	public static func == (lhs: Array, rhs: Array) -> (Context) -> Bool {
		return { context in
			zip(lhs, rhs).lazy
				.map(==)
				.map { $0(context) }
				.first(where: { $0 == false })
				== nil
		}
	}
}

