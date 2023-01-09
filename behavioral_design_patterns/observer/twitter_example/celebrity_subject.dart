import 'followers_observer.dart';

abstract class Subject {
  void register(Observer o);
  void unregister(Observer o);
  void notifyAllObservers(String s);
}

/// This class extends Subject interface.

class Celebrity implements Subject {
  final String _celebrityName; //name of the celebrity
  final List<Observer> _followers = []; //list of followers

  Celebrity(this._celebrityName);

  /// add follower to the celebrity's registered follower list
  @override
  void register(Observer o) {
    _followers.add(o);
    print(o.toString() + " has started following " + _celebrityName);
  }

  /// remove follower from celebrity's registered follower list
  @override
  void unregister(Observer o) {
    _followers.remove(o);
    print(o.toString() + " has stopped following " + _celebrityName);
  }

  /// Notify all the registered followers
  @override
  void notifyAllObservers(String tweet) {
    for (Observer follower in _followers) {
      follower.update(_celebrityName, tweet);
    }
    print("All Notified");
  }

  /// This method updates the tweet.
  /// It will internally call notifyAllObservers(tweet) method
  /// after updating the tweet.
  void tweet(String tweet) {
    print("\n" + _celebrityName + " has tweeted :: " + tweet + "\n");

    notifyAllObservers(tweet);
  }
}
