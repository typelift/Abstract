# Rationale

`Abstract` proposes a hierarchy of basic algebraic structures, defined with protocols, along with the laws that should be respected for every structure, and defines some concrete types to conform to those structures, for which the laws are tested with the [SwiftCheck](https://github.com/typelift/SwiftCheck) library.

Every source file contains an initial section that briefly explains what the content is about, so to get a grasp on the underlying theory you can scan the following files in order:

- [`Law.swift`](Sources/Abstract/Law.swift)
- [`Magma.swift`](Sources/Abstract/Magma.swift)
- [`Semigroup.swift`](Sources/Abstract/Semigroup.swift)
- [`Monoid.swift`](Sources/Abstract/Monoid.swift)
- [`CommutativeMonoid.swift`](Sources/Abstract/CommutativeMonoid.swift)
- [`BoundedSemilattice.swift`](Sources/Abstract/BoundedSemilattice.swift)
- [`Semiring.swift`](Sources/Abstract/Semiring.swift)
- [`Homomorphism.swift`](Sources/Abstract/Homomorphism.swift)
- [`Isomorphism.swift`](Sources/Abstract/Isomorphism.swift)

There are also a few abstractions that, while not present in the underlying theory, allow to express useful concepts given the Swift's type system.

- [`Wrapper.swift`](Sources/Abstract/Wrapper.swift)
- [`Adapters.swift`](Sources/Abstract/Adapters.swift)

Finally, some "utility" files contain useful functions to practically use some concepts of abstract algebra in concrete contexts.

- [`Collections.swift`](Sources/Abstract/Utilities/Collections.swift)
- [`Comparison.swift`](Sources/Abstract/Utilities/Comparison.swift)
- [`Predicate.swift`](Sources/Abstract/Utilities/Predicate.swift)

------

The main idea behind these abstractions is the simple operation of *putting two things together*, thus combining two instances of a certain type into a single instance of the same type, with a generic binary operation:

```
x + x = x
```

Notice that `x` is not necessarily a number, `+` is not necessarily addition, and `=` simply indicates the result of the operation.

For example, two integers could be summed into a single integer, but they could actually be operated in multiple ways, like in multiplication, subtraction or division, so the type `Int` by itself doesn't express a specific semantics for the combination operation. In case of addition, for example, we might need an `Add` type, in which the composition is expressed by addition. Another operation on integers, for example, is getting the *max value* between the two: this is still a binary operation, that takes two instances of the same type, and returns an instance of the same type. The concept of *taking the max value between to comparable instances* (not necessarily numbers) can be represented by a `Max` type.

We can call a `Magma`, a set - or, in programming terms, a *type* - equipped with a binary operation that must be *closed*, that is, valid (i.e. non-crashing) for every 2 possible instances of that type. `Magma` is defined by a protocol, and the binary operation is represented with the *diamond operator* `<>`. This is, of course, all convention: there are reasons to use an operator instead of a global, static or instance method, but there is no particular reason to use `<>`: it's conventional, and the operator itself is defined in the [`Operadics`](https://github.com/typelift/Operadics) library.

---

On top of `Magma`, a hierarchy of abstractions is built. In general, every abstraction introduces some additional semantic requirements. For example, `Semigroup` requires that the binary operation is *associative*, i.e., if more operations are chained, the parentheses don't matter: we can group operations in any way, as long as the values on which the operation is applied stay in the same global order.

For example, if `T` is a semigroup, given:

```
let a: T
let b: T
let c: T
```

The following expressions are exactly the same, i.e., evaluate to the exact same value:

```
(a <> b) <> c == a <> (b <> c)
```

These concepts are rooted in *abstract algebra*, a field in mathematics that has many useful applications in programming and theory of computation.

---

Other than the protocol definitions for the main abstract algebraic concepts, like `Monoid` and `Semiring`, the point of this library is to provide two things:

- concrete implementations for the algebraic structures that express specific semantics;
- a way to formally prove that a type respects the required laws for a specific abstraction;

For example, the `And` type implements the `BoundedSemilattice` protocol. This means that the binary operation given by the fact that `BoundedSemilattice` inherits (indirectly) from `Magma`, has many properties:

- is associative;
- selects an `empty` distinguished element/instance from the underlying set/type (in case of `And`, the underlying type is `Bool`) that is completely neutral in respect to the operation (like adding zero to a number);
- is commutative (we can switch the operands, and the result doesn't change);
- is idempotent, i.e., applying the operation twice is *exactly* the same as applying it once;

How can we be sure that a certain type is a *proper* `BoundedSemilattice`? In fact, the *interface*, from the algebraic perspective, only consists of the `<>` operator and the `empty` static method, but being a `BoundedSemilattice` means respecting all the *laws* we just listed.

One of the main points of the `Abstract` library is providing the user with simple means to test concrete types against the laws that the type must respect.

The `Law` and `LawInContext` namespaces provide some functions for types for which the `<>` operation is supposed to respect some laws; these functions require that the tested type is `Equatable` because the `==` operation is used to check if the equations that express the law evaluate into `true` or `false`. Because at the present moment there's no possibility of conditional conformance to the `Equatable` protocol in Swift's type system, all the concrete types in `Abstract` are made to conform either to `Equatable` or `EquatableInContext` (the latter is used for types that wrap functions). When conditional conformance [will be implemented](https://github.com/apple/swift-evolution/blob/master/proposals/0143-conditional-conformances.md) into Swift, there will be a `Equatable` implementation for the various types only under certain assumptions.

------

Test code and `Arbitrary` type definitions are automatically generated for (almost) all types using [Sourcery](https://github.com/krzysztofzablocki/Sourcery)

The script in `sourceryTests.sh` requires Sourcery to scan source files in `Sources/Abstract` and generate code with the templates defined in `Templates/Tests`; generated files are put in `Tests/AbstractTests` and are recognizable by the `.generated` in the name: these files must not be edited manually. Also an `Arbitrary.generate.swift` file is automatically generated, along with `Linux.main.swift`.

Sourcery is just a tool for code generation: at compile time the actual check for a type to conform to a certain protocol is guaranteed by the functions defined in the `Law` namespace, thus the generated tests are associated to specific algebraic structures rather than particular properties (like "associative" or "idempotent").

Sourcery will automatically generate tests for all types conforming to the protocols representing the algebraic data structures considered, and some annotations associated with a type (in the form `// sourcery: annotation`) will allow some fine tuning or `Arbitrary` generation:

- `ignore = "value"`: Sourcery will not generate tests related to that protocol for that type; "value" is the protocol's name (like "Semigroup" or "CommuntativeMonoid");
- `fixedTypesForPropertyBasedTests = "value"`: for generic types it defines the concrete type to be used in tests; if more than one generic type is present, all types must be separated by a comma;
- `requiredContextForPropertyBasedTests = "value"`: use `LawInContext` instead of `Law`; "value" is the context type; this is required if the type wraps a function;
- `arbitrary`: Sourcery will generate the `Arbitrary` definitions for that type; if it's a non-generic type Sourcery will add a `extension Type: Arbitrary`; if the type is generic, Sourcery will define a new `struct ArbitraryType<T: Arbitrary>: Arbitrary`;
- `arbitraryFunction`: same as `arbitrary` but for function wrappers (like `FunctionS`);
- `arbitraryGenericParameterProtocols = "value"`: if the type is generic, Sourcery will add these constraints for the generic parameter `T` in `ArbitraryType<T>` in the form of `T: value`
- `additionalGenericParameterSubtypeRequirement = "value"`: if the type is generic, and a subtype of the generic parameter has some additional constraints, Sourcery will add them to `ArbitraryType<T>` in the form of `T.value` (example: `T.Additive: Equatable` if "value" is `Additive: Equatable`);
- `additionalGenericParameterSubtypeRequirements = "value"`: same as before, but there's more than one requirement; in this case, more than one `additionalGenericParameterSubtypeRequirements` annotation should be added; if there's only one requirement, `additionalGenericParameterSubtypeRequirement` should be used.

------

This work is largely based on some talks of the 2017 [Functional Swift Conference](http://2017.funswiftconf.com), in particular [this](https://www.youtube.com/watch?v=6z9QjDUKkCs) and [this](https://www.youtube.com/watch?v=VFPhPOnPiTY).

I personally don't have a background in maths. I learned these things in the last few years, while also finding ways to practically apply them in my everyday work. Thus, there could be some mistakes regarding the exposed bits of theory behind all this.

Mistakes are bad, and should be corrected. But I think it's extremely important to understand that concepts often change face when moving from a language to another: Swift is not Agda, Haskell or Scala... Swift is its own thing, and I find very important to try and define things in a "Swifty" way.

A plain translation into Swift from a language with a more sophisticated type system will almost certainly result in something ugly and impractical. On the other hand, I'm also interested in pushing the boundaries of Swift's expressivity, thus I think it's ok to do stuff a little less rigorous (without losing laws conformance or writing unsound code, of course) but much more practically usable.

I hope that this library will inspire people to find new and interesting ways to take advantage of the basic theoretical concepts of abstract algebra in their day-to-day Swift code, while also trying to push the boundaries of Swift, thus contributing to the general improvement of the language in the process.