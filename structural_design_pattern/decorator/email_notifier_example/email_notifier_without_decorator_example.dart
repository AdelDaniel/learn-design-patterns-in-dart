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
