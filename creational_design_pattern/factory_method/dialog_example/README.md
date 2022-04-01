# Dialog Example 

From: [guru design-patterns factory-method](https://refactoring.guru/design-patterns/factory-method)

    This example illustrates how the Factory Method can be used for creating cross-platform UI elements without coupling the client code to concrete UI classes.

## UML Diagram     
<img src="../assets/factory_pattern_dialog_example.png"/>

## Arrows In Diagram

    - webDialog and WindowsDialog are Extend Dialog
    - HTMLButton and WindowsButton are Implements Button 
    - the relationship between Dialog and Button is `Part-of` (association)