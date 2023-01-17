# Email Example

src: https://www.digitalocean.com/community/tutorials/java-dependency-injection-design-pattern-example-tutorial

## Dependency Injection design pattern

- allows us to remove the hard-coded dependencies
- and make our application `loosely coupled`, `extendable` and `maintainable`.

---

> we will see simple example Without (DI) and then how to use dependency injection pattern to achieve (loose coupling and extendability) in the application.

## simple example Without (DI)

- Let’s say we have an application where we consume EmailService to send emails.
- Normally we would implement this like below.

```dart
class EmailService {
  void sendEmail(String message, String receiver) {
    //logic to send email
    print("Email sent to " + receiver + " with Message=" + message);
  }
}
```

- EmailService class holds the logic to send an email message to the recipient email address.
- Our application code will be like below.

```dart
class MyApplication {
  EmailService _email = EmailService();

  void processMessages(String msg, String rec) {
    //do some msg validation, manipulation logic etc
    _email.sendEmail(msg, rec);
  }
}
```

- Our client code that will use MyApplication class to send email messages will be like below.

```dart

void main() {
  MyApplication app = MyApplication();
  app.processMessages("Hi Pankaj", "pankaj@abc.com");
}
```

### At first look,

- there seems nothing wrong with the above implementation.
- But above code logic has certain limitations.

- MyApplication class is
  - (1-responsible to initialize the email service)
  - and (2-then use it).

#### problem 1

- This leads to hard-coded dependency.
  - If we want to switch to some other advanced email service in the future,
  - it will require code changes in MyApplication class.
  - This makes our application hard to extend and if email service is used in multiple classes then that would be even harder.

#### problem 2

- If we want to extend our application to provide an additional messaging feature,
  - such as SMS or Facebook message
  - then we would need to write another application for that.
- This will involve code changes in application classes and in client classes too.

#### problem 3

- Testing the application will be very difficult since our application is directly creating the email service instance.
- There is no way we can mock these objects in our test classes.
- One can argue that we can remove the email service instance creation from MyApplication class
- by having a constructor that requires email service as an argument.

---

## Fix The Simple example With (DI)

- One can argue that we can remove the email service instance creation from MyApplication class by having a constructor that requires `email service` as an argument.

```dart
class MyApplication {
  EmailService _email;

  MyApplication(this._email);

  void processMessages(String msg, String rec) {
    //do some msg validation, manipulation logic etc
    _email.sendEmail(msg, rec);
  }
}
```

---

## Full Example

- `Service Class` : should be designed with base class or interface.
  - It’s better to prefer interfaces or abstract classes that would define contract for the services.
- `Client classes`: should be written in terms of service interface.
- `Injector classes`: that will initialize the services and then the Client classes.

- For our case, we can have MessageService that will declare the contract for service implementations.

### Services Classes

```dart
abstract class MessageService {
  void sendMessage(String msg, String rec);
}
```

- Now let’s say we have `(Email and SMS services)` that implement the above interfaces.

```dart

class EmailServiceImpl implements MessageService {
  @override
  void sendMessage(String msg, String rec) {
    //logic to send email
    print("Email sent to $rec with Message=$msg ");
  }
}

class SMSServiceImpl implements MessageService {
  @override
  void sendMessage(String msg, String rec) {
    //logic to send SMS
    print("SMS sent to $rec with Message=$msg ");
  }
}
```

### Client classes.

- We are not required to have base interfaces for Client classes
- but I will have a Client interface declaring contract for Client classes.

```dart
abstract class Client {
  void processMessages(String msg, String rec);
}

/// My Client class implementation is like below.

class MyDIApplication implements Client {
  MessageService _service;

  MyDIApplication(this._service);

  @override
  void processMessages(String msg, String rec) {
    //do some msg validation, manipulation logic etc
    _service.sendMessage(msg, rec);
  }
}
```

- Notice that our application class is just using the service.
- It does not initialize the service that leads to better “separation of concerns”.
- Also use of service interface allows us to easily test the application by mocking the MessageService and bind the services at runtime rather than compile time.

### Injectors Classes

- Let’s have an interface MessageServiceInjector with method declaration that **returns the Client class**.

```dart
abstract class MessageServiceInjector {
  Client getClient();
}
```

- Now for every service,
- we will have to create injector classes like below.

```dart
class EmailServiceInjector implements MessageServiceInjector {
  @override
  Client getClient() {
    return MyDIApplication(EmailServiceImpl());
  }
}

class SMSServiceInjector implements MessageServiceInjector {
  @override
  Client getClient() {
    return MyDIApplication(SMSServiceImpl());
  }
```

```dart
/// Now let’s see how our client applications will use the application with a simple program.

void main() {
  String msg = "Hi Pankaj";
  String email = "pankaj@abc.com";
  String phone = "4088888888";

  MessageServiceInjector injector;
  Client app;

  //Send email
  injector =  EmailServiceInjector();
  app = injector.getClient();
  app.processMessages(msg, email);

  //Send SMS
  injector =  SMSServiceInjector();
  app = injector.getClient();
  app.processMessages(msg, phone);
}
```
