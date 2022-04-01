# Computer Example

## Computer Class 
- Monitor monitor
- CoolingSystem coolingSystem
- MotherBoard MotherBoard
- Cooling System
- UPS
- Mother board (CPU, RAM, GPU, Sockets, Network, Card, Disk) 
- Keyboard
- Mouse

## Problem:
let’s think about how to create a Computer object.
To build a simple Computer, you need to construct Mother-Board and a Monitor, install a GPU, and build a OS. But what if you want a bigger, brighter Computer, with a Cooling System and other goodies (like an additional RAM, Sockets, and electrical wiring)?

###  Bad Solution 1  Concrete Classes Solution (WRONG)
    The simplest solution is to extend the base Computer class and create a set of subclasses to cover all combinations of the parameters.
    But eventually you’ll end up with a considerable number of subclasses. Any new parameter, such as the porch style, will require growing this hierarchy even more.

=> class `1` Simple Computer Machine (Monitor + Mother Board (CPU + RAM + Disk + Network Card) + Keyboard + Mouse)

=> class `2` Computer With Cooling System  (class `1` + Cooling System)

=> class `3` Computer with Cooling System and Power Backup (class `2` + UPS)

###  Bad Solution 2  giant Constructor Solution (WRONG)

    class with all possible parameters that control the house object. While this approach indeed eliminates the need for subclasses, it creates another problem.
--- 
## Builder Pattern Solution Class Computer
The Builder pattern suggests that:
- you extract the object construction code out of its own class
- and move it to separate objects called builders.

### 1- UML 
UML need to implement.
<img src="../assets/builder_design_pattern.png" >
<img src="../assets/computer_example.svg" >
