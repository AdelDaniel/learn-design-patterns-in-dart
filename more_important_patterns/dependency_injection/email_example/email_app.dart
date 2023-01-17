/// Email Example in [DI]

/// `Service Class` : should be designed with base class or interface.
/// It’s better to prefer interfaces or abstract classes that would define contract for the services.
/// `Client classes`: should be written in terms of service interface.
/// `Injector classes`: that will initialize the services and then the Client classes.

/// Services Classes
abstract class MessageService {
  void sendMessage(String msg, String rec);
}

/// Now let’s say we have Email and SMS services
/// that implement the above interfaces.

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

/// Client classes.
/// We are not required to have base interfaces for Client classes
/// but I will have a Client interface declaring contract for Client classes.

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

/// Injectors Classes
/// Let’s have an interface MessageServiceInjector with method declaration that returns the Client class.

abstract class MessageServiceInjector {
  Client getClient();
}

/// Now for every service,
/// we will have to create injector classes like below.

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
}

/// Now let’s see how our client applications will use the application with a simple program.

void main() {
  String msg = "Hi Pankaj";
  String email = "pankaj@abc.com";
  String phone = "4088888888";

  MessageServiceInjector injector;
  Client app;

  //Send email
  injector = EmailServiceInjector();
  app = injector.getClient();
  app.processMessages(msg, email);

  //Send SMS
  injector = SMSServiceInjector();
  app = injector.getClient();
  app.processMessages(msg, phone);
}
