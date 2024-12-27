import 'dart:developer';

/// Payment Example
///
/// we will discuss how to implement the Strategy Design Pattern.
///
/// We will start with a code example that violates the Strategy Design Pattern and explain the problems with it.
/// Then, we will refactor the code to demonstrate how to implement the Strategy Design Pattern.
///
// ! Problem
class PaymentProcessor {
  PaymentType? _paymentType;

  void processPayment(double amount) {
    if (_paymentType == PaymentType.CREDIT_CARD) {
      log("Processing credit card payment of amount " + "$amount");
    } else if (_paymentType == PaymentType.DEBIT_CARD) {
      log("Processing debit card payment of amount " + "$amount");
    } else if (_paymentType == PaymentType.PAYPAL) {
      log("Processing PayPal payment of amount " + "$amount");
    } else {
      throw "Invalid payment type";
    }
  }

  void setPaymentType(PaymentType paymentType) {
    _paymentType = paymentType;
  }
}

enum PaymentType { CREDIT_CARD, DEBIT_CARD, PAYPAL }

/// In this code, the PaymentProcessor class has a processPayment method that takes a payment amount and processes the payment.
/// The payment type is set using the setPaymentType method, which sets the paymentType field.
/// The processPayment method then checks the value of paymentType and processes the payment accordingly.

/// The problem with this code is that it violates the Open-Closed Principle, which states that classes should be open for extension but closed for modification.
/// In this code, if you want to add a new payment type, you would have to modify the processPayment method, which violates the Open-Closed Principle.

/// The PaymentProcessor class violates the Strategy pattern by using conditional statements to determine the type of payment and then processing it accordingly.
/// This approach can quickly become unmanageable and inflexible as the number of payment types increases.

/// 
/// 
/// FIX
/// 
/// To fix this problem, you can use the Strategy Design Pattern
/// 
/// Step 1: Identify the algorithm or behavior that needs to be encapsulated and made interchangeable.
/// Step 2: Define an interface that represents the behavior, with a single method signature that takes in any required parameters.
/// Step 3: Implement concrete classes that provide specific implementations of the behavior defined in the interface.
/// Step 4: Define a context class that holds a reference to the interface and calls its method when needed.
/// Step 5: Modify the context class to allow for the dynamic swapping of the concrete implementations at runtime.

abstract interface class PaymentStrategy {
  void processPayment(double amount);
}

/// You then define concrete implementations of the PaymentStrategy interface for each payment type.
/// For example, here are the CreditCardPaymentStrategy, DebitCardPaymentStrategy, and PaypalPaymentStrategy classes:

class CreditCardPaymentStrategy implements PaymentStrategy {
  void processPayment(double amount) {
    log("Processing credit card payment of amount: $amount");
  }
}

class DebitCardPaymentStrategy implements PaymentStrategy {
  void processPayment(double amount) {
    log("Processing debit card payment of amount: $amount");
  }
}

class PaypalPaymentStrategy implements PaymentStrategy {
  void processPayment(double amount) {
    log("Processing PayPal payment of amount: $amount");
  }
}

/// Finally, you update the PaymentProcessor class to take a PaymentStrategy object in its constructor, which it uses to process the payment:

class PaymentProcessorStrategy {
  PaymentStrategy? _paymentStrategy;

  PaymentProcessor(PaymentStrategy paymentStrategy) {
    _paymentStrategy = paymentStrategy;
  }

  void processPayment(double amount) {
    _paymentStrategy?.processPayment(amount);
  }
}
// This implementation follows the Open-Closed Principle as well as Strategy Pattern because you can add new payment types by creating new implementations of the PaymentStrategy interface without modifying the existing code.
