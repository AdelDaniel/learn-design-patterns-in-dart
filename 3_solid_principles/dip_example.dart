//! RIGHT Way

/// Low Level
abstract class BaseMail {
  send();
}

class HotMail implements BaseMail {
  @override
  send() {}
}

class Gmail implements BaseMail {
  @override
  send() {}
}

/// high level
class Notification {
  BaseMail baseMail;

  Notification(this.baseMail);

  void send() => baseMail.send();
}

/// in Main
void main(List<String> args) {
  Notification notification = Notification(Gmail());
  notification.send();
}




//! WRONG Way
//// /// Low Level
// class HotMail {
//   send() {}
// }

// class Gmail {
//   send() {}
// }

// /// high level
// class Notification {
//   HotMail hotMail = HotMail();
//   Gmail gmail = Gmail();

//   void sendGmail() => gmail.send();
//   void sendHotMail() => hotMail.send();
// }

// /// in Main
// void main(List<String> args) {
//   Notification notification = Notification();
//   notification.sendGmail();
//   notification.sendHotMail();
// }
