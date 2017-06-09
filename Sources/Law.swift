/* 
# Law
	
The "Law" namespace. 

Laws are basically equations that express a particular "invariant", that is, a rule that must be always fulfilled, or in other words, an equality that must be always true.

Thus, for any law to be enforced for a particular type (the `Element` parameter), it's required that the type conforms to `Equatable`, so that an equation can be written and solved.
*/

public enum Law<Element: Equatable> {}
