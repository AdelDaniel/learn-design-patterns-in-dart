/// The Observers update method is called when the Subject changes
abstract class Observer {
  void update(String name, String s);
}

/// This class extends Observer interface.
class Follower implements Observer {
  String _followerName;

  Follower(this._followerName);

  /// This method will be called to update all followers regarding the
  /// new tweet posted by celebrity.
  @override
  void update(String celebrityName, String tweet) {
    print(_followerName +
        " has received " +
        celebrityName +
        "'s tweet :: " +
        tweet);
  }

  @override
  String toString() {
    return _followerName;
  }
}
