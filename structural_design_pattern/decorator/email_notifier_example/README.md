# Email Notifier Example

## With Decorator 

<img src = "../assets/Decorator_Design_Pattern_UML.jpg" >

```dart
abstract class Notifier {
  void notify();
}

class EmailNotifier implements Notifier {
  String _email;
  EmailNotifier(String email) : _email = email;
  @override
  void notify() => print("Sending email to: $_email \n");
}

class NotifierDecorator implements Notifier {
  Notifier _notifier;
  NotifierDecorator(Notifier notifier) : _notifier = notifier;

  Notifier get notifier => _notifier;
  set notifier(Notifier notifier) => _notifier = notifier;

  notify() => _notifier.notify();
}

class SMSNotifierDecorator extends NotifierDecorator {
  String _phoneNumber;

  SMSNotifierDecorator(Notifier notifier, String phoneNumber)
      : _phoneNumber = phoneNumber,
        super(notifier);

  @override
  void notify() {
    super.notify();
    _sendSMS();
  }

  void _sendSMS() => print("Sending SMS to $_phoneNumber \n");
}

class WhatsAppNotifierDecorator extends NotifierDecorator {
  String _phoneNumber;

  WhatsAppNotifierDecorator(Notifier notifier, String phoneNumber)
      : _phoneNumber = phoneNumber,
        super(notifier);
  @override
  void notify() {
    super.notify();
    _sendSMS();
  }

  void _sendSMS() => print("Sending WhatsApp message to $_phoneNumber \n");
}

void main(List<String> args) {
  bool isSmsNotificationEnabled = true;
  bool isWhatsAppNotificationEnabled = true;
  Notifier notifier = EmailNotifier("me@example.com");

  if (isSmsNotificationEnabled) {
    notifier = SMSNotifierDecorator(notifier, "01000");
  }
  if (isWhatsAppNotificationEnabled) {
    notifier = WhatsAppNotifierDecorator(notifier, "01000");
  }

  notifier.notify();
}
```
## Without Decorator 

```dart
abstract class Notifier {
  void notify();
}

class EmailNotifier implements Notifier {
  String _email;
  EmailNotifier(String email) : _email = email;
  @override
  void notify() => print("Sending email to: $_email \n");
}

// the Phone Notifiers using whats app or sms
abstract class PhoneNotifier implements Notifier {
  String _phoneNumber;
  PhoneNotifier(String phoneNumber) : _phoneNumber = phoneNumber;
}

class SMSNotifier extends PhoneNotifier {
  SMSNotifier(String phoneNumber) : super(phoneNumber);
  @override
  void notify() => print("Sending SMS to $_phoneNumber \n");
}

class WhatsAppNotifier extends PhoneNotifier {
  WhatsAppNotifier(String phoneNumber) : super(phoneNumber);
  @override
  void notify() => print("Sending WhatsApp message to $_phoneNumber \n");
}

void main(List<String> args) {
  bool isSmsNotificationEnabled = true;
  bool isWhatsAppNotificationEnabled = true;
  Notifier emailNotifier = EmailNotifier("me@example.com");
  emailNotifier.notify();
  if (isSmsNotificationEnabled) {
    Notifier sMSNotifier = SMSNotifier("01000");
    sMSNotifier.notify();
  }
  if (isWhatsAppNotificationEnabled) {
    Notifier whatsAppNotifier = WhatsAppNotifier("01000");
    whatsAppNotifier.notify();
  }
}

```