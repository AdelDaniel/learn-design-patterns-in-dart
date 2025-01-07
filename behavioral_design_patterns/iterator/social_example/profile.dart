/// profile
/// Social profiles
class Profile {
  late String _name;
  late String _email;
  final Map<String, List<String>> _contacts = {};

  Profile(String email, String name, List<String> contacts) {
    _email = email;
    _name = name;

    // Parse contact list from a set of "friend:email@gmail.com" pairs.
    for (String contact in contacts) {
      List<String> parts = contact.split(":");
      String contactType = "friend";
      String contactEmail;
      if (parts.length == 1) {
        contactEmail = parts[0];
      } else {
        contactType = parts[0];
        contactEmail = parts[1];
      }
      if (!contacts.contains(contactType)) {
        _contacts[contactType] = [];
      }
      _contacts[contactType]?.add(contactEmail);
    }
  }

  String get email => _email;

  String get name => _name;

  List<String> getContacts(String contactType) {
    if (!_contacts.containsKey(contactType)) {
      _contacts[contactType] = [];
    }
    return _contacts[contactType] ?? [];
  }
}
