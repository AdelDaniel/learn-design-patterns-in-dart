/// SMS example.
library;

/// First,
/// we’ll create a MessagingService interface for sending messages in different ways:
abstract interface class MessagingService {
  String getMessageBody();
  String getServiceName();
}

/// Next,
/// we’ll define two implementations of the interface above, that send messages through email and SMS:
/// the EmailService class.
class EmailService implements MessagingService {
  @override
  String getMessageBody() {
    return "email message";
  }

  @override
  String getServiceName() {
    return "EmailService";
  }
}

/// The SMSService class.
class SMSService implements MessagingService {
  @override
  String getMessageBody() {
    return "SMS message";
  }

  @override
  String getServiceName() {
    return "SMSService";
  }
}

/// After
/// defining the two services,
/// we have to define the logic to initialize them:
class InitialContext {
  Object? lookup(String serviceName) {
    if (serviceName == "EmailService") {
      return EmailService();
    } else if (serviceName == "SMSService") {
      return SMSService();
    }
    return null;
  }
}

/// The last component we need before putting the service locator object together is the cache.
/// In our example, this is a simple class with a List property:
class Cache {
  List<MessagingService> services = [];

  /// retrieve from the list
  MessagingService? getService(String serviceName) {
    for (MessagingService service in services) {
      if (service.getServiceName() == serviceName) {
        print("Returning cached " + serviceName + " object");
        return service;
      }
    }
    return null;
  }

  /// add to the list
  void addService(MessagingService newService) {
    bool exists = false;
    for (MessagingService service in services) {
      if (service.getServiceName() == newService.getServiceName()) {
        exists = true;
      }
    }
    if (!exists) {
      services.add(newService);
    }
  }
}

/// Finally,
/// we can implement our service locator class:

class ServiceLocator {
  static Cache _cache = Cache();
  static InitialContext _context = new InitialContext();

  static MessagingService getService(String serviceName) {
    MessagingService? service = _cache.getService(serviceName);

    if (service != null) {
      return service;
    }

    MessagingService service1 =
        _context.lookup(serviceName) as MessagingService;
    _cache.addService(service1);
    return service1;
  }
}

/// The logic here is fairly simple.
///
/// The class holds an instance of the Cache.
/// Then, in the getService() method, it will first check the cache for an instance of the service.
/// Then, if that’s null, it will call the initializing logic and add the new object to the cache.

void main(List<String> args) {
  MessagingService service = ServiceLocator.getService("EmailService");
  String email = service.getMessageBody();
  print(email);

  MessagingService smsService = ServiceLocator.getService("SMSService");
  String sms = smsService.getMessageBody();
  print(sms);

  MessagingService emailService = ServiceLocator.getService("EmailService");
  String newEmail = emailService.getMessageBody();
  print(newEmail);
}

/// The first time we get the EmailService from the ServiceLocator a new instance is created and returned.
/// Then, after calling it the next time the EmailService will be returned from the cache.
