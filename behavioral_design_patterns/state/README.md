<div id="top"></div>

# State

## Definitions  

### Def 1: 
- Behavioral Design Patterns.
- State design pattern is used when an **Object changes its behavior based on its internal state**.

- If we have to change the behavior of an object based on its `state`, we can have a state variable in the Object and use the if-else condition block to perform different actions based on the state.
- The state pattern is used to provide a `systematic` and `lose-coupled` way to achieve this through `Context` and `State` implementations.

### Def 2: https://www.geeksforgeeks.org/state-design-pattern/
- allows an object to alter its behavior when its internal state changes.
- useful when an object’s behavior depends on its state, 
- and the state can change during the object’s lifecycle.

---


<img style="background-color:#554777" align="center" src = "assets/structure_command.png">

<details>
  <summary> <h2 style="display: inline;">  Sections</h2> </summary>

- [Definitions](#definitions)
- <a href="#when-to-use">When to use</a>
- [What problems can it solve](#What-problems-can-it-solve)
- <p><a href="#Examples">Examples</a></p>
- <p><a href="#Summery">Summery</a></p>
- <p><a href="#How_To_Implement">How_To_Implement</a></p>
- [Sources](#sources)

</details>

## Definitions

### geeksforgeeks


### tutorialspoint

- Behavior pattern.
- A class behavior changes based on its state.
-  Create:
   -  `objects` which represent various states.
   -  `context` object whose behavior varies as its state object changes.

---

## Components && Diagrams (UML class || Sequence diagrams).

### Context:
 - Defines an interface for clients to interact.
 - It maintains references to concrete state objects which may be used to define the current state of objects.
### State:
 - Defines interface for declaring what each concrete state should do.
### Concrete State:
 - Provides the implementation for methods defined in State.

## Problem

---

<h2 id="when-to-use" >When to use</h2>

---

## Examples 



---



## Summery

### Strategy && State Patterns
- This structure may look similar to the Strategy pattern,
- but there’s one key difference. 
- In the State pattern, the particular states may be aware of each other and initiate transitions from one state to another,
- whereas strategies almost never know about each other.

### Strategy && State Patterns
- State can be considered as an extension of Strategy.
- Both patterns are based on composition: 
- they change the behavior of the context by delegating some work to helper objects.
- Strategy makes these objects completely independent and unaware of each other.
- However, State doesn’t restrict dependencies between concrete states, letting them alter the state of the context at will.





---

## Sources

1. <https://www.geeksforgeeks.org/state-design-pattern/>
2. https://www.tutorialspoint.com/design_pattern/command_pattern.htm
3. https://refactoring.guru/design-patterns/state

<img src = "assets/structure_command.png">

<p align="right">(<a href="#top">back to top</a>)</p>
