import 'profile.dart';
import 'social_network_collection.dart';

/// Iterator
///
/// Defines profile interface
abstract interface class ProfileIterator {
  bool hasNext();
  Profile? getNext();
  void reset();
}

/// Implements iteration
///
/// Implements iteration over Facebook profiles
class FacebookIterator implements ProfileIterator {
  /// The iterator needs a reference to the collection that it traverses.
  final Facebook _facebook;
  final String _type;
  final String _email;
  int _currentPosition = 0;
  final List<String> _emails = [];
  final List<Profile?> _profiles = [];

  FacebookIterator(Facebook facebook, String type, String email)
      : _facebook = facebook,
        _type = type,
        _email = email;

  void _lazyLoad() {
    if (_emails.isEmpty) {
      List<String> profiles = _facebook.requestProfileFriendsFromFacebook(
        _email,
        _type,
      );
      for (String profile in profiles) {
        _emails.add(profile);
        _profiles.add(null);
      }
    }
  }

  @override
  bool hasNext() {
    _lazyLoad();
    return _currentPosition < _emails.length;
  }

  @override
  Profile? getNext() {
    if (!hasNext()) {
      return null;
    }

    String friendEmail = _emails[_currentPosition];
    Profile? friendProfile = _profiles[_currentPosition];
    if (friendProfile == null) {
      friendProfile = _facebook.requestProfileFromFacebook(friendEmail);
      _profiles[_currentPosition] = friendProfile;
    }
    _currentPosition++;
    return friendProfile;
  }

  @override
  void reset() => _currentPosition = 0;
}

/// Implements iteration
///
/// Implements iteration over LinkedIn profiles
class LinkedInIterator implements ProfileIterator {
  final LinkedIn _linkedIn;
  final String _type;
  final String _email;
  int _currentPosition = 0;
  final List<String> _emails = [];
  final List<Profile?> _contacts = [];

  LinkedInIterator(LinkedIn linkedIn, String type, String email)
      : _linkedIn = linkedIn,
        _type = type,
        _email = email;

  void _lazyLoad() {
    if (_emails.isEmpty) {
      List<String> profiles =
          _linkedIn.requestRelatedContactsFromLinkedInAPI(_email, _type);
      for (String profile in profiles) {
        _emails.add(profile);
        _contacts.add(null);
      }
    }
  }

  @override
  bool hasNext() {
    _lazyLoad();
    return _currentPosition < _emails.length;
  }

  @override
  Profile? getNext() {
    if (!hasNext()) {
      return null;
    }

    String friendEmail = _emails[_currentPosition];
    Profile? friendContact = _contacts[_currentPosition];
    if (friendContact == null) {
      friendContact = _linkedIn.requestContactInfoFromLinkedInAPI(friendEmail);
      _contacts[_currentPosition] = friendContact;
    }
    _currentPosition++;
    return friendContact;
  }

  @override
  void reset() => _currentPosition = 0;
}
