# Dart Programming Language

## OOP

- <strong><a href="1_oop/" target="_blank">What Is OOP ?!</a></strong>
- <strong><a href="2_oop_relationships/" target="_blank">OOP Relationships ?!</a></strong>
- <strong><a href="3_solid_principles/" target="_blank">S.O.L.I.D principles ?!</a></strong>

## **Design Patterns**

> reusable solution to a commonly occurring problem within a given context in software design.

- It is not a finished design that can be transformed directly into source or machine code.

  - Rather, it is a _description_ or _template_
  - for how to solve a problem that can be used in many different situations.

- Design patterns are formalized best practices that the programmer can use to solve common problems when designing an application or system.

- Object-oriented design patterns
  1. show relationships and interactions
  1. between classes or objects,
  1. without specifying the final application classes or objects that are involved.

> Patterns that imply mutable state may be unsuited for functional programming languages.

Some patterns can be rendered unnecessary in languages that have built-in support for solving the problem they are trying to solve, and object-oriented patterns are not necessarily suitable for non-object-oriented languages.

---

## **Creational Design Patterns**

- **Wikipedia**

  - Are design patterns that deal with object creation mechanisms, trying to create objects in a manner suitable to the situation.
  - The basic form of object creation could result in design problems or in added complexity to the design.
  - Creational design patterns solve this problem by somehow controlling this object creation.
  - Creational design patterns are composed of two dominant ideas.
  - One is encapsulating knowledge about which concrete classes the system uses.
  - Another is hiding how instances of these concrete classes are created and combined

- **Tutorial point**

  - a way to create objects.
  - while hiding the creation logic, rather than instantiating objects directly using new operator.
  - This gives program more flexibility in deciding which objects need to be created for a given use case.

- <strong><a href="creational_design_pattern/factory_method" target="_blank">Factory Method</a></strong>
- <strong><a href="creational_design_pattern/builder" target="_blank">Builder </a></strong>

---

## **Structural Design Patterns**

- **Wikipedia**

  - Structural patterns are concerned with how classes and objects are composed to form larger structures.
  - Structural class patterns use inheritance to compose
  interfaces or implementations. - As a simple example, consider how multiple
  inheritance mixes two or more chasses into one. The result is a class that 3 combines the properties of its parent chasses.
  <!-- - This pattern is particularly useful for making iridependently developed class libraries work together.
      - Another example is the class form of the Adapter pattern. In general, an adapter makes |one interface (the adaptee's) conform to another, thereby providing a uniform abstraction of different interfaces.A class adapter accomplishes this by 1 inheriting privately from an adaptee class. The adapter then expresses its | interface in terms of the adaptee’s. | -->

- **tutorial point**

  - These design patterns concern class and object composition.
  - Concept of inheritance is used to compose interfaces and define ways to compose objects to obtain new functionalities.

- <strong><a href="structural_design_pattern/Adapter/" target="_blank">Adapter</a></strong>

- <strong><a href="structural_design_pattern/bridge/" target="_blank">Bridge</a></strong>

- <strong><a href="structural_design_pattern/decorator/" target="_blank">Decorator</a></strong>

- <strong><a href="structural_design_pattern/facade/" target="_blank">Facade</a></strong>

- <strong><a href="structural_design_pattern/proxy/" target="_blank">Proxy</a></strong>

---

## **Behavioral Design Patterns**

> refactoring.guru: Behavioral design patterns are concerned with `algorithms` and the `assignment` of responsibilities between objects.

- **Wikipedia**

  - behavioral design patterns are design patterns that identify `common communication patterns among objects`.

- **tutorial point**

  - These design patterns are specifically concerned `with communication between objects`.

- <strong><a href="behavioral_design_patterns/chain_of_responsibility/" target="_blank">Chain Of Responsibility</a></strong>
- <strong><a href="behavioral_design_patterns/observer/" target="_blank">Observer</a></strong>
- <strong><a href="behavioral_design_patterns/command/" target="_blank">Command</a></strong>
- <strong><a href="behavioral_design_patterns/strategy/" target="_blank">Strategy</a></strong>
- <strong><a href="behavioral_design_patterns/state/" target="_blank">State</a></strong>
- <strong><a href="behavioral_design_patterns/iterator/" target="_blank">Iterator</a></strong>

---

## **Other Patterns Not Exist In GOF**

- <strong><a href="more_important_patterns/dependency_injection/" target="_blank">Dependency Injection</a></strong>

- <strong><a href="more_important_patterns/service_locator/" target="_blank">Service Locator</a></strong>
