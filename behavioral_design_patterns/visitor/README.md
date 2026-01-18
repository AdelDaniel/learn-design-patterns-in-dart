<div id="top"></div>

# Visitor Design Pattern

- A behavioral design pattern:

  > Makes it possible to add new operations to pre-existing classes without changing them.

- **separate algorithms from the objects**

- [Visitor Design Pattern](#visitor-design-pattern)
  - [Definitions](#definitions)
  - [Components \&\& Diagrams (UML class || Sequence diagrams).](#components--diagrams-uml-class--sequence-diagrams)
    - [Components By geeksforgeeks](#components-by-geeksforgeeks)
      - [- `Visitor Interface`:](#--visitor-interface)
      - [- `Concrete Visitor`:](#--concrete-visitor)
      - [- `Element Interface`:](#--element-interface)
      - [- `Concrete Elements`:](#--concrete-elements)
      - [- `Object Structure`:](#--object-structure)
    - [Components By Guru](#components-by-guru)
      - [1. The Visitor interface:](#1-the-visitor-interface)
      - [2. Each Concrete Visitor:](#2-each-concrete-visitor)
      - [3. The Element interface:](#3-the-element-interface)
      - [4. Concrete Element:](#4-concrete-element)
      - [5. The Client:](#5-the-client)
  - [What problems can it solve || When to Use || Use Cases](#what-problems-can-it-solve--when-to-use--use-cases)
    - [Geeks: The Design Pattern can be useful in various scenarios, such as:](#geeks-the-design-pattern-can-be-useful-in-various-scenarios-such-as)
    - [GURU](#guru)
  - [Examples](#examples)
    - [Area example (Good - near to the real life)](#Area-example-Good-near-to-the-real-life")
    - [Shapes Example (Best)](#Shapes-Example-Best)
  - [Summery](#summery)
  - [Sources](#sources)

---

<!-- MARK: Definitions -->

## Definitions

- <details>
  <summary> <h3 style="display: inline;"> Tutorial Point </h3> </summary>
  - Allows you to add new operations (behaviors) to an existing object structure
  - without modifying the classes of the objects themselves.

  </details>

- <details>
  <summary> <h3 style="display: inline;"> geeksforgeeks.org </h3> </summary>
  - A behavioral pattern:
    - Allows you to add new operations to a group of related classes
    - without modifying their structures.

  ***
  - It is particularly useful when you have a stable set of classes but need to perform various operations on them,
  - making it easy to extend functionality without altering the existing codebase.

  </details>

- <details>
  <summary> <h3 style="display: inline;"> refactoring.guru </h3> </summary>

  `Visitor is a behavioral design pattern`
  - that lets you **separate algorithms from the objects** on which they operate.

  </details>

---

<!-- MARK: Components && Diagrams (UML class || Sequence diagrams). -->

## Components && Diagrams (UML class || Sequence diagrams).

### Components By geeksforgeeks

<img style="background-color:#554777" src = "assets/Visitor-Design-Pattern-Diagram.png">

Components of Visitor Design Pattern:

#### - `Visitor Interface`:

- This interface **declares a visit method** for each type of element in the object structure.
- Each method is designed to handle a specific element type.

#### - `Concrete Visitor`:

- This class **implements the Visitor interface**.
- provides the specific behavior for each visit method.
- It contains the logic for the operations that need to be performed on the elements.

#### - `Element Interface`:

- This interface defines **an accept method that takes a visitor as an argument**.
- This method allows the visitor to visit the concrete elements.

#### - `Concrete Elements`:

- These classes **implement the Element interface** and
- represent the various types of objects in the structure.
- Each concrete element defines how it accepts a visitor by calling the corresponding method on the visitor.

#### - `Object Structure`:

- This is the collection of elements (the concrete elements) that the visitor will operate on.
- It often includes methods to add, remove, and retrieve elements.

### Components By Guru

<img style="background-color:#554777" src = "assets/visitor_guru_structure.png">

#### 1. The Visitor interface:

- Declares a set of visiting methods that can take concrete elements of an object structure as arguments.
- These methods may have the same names if the program is written in a language that supports overloading, but the type of their parameters must be different.

#### 2. Each Concrete Visitor:

- Implements several versions of the same behaviors, tailored for different concrete element classes.

#### 3. The Element interface:

- Declares a method for “accepting” visitors.
- This method should have one parameter declared with the type of the visitor interface.

#### 4. Concrete Element:

- Implements the acceptance method.
- The purpose of this method is to redirect the call to the proper visitor’s method corresponding to the current element class.
- Be aware that even if a base element class implements this method, all subclasses must still override this method in their own classes and call the appropriate method on the visitor object.

#### 5. The Client:

- Usually represents a collection or some other complex object (for example, a Composite tree).
- Usually, clients aren’t aware of all the concrete element classes because they work with objects from that collection via some abstract interface.

---

<!-- MARK: When to Use -->

## What problems can it solve || When to Use || Use Cases

- separate algorithms from the objects

### Geeks: The Design Pattern can be useful in various scenarios, such as: Pros

#### Separation of Concerns:

- This pattern keeps operations separate from the objects themselves, making it easier to manage and understand the code.

#### Easy to Add New Features:

- You can introduce new operations simply by creating new visitor classes without changing the existing objects. This makes the system flexible.

#### Centralized Logic:

- All the operations are in one place (the visitor), which helps you see how different tasks interact with your objects.

#### Easier Maintenance:

- If you need to update or fix something, you can do it in the visitor class without touching the object classes, making maintenance simpler.

#### Type Safety:

- Each visitor method is specific to an object type, which helps catch errors early and ensures the right operations are applied.

### GURU

- Use the Visitor: when you need to perform an operation on all elements of a complex object structure (for example, an object tree).

lets you execute an operation over a set of objects with different classes by having a visitor object implement several variants of the same operation, which correspond to all target classes.

- Use the Visitor: to clean up the business logic of auxiliary behaviors.

lets you make the primary classes of your app more focused on their main jobs by extracting all other behaviors into a set of visitor classes.

- Use the pattern: when a behavior makes sense only in some classes of a class hierarchy, but not in others.

You can extract this behavior into a separate visitor class and implement only those visiting methods that accept objects of relevant classes, leaving the rest empty.

## Examples

### Computer Example (Easy Hard to understand from it the visitor pattern)

Source: [Tutorial Point](https://www.tutorialspoint.com/design_pattern/visitor_pattern.htm)
Dart Code: [link](computer_visitor_example.dart)

<img style="background-color:#554777" src = "https://www.tutorialspoint.com/design_pattern/images/visitor_pattern_uml_diagram.jpg">

### Area example (Good - near to the real life)

- Source: [Geeks for Geeks](https://www.geeksforgeeks.org/system-design/visitor-design-pattern/)
- Dart Code: [link](area_example.dart)

### Shapes Example (Best)

- Source: [refactoring.guru java example](https://refactoring.guru/design-patterns/visitor/java/example)
- Dart Code: [link](shapes_example.dart)

## Summery

<img style="background-color:#554777" src = "assets/Visitor-Design-Pattern-Diagram.png">

<img style="background-color:#554777" src = "assets/visitor_guru_structure.png">

> The Visitor design pattern is a behavioral pattern that allows you to add new operations to a group of related classes without modifying their structures. It is particularly useful when you have a stable set of classes but need to perform various operations on them, making it easy to extend functionality without altering the existing codebase.

## Sources

- https://www.geeksforgeeks.org/system-design/visitor-design-pattern/
- https://refactoring.guru/design-patterns/visitor

<p align="right">(<a href="#top">back to top</a>)</p>
