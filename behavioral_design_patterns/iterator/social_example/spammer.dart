import 'profile.dart';
import 'profile_iterator.dart';
import 'social_network_collection.dart';

/// spammer
/// Message sending app
/// Here is another useful trick: you can pass an iterator to a
/// client class instead of giving it access to a whole collection.
/// This way, you don't expose the collection to the client.
///
/// And there's another benefit:
/// you can change the way the client works with the collection at runtime by passing it a
/// different iterator.
/// This is possible because the client code isn't coupled to concrete iterator classes.

class SocialSpammer {
  SocialNetwork network;
  ProfileIterator? iterator;
  SocialSpammer(this.network);

  void sendSpamToFriends(String profileEmail, String message) {
    print("\nIterating over friends...\n");
    iterator = network.createFriendsIterator(profileEmail);
    while (iterator!.hasNext()) {
      Profile? profile = iterator!.getNext();
      sendMessage(profile?.email, message);
    }
  }

  void sendSpamToCoworkers(String profileEmail, String message) {
    print("\nIterating over coworkers...\n");
    iterator = network.createCoworkersIterator(profileEmail);
    while (iterator!.hasNext()) {
      Profile? profile = iterator!.getNext();
      sendMessage(profile?.email, message);
    }
  }

  void sendMessage(String? email, String message) {
    print("Sent message to: '$email'. Message body: '$message'");
  }
}
