# **_`OOP`_**

## Sections

- [**_`OOP`_**](#oop)
  - [Sections](#sections)
  - [What is Cohesion and Coupling?](#what-is-cohesion-and-coupling)
    - [Cohesion](#cohesion)
    - [Coupling (From couples)](#coupling-from-couples)
      - [Advantages of low coupling](#advantages-of-low-coupling)
      - [Advantages of high cohesion](#advantages-of-high-cohesion)
      - [Disadvantages of high coupling](#disadvantages-of-high-coupling)
      - [Disadvantages of low cohesion](#disadvantages-of-low-cohesion)
  - [Abstraction](#abstraction)
    - [Definition](#definition)
    - [example: the coffee machine](#example-the-coffee-machine)
    - [Abstraction two types.](#abstraction-two-types)
  - [Encapsulation](#encapsulation)
    - [Difference between abstraction \&\& encapsulation](#difference-between-abstraction--encapsulation)
  - [Inheritance](#inheritance)
    - [Forms of Inheritance in Object Oriented Programming](#forms-of-inheritance-in-object-oriented-programming)
  - [Polymorphism](#polymorphism)
    - [2 types of polymorphism:](#2-types-of-polymorphism)
    - [`Static`:](#static)
    - [`Dynamic`:](#dynamic)
  - [Summery](#summery)
    - [Object](#object)
    - [Class](#class)
    - [Inheritance](#inheritance-1)
    - [Polymorphism](#polymorphism-1)
    - [Abstraction](#abstraction-1)
    - [Encapsulation](#encapsulation-1)

---

## What is Cohesion and Coupling?

### Cohesion

- refers to the degree `to which elements within a module work together` to fulfill a single, well-defined purpose.
- 👍 High cohesion means that elements are `closely related` and `focused` on a `single purpose`,
- 👎 low cohesion means that elements are `loosely related` and `serve multiple purposes`.

### Coupling (From couples)

- refers to the degree of `interdependence` between software modules.
- 👎 High coupling means that:
  - modules are closely connected and changes in one module may affect other modules.
- 👍 Low coupling means that:
  - modules are independent,
  - and changes in one module have little impact on other modules.

#### Advantages of low coupling

Improved maintainability: Low coupling reduces the impact of changes in one module on other modules, making it easier to modify or replace individual components without affecting the entire system.
Enhanced modularity: Low coupling allows modules to be developed and tested in isolation, improving the modularity and reusability of code.
Better scalability: Low coupling facilitates the addition of new modules and the removal of existing ones, making it easier to scale the system as needed.

#### Advantages of high cohesion

Improved readability and understandability: High cohesion results in clear, focused modules with a single, well-defined purpose, making it easier for developers to understand the code and make changes.
Better error isolation: High cohesion reduces the likelihood that a change in one part of a module will affect other parts, making it easier to
Improved reliability: High cohesion leads to modules that are less prone to errors and that function more consistently,
leading to an overall improvement in the reliability of the system.

#### Disadvantages of high coupling

Increased complexity: High coupling increases the interdependence between modules, making the system more complex and difficult to understand.
Reduced flexibility: High coupling makes it more difficult to modify or replace individual components without affecting the entire system.
Decreased modularity: High coupling makes it more difficult to develop and test modules in isolation, reducing the modularity and reusability of code.

#### Disadvantages of low cohesion

Increased code duplication: Low cohesion can lead to the duplication of code, as elements that belong together are split into separate modules.
Reduced functionality: Low cohesion can result in modules that lack a clear purpose and contain elements that don’t belong together, reducing their functionality and making them harder to maintain.
Difficulty in understanding the module: Low cohesion can make it harder for developers to understand the purpose and behavior of a module, leading to errors and a lack of clarity.

## Abstraction

- hiding unnecessary details and data from the user.
- show what functionality available to use.

### Definition

- Its main goal is to handle complexity
  - by hiding unnecessary details and data from the user.
- focus on what functionality available to use
- That enables the user to implement more complex logic on top of the provided abstraction without understanding or even thinking about all the hidden complexity.

### example: the coffee machine

- You need to know how to use your coffee machine to make coffee.
- You need to provide 1-water and 2-coffee beans, switch it on and 3-select the kind of coffee you want to get.

- The thing you don’t need to know is how the coffee machine is working internally.

### Abstraction two types.

source: https://www.journaldev.com/33191/what-is-abstraction-in-oops

1. Data Abstraction (private data)
2. Process Abstraction (private methods)

---

## Encapsulation

- Encapsulation == `Single Unit`
- bundling(wrapping) data and methods that work on that data within a `single unit`

<a><img src="./assets/encapsulation.jpg"/></a>

---

### Difference between abstraction && encapsulation

<a><img src="./assets/the_difference_between_abstraction_and_encapsulation.jpeg"/></a>
<a><img src="./assets/the_difference_between_abstraction_and_encapsulation2.jpeg"/></a>

---

## Inheritance

- It is a mechanism where you can to derive a class from another class for a hierarchy of classes
- that share a set of attributes and methods.

### Forms of Inheritance in Object Oriented Programming

source: https://www.guru99.com/java-class-inheritance.html

| type                        | Definition                                                                                                                                                                                                     |     |
| --------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --- |
| 1. Single inheritance       | This is a form of inheritance in which a class inherits only one parent class                                                                                                                                  |     |
| 2. Multiple Inheritance     | An inheritance becomes multiple inheritances when a class inherits more than one parent class. ""NOt Exist In dart""                                                                                           |     |
| 3. Multi-level              | For example, a class_1 is inherited by a class_2 and this class_2 also gets inherited by class_3 and this process goes on. This is known as multi-level inheritance.                                           |     |
| 4. Hierarchical inheritance | In this, various Child classes inherit a single Parent class. The example given in the introduction of the inheritance is an example of Hierarchical inheritance since classes BMW and Audi inherit class Car. |     |
| 5. Hybrid Inheritance       | When there is a combination of more than one form of inheritance, it is known as hybrid inheritance.                                                                                                           |     |

<img src=".\assets\inheritance.jpg"/>

---

## Polymorphism

     - Many Form >> perform a single action in different ways
     - it occurs when we have many classes that are related to each other by inheritance.
     - Polymorphism is the ability of an object to take on many forms.
     - it describes the concept that you can access objects of different types through the same interface.
     - Each type can provide its own independent implementation of this interface.

### 2 types of polymorphism:

1. static or compile-time
2. dynamic
   <img src="./assets/Polymorphism-revised.jpg"/>

### `Static`:

    - can determine which method will run in the compiling time
    - do the same operation in same class
    - Overload
    - NO overloading in dart

### `Dynamic`:

    - can determine which method will run in the run time
    - same operation in different classes
    - Override

## Summery

### Object

- A real-world entity having a particular state and behavior.
- We can define it as an instance of a class.

### Class

- A logical entity that defines the blueprint from which an object can be created or instantiated.

### Inheritance

- A concept that refers to an object gaining all the properties and behaviors of a parent object.
- It provides code reusability.

### Polymorphism

- A concept that allows a task to be performed in different ways.
- In Java, we use method overloading and method overriding to achieve polymorphism.

### Abstraction

- A concept that hides the internal details of an application and only shows the functionality.
- In Java, we use abstract classes and interfaces to achieve abstraction.

### Encapsulation

- A concept that refers to the wrapping of code and data together into a `single unit`.
