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
