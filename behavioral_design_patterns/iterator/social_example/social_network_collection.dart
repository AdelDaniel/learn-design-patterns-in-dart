import 'profile.dart';
import 'profile_iterator.dart';

/// Social Networks [Collection]
///
/// Defines common social network interface
/// The collection interface must declare a factory method for producing iterators.
/// You can declare several methods if there are different kinds of iteration available in your program.

/// Each concrete collection is coupled to a set of concrete iterator classes it returns.
/// But the client isn't,
/// since the signature of these methods returns iterator interfaces.

abstract interface class SocialNetwork {
  ProfileIterator createFriendsIterator(String profileEmail);
  ProfileIterator createCoworkersIterator(String profileEmail);
}

/// Facebook
/// The bulk of the collection's code should go here
class Facebook implements SocialNetwork {
  final List<Profile> _profiles;

  Facebook(List<Profile>? cache) : _profiles = cache ?? [];

  Profile? requestProfileFromFacebook(String profileEmail) {
    // Here would be a POST request to one of the Facebook API endpoints.
    // Instead, we emulates long network connection, which you would expect
    // in the real life...
    print("-> simulate Network Latency...");
    print("Facebook: Loading profile '$profileEmail' over the network...");

    // ...and return test data.
    return _findProfile(profileEmail);
  }

  List<String> requestProfileFriendsFromFacebook(
      String profileEmail, String contactType) {
    // Here would be a POST request to one of the Facebook API endpoints.
    // Instead, we emulates long network connection, which you would expect
    // in the real life...
    print("-> simulate Network Latency...");
    print(
      "Facebook: Loading '$contactType' list of '$profileEmail' over the network...",
    );

    // ...and return test data.
    Profile? profile = _findProfile(profileEmail);
    if (profile != null) {
      return profile.getContacts(contactType);
    }
    return [];
  }

  Profile? _findProfile(String profileEmail) {
    for (Profile profile in _profiles) {
      if (profile.email.contains(profileEmail)) {
        return profile;
      }
    }
    return null;
  }

  @override
  ProfileIterator createFriendsIterator(String profileEmail) {
    return FacebookIterator(this, "friends", profileEmail);
  }

  @override
  ProfileIterator createCoworkersIterator(String profileEmail) {
    return FacebookIterator(this, "coworkers", profileEmail);
  }
}

/// LinkedIn
class LinkedIn implements SocialNetwork {
  final List<Profile> _contacts;

  LinkedIn(List<Profile>? cache) : _contacts = cache ?? [];

  Profile? requestContactInfoFromLinkedInAPI(String profileEmail) {
    // Here would be a POST request to one of the LinkedIn API endpoints.
    // Instead, we emulates long network connection, which you would expect
    // in the real life...
    print("-> simulate Network Latency...");
    print("LinkedIn: Loading profile '$profileEmail' over the network...");

    // ...and return test data.
    return _findContact(profileEmail);
  }

  List<String> requestRelatedContactsFromLinkedInAPI(
      String profileEmail, String contactType) {
    // Here would be a POST request to one of the LinkedIn API endpoints.
    // Instead, we emulates long network connection, which you would expect
    // in the real life.
    print("-> simulate Network Latency...");
    print(
      "LinkedIn: Loading '$contactType' list of '$profileEmail' over the network...",
    );

    // ...and return test data.
    Profile? profile = _findContact(profileEmail);
    if (profile != null) {
      return profile.getContacts(contactType);
    }
    return [];
  }

  Profile? _findContact(String profileEmail) {
    for (Profile profile in _contacts) {
      if (profile.email.contains(profileEmail)) {
        return profile;
      }
    }
    return null;
  }

  @override
  ProfileIterator createFriendsIterator(String profileEmail) {
    return LinkedInIterator(this, "friends", profileEmail);
  }

  @override
  ProfileIterator createCoworkersIterator(String profileEmail) {
    return LinkedInIterator(this, "coworkers", profileEmail);
  }
}
