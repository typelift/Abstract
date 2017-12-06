# Abstract

A take on abstract algebraic structures, in Swift.

------

`Abstract` is a Swift library that defines protocols for common [abstract algebraic structures](https://en.wikipedia.org/wiki/Abstract_algebra), along with some concrete implementations for Swift datatypes.

The library also provides tools to test the concrete types for the axioms required by each algebraic structure: tests can then be performed by property-based testing libraries like [SwiftCheck](https://github.com/typelift/SwiftCheck).

------

## System Requirements

`Abstract` supports macOS 10.10+ and iOS 8.3+.

------

## Setup

To clone `Abstract` please run `git clone REPOSITORY_URL --recursive` to properly clone submodules.

### SwiftPM
Please add this line to your `Package.swift` file's dependencies section:

```
.package(url: "https://github.com/typelift/Abstract.git",
         from: Version(0,0,0))
```

To use the structures in this library, add `"Abstract"` to your target's dependencies. To additionally test algebraic laws with the framework, add `"Abstract"` as a dependency to the relevant `testTarget`s.

### Carthage
`Abstract` is compatible with [Carthage](https://github.com/Carthage/Carthage): please refer to Carthage documentation for how to add `Abstract` as a dependency of your project.

------

## How to use this

Let's see some examples to better understand what `Abstract` is about. To get an overview of the theory behind all this you can read the [rationale](RATIONALE.md).

### Cookies appreciation

We're building an app that lets a user request any number of cookies, and then provide a feedback if they're satisfied with the cookies or not. We'd like to track the user interaction with the app in a session object like this:

```swift
struct UserSession {
    var lastInteractionDate: Date
    var numberOfCookiesRequested: Int
    var maxCookiesPerRequest: Int
    var averageCookiesPerSession: Double
    var alwaysSatisfied: Bool
}
```

At each interaction, we should update the session object. 

There are 2 possible interactions:

- order the cookies;
- leave a feedback;

We could add 2 methods to `UserSession` to represent each of those actions:

```swift
extension UserSession {
    func orderCookies(_ count: Int) -> UserSession {
        var m = self
        m.lastInteractionDate = Date()
        m.totalCookiesRequested += count
        m.maxCookiesPerRequest = max(m.maxCookiesPerRequest, count)
//        m.averageCookiesPerRequest = ?
        return m
    }
    
    func leaveFeedback(_ positive: Bool) -> UserSession {
        var m = self
        m.lastInteractionDate = Date()
        m.alwaysSatisfied = m.alwaysSatisfied && positive
        return m
    }
}
```

We notice 2 things:

- each property updates following a specific logic that's not explicitly declared, but must be deduced from the context;
- there's no way we can update the `averageCookiesPerRequest` property without keeping track of the total number of requests (something that we don't care about from a business perspective);

We could try and define additional types that explicitly declare how we're supposed to update the various properties.

```swift
var lastInteractionDate: Max<Date>
var totalCookiesRequested: Add<Int>
var maxCookiesPerRequest: Max<Int>
var alwaysSatisfied: And
```

Each property is of a type that specifies how we're supposed to *compose* two instances: `Max<Date>` will always keep the highest of two dates, and it's going to be the same for `Max<Int>` but for numbers; `Add<Int>` will compose the numbers by adding them, and `And` will apply the `&&` operation to two `Bool`. We can then get the *wrapped* value inside the type with an `unwrap` function.

Following this strategy we can actually define an `Average` type that declares a composition function that works as intended:

```swift
struct Average {
    private var value: Double
    private var weight: Int
    
    var unwrap: Double {
        return value
    }
    
    init(_ value: Double, weight: Int = 1) {
        self.value = value
        self.weight = weight
    }
    
    static func <> (left: Average, right: Average) -> Average {
        let sum = left.value*Double(left.weight) + right.value*Double(right.weight)
        let count = left.weight + right.weight
        return Average.init(sum/Double(count), weight: count)
    }
}
```

Notice that we're using a `<>` operator instead of a `compose` method.

Now we can redefine our `UserSession` like this:

```swift
struct UserSession {
    var lastInteractionDate: Max<Date>
    var totalCookiesRequested: Add<Int>
    var maxCookiesPerRequest: Max<Int>
    var averageCookiesPerRequest: Average
    var alwaysSatisfied: And
}

extension UserSession {
    func orderCookies(_ count: Int) -> UserSession {
        var m = self
        m.lastInteractionDate = m.lastInteractionDate <> Max(Date())
        m.totalCookiesRequested = m.totalCookiesRequested <> Add(count)
        m.maxCookiesPerRequest = m.maxCookiesPerRequest <> Max(count)
        m.averageCookiesPerRequest = m.averageCookiesPerRequest <> Average(Double(count))
        return m
    }
    
    func leaveFeedback(_ positive: Bool) -> UserSession {
        var m = self
        m.lastInteractionDate = m.lastInteractionDate <> Max(Date())
        m.alwaysSatisfied = m.alwaysSatisfied <> And(positive)
        return m
    }
}
```

This looks cool but boring: thanks to the fact that each of our types composes with `<>`, we're repeating what's basically the same operation over and over again. It would probably be better to extend the composition operation to `UserSession` itself, where we compose 2 sessions by composing each pair of properties.

```swift
extension UserSession {
    static func <> (left: UserSession, right: UserSession) -> UserSession {
        return UserSession.init(
            lastInteractionDate: left.lastInteractionDate <> right.lastInteractionDate,
            totalCookiesRequested: left.totalCookiesRequested <> right.totalCookiesRequested,
            maxCookiesPerRequest: left.maxCookiesPerRequest <> right.maxCookiesPerRequest,
            averageCookiesPerRequest: left.averageCookiesPerRequest <> right.averageCookiesPerRequest,
            alwaysSatisfied: left.alwaysSatisfied <> right.alwaysSatisfied)
    }
}
```

Notice that we're simply merging the properties in pairs: this could actually be defined in a completely generic way, either with a generic `Tuple` struct where the properties can be *combined*, or with a code-generation tool like [Sourcery](https://github.com/krzysztofzablocki/Sourcery).

Now our `orderCookies` and `leaveFeedback` methods can actually be redefined as `static` methods that generate the *new* session to be combined with the previous one. To do that we need to be able to generate *empty* values for the properties, that are going to behave to the composition like *zero* behaves to *addition*, that is, it leaves the previous value unchanged.

```swift
extension UserSession {
    static func orderCookies(_ count: Int) -> UserSession {
        return UserSession.init(
            lastInteractionDate: Max(Date()),
            totalCookiesRequested: Add(count),
            maxCookiesPerRequest: Max(count),
            averageCookiesPerRequest: Average(Double(count)),
            alwaysSatisfied: .empty)
    }
    
    static func leaveFeedback(_ positive: Bool) -> UserSession {
        return UserSession.init(
            lastInteractionDate: Max(Date()),
            totalCookiesRequested: .empty,
            maxCookiesPerRequest: .empty,
            averageCookiesPerRequest: .empty,
            alwaysSatisfied: And(positive))
    }
}
```

Now a bunch of interactions can be easily combined like this:

```swift
let finalSession: UserSession = .orderCookies(3)
    <> .orderCookies(5)
    <> .leaveFeedback(true)
    <> .orderCookies(2)
    <> .orderCookies(1)
    <> .orderCookies(4)
    <> .leaveFeedback(true)
    <> .orderCookies(10)
    <> .leaveFeedback(false)
    
let totalCookiesRequested = finalSession.totalCookiesRequested.unwrap // 25
let maxCookiesPerRequest = finalSession.maxCookiesPerRequest.unwrap // 10
let averageCookiesPerRequest = finalSession.averageCookiesPerRequest.unwrap // 4.167
let alwaysSatisfied = finalSession.alwaysSatisfied.unwrap // false
```

If we provide an `.empty` value also for `UserSession` we can actually collect all the interactions in an `Array`, and then `reduce` the collection. This is definitely more convenient and readable, and allows us to separate the *collection* of the data from their *processing*. `UserSession.empty` will naturally be an instance where every property is `.empty`:

```swift
let sessions: [UserSession] = [
    .orderCookies(3),
    .orderCookies(5),
    .leaveFeedback(true),
    .orderCookies(2),
    .orderCookies(1),
    .orderCookies(4),
    .leaveFeedback(true),
    .orderCookies(10),
    .leaveFeedback(false)
]

let finalSession = sessions.reduce(.empty, <>)
```

Notice that we could call `.reduce(.empty, <>)` on **any** collection were the elements have these two properties:

- can be composed with `<>`;
- have an empty element;

Thus, if we were able to represent these two properties in an abstract way, we could simply define a `.concatenated` method for these kinds of collections:

```swift
let finalSession = sessions.concatenated
```

A type (actually a set, but in programming we really just care about types) *equipped* with a composition operation that is *closed* (i.e. non-crashing) and *associative*, and an `.empty` value that is neutral to the composition, is usually called a `Monoid`: all the types defined in this example are monoids, and the Swift type system is strong enough to generically define  the interface of a monoid with a `protocol`. Most of the types and methods used in this example are already defined in `Abstract`, and to read more about monoids you can refer to the [Monoid.swift](Sources/Abstract/Monoid.swift) source file.

### FizzBuzzNess

[FizzBuzz](http://wiki.c2.com/?FizzBuzzTest) is a classic job interview question used to check the way a candidate approaches the resolution of a problem in code.

The requirement is to write a program that, given a list of integers, prints *Fizz* for every number divisible by 3, "Buzz" for every number divisible by 5, "FizzBuzz" for every number divisible by both (thus, divisible by 15), and the number itself when it's not divisible by any. It's an easy problem to solve in Swift with a `for-in` cycle and a couple of `if-else` statements, but then the interview could proceed by asking the candidate how to make the solution more generic, by removing duplicate logic in the checks for divisibility by 3 and/or 5, and scalable, so that it's easy for example to introduce a "Bazz" word when the number is divisible by 4, that should be combined appropriately with the other 2 words (thus, when the number is divisible by 12, 20 or 60).

This kind of problem can be elegantly solved with some abstract algebra. The fundamental intuition behind a possible abstract algebra approach is that we're dealing with *putting things together* in various ways.

Let's call "special divisors" the numbers associated to each word (initially, 3 for "Fizz" and 5 for "Buzz"). Every integer could have any number of special divisors, including none, so we're dealing with two kinds of composition:

- words like "Fizz" and "Buzz" should concatenate when a number has more than one special divisor;
- the way special words and the number itself concatenate is that the number is ignored when the special word exists, so the latter has priority;

The first composition style is simple concatenation; the second one is a little harder to see as some kind of composition, but it actually is the composition where we get only the first value if it exists (even if both exist), otherwise we get the second, and if none exist we get an "empty" value.

The type representing the string concatenation is simply `String`, which naturally forms a monoid over concatenation, where the `.empty` value is just the empty string. For the second type of composition we need a special type, that in `Abstract` is called `FirstM`: in composition, it will give priority to the first value.

About the simple string concatenation, we'd like to define a function that *associates* a *word* to a special divisor: the function will take an `Int` and return a `String`, which is going to be "Fizz" or "Buzz". But instead of concatenating words we would actually like to concatenate *functions* that return words: if we're able to compose the return value, we can actually define a *composable function*:

```swift
func associate(divisor: Int, to text: String) -> FunctionM<Int,String> {
    return FunctionM.init { value in
        value % divisor == 0 ? text : .empty
    }
}
```

The `FunctionM` type is a *function type* (we get the function back with the `.call` method) that's **also** a monoid, so we can compose and concatenate instances of this function like we'd do for `String` values.

We can easily define our `fizz` and `buzz` associations:

```swift
let fizz = associate(divisor: 3, to: "Fizz")
let buzz = associate(divisor: 5, to: "Buzz")
```

Now we can easily generate a function that will transform a number in a word, properly concatenated (like "FizzBuzz" for the number 15), or an empty string if the number has no special divisor.

```swift
let transform = [fizz, buzz].concatenated.call
```

Finally, we need a second kind of composition: the one in which the first value is selected if it's not `.empty`. The `FirstM` type has exactly this semantics. We can define a `getWord` function that will use `FirstM` to select a value in a composition:

```swift
func getWord<T>(for value: T, with association: @escaping (T) -> String) -> FirstM<String> {
    return FirstM(association(value)) <> FirstM("\(value)")
}
```

We can verify the result by putting things together:

```swift
let result = (1...100)
    .map { value in
        getWord(for: value, with: transform).unwrap <> "\n"
    }
    .concatenated

print(result)
```

Now that we've separated the two kinds of composition that are taking place here, we can easily add more words and associations. For example:

```swift
let bazz = associate(divisor: 4, to: "Bazz")
let transform = [fizz, buzz, bazz].concatenated.call
``` 

This code will add the word "Bazz" to the mix, for all numbers divisible by 4. Notice that in our example, for the number 60 the word "FizzBuzzBazz" will be printed: the order matters here, and we get "Bazz" at the end because we composed our transformation like `[fizz, buzz, bazz]`.

### The order matters (not)

Let's assume we have a `Process<T>` type that encapsulates a `run` function, executable without any input, that returns a value of type `T`.

```swift
struct Process<T> {
    let run: () -> T
}
```

Let's also assume we have a bunch of processes that we want to run, and then combine all the values into a single one. Running all the processes in sequence and then collecting all the values could be tedious and inefficient, but running them in parallel, maybe in a distributed way, could be dangerous, unpredictable and hard to coordinate.

We would like to take advantage of the abstract algebraic structures defined in `Abstract` to simplify the problem. Everything depends on the `T` value: it turns out that, if `T` has certain properties, we can actually run our processes in a distributed and efficient way without any risk.

We have a collection of these processes, and we'd like to run all of them by distributing computation to many units: the processes can require different times to complete, and we'd like to distribute our processing units to different threads/queues.

```swift
class ProcessingUnit {
    let context: Context
    init(context: Context) {
        self.context = context
    }
    
    func execute<T>(_ process: Process<T>, onComplete: @escaping (T) -> ()) {
        context.execute {
            let value = process.run()
            onComplete(value)
        }
    }
}
```

The `ProcessingUnit` uses an execution context on which to run the process: we can represent this with a `protocol` and make `DispatchQueue` conform to it:

```swift
protocol Context {
    func execute(_ call: @escaping () -> ())
}

extension DispatchQueue: Context {
    func execute(_ call: @escaping () -> ()) {
        async {
            call()
        }
    }
}
```

A `Collector` class will receive all the `T` values and combine them together: the requirement on `T`, in this case, is for it to be a monoid, so it has an `.empty` value and a `<>` associative composition operation.

```swift
class Collector<T: Monoid> {
    private var current: T = .empty
    func append(_ value: T) {
        current = current <> value
    }
}
```

Finally, a `Distributor` class will distribute the work to processing units:

```swift
class Distributor {
    let serialContext = DispatchQueue.init(label: "serial")
    
    func distribute<T>(process: Process<T>, to collector: Collector<T>) {
        ProcessingUnit.init(context: serialContext).execute(process, onComplete: collector.append)
    }
}
```

Notice that, if the only constraint that we impose on `T` is `Monoid` (in the code above the requirement is implicit) we cannot do much more than distributing the work on a serial queue, because we need the processes to run and complete in the same order as they're passed to the distributor.

An improvement over this would be if `T` was a `CommutativeMonoid`: in this case the `<>` operation is declared to be commutative, which means that the order of composition doesn't matter. This way we can distribute work over a concurrent queue: even if a process ends before one that started earlier, the commutativity will insure that the composition still makes sense.

```swift
class Distributor {
    let concurrentContext = DispatchQueue.init(label: "concurrent", attributes: .concurrent)
    
    func distribute<T>(process: Process<T>, to collector: Collector<T>) where T: CommutativeMonoid {
        ProcessingUnit.init(context: concurrentContext).execute(process, onComplete: collector.append)
    }
}
```

To make further improvements we could consider the case of actually distributed executions on stateless, uncoordinated contexts that could fail, restart and execute more than once. If `T` were a `BoundedSemilattice` we could actually make this kind of context work anyway because the composition operation, other than commutative, would be declared *idempotent*, that is, applying it twice would be the same as applying it once.

```swift
class Unreliable: Context {
    func execute(_ call: @escaping () -> ()) {
        /// could call more than once
    }
}

class Distributor {
    let unreliableContext = Unreliable()
    
    func distribute<T>(process: Process<T>, to collector: Collector<T>) where T: BoundedSemilattice {
        ProcessingUnit.init(context: unreliableContext).execute(process, onComplete: collector.append)
    }
}
```

By clearly defining the composition semantics of `T` we can make assumptions that allow us to be more efficient and less constrained. But making `T` conform to `BoundedSemilattice`, `CommutativeMonoid` or even `Monoid` will require that the composition operation on `T` respects some laws like *commutativity*: `Abstract` provides functions, defined in the `Law` namespace, that will allow one to test a type against these laws, thus proving that the type has the required semantics.
