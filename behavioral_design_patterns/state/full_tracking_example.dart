/// Context
class LocationTracker {
  /// Location tracking is enabled by default
  /// Composition with the state interface
  late TrackingState _trackingState;
  LocationTracker() {
    _trackingState = EnabledTrackingState(tracker: this);
  }

  void startTracking() {
    _trackingState.startTracking();
  }

  void stopTracking() {
    _trackingState.stopTracking();
  }

  void pauseTracking({required Duration duration}) {
    _trackingState.pauseTracking(duration: duration);
  }

  void makeCheckIn() {
    _trackingState.makeCheckIn();
  }

  void findMyChildren() {
    _trackingState.findMyChildren();
  }

  void updateState({required TrackingState state}) {
    _trackingState = state;
  }
}

/// Abstract interface State
abstract interface class TrackingState {
  void startTracking();
  void stopTracking();
  void pauseTracking({required Duration duration});
  void makeCheckIn();
  void findMyChildren();
}

class EnabledTrackingState implements TrackingState {
  final LocationTracker? _tracker;

  EnabledTrackingState({required LocationTracker? tracker})
      : _tracker = tracker;

  @override
  void startTracking() {
    print("EnabledTrackingState: startTracking is invoked");
    print("EnabledTrackingState: tracking location....1");
    print("EnabledTrackingState: tracking location....2");
    print("EnabledTrackingState: tracking location....3");
  }

  @override
  void stopTracking() {
    print("EnabledTrackingState: Received 'stop tracking'");
    print("EnabledTrackingState: Changing state to 'disabled'...");
    _tracker?.updateState(state: DisabledTrackingState(tracker: _tracker));
    _tracker?.stopTracking();
  }

  @override
  void pauseTracking({required Duration duration}) {
    print(
        "EnabledTrackingState: Received 'pause tracking' for ${duration.inSeconds} seconds");
    print("EnabledTrackingState: Changing state to 'disabled'...");
    _tracker?.updateState(state: DisabledTrackingState(tracker: _tracker));
    _tracker?.pauseTracking(duration: duration);
  }

  @override
  void makeCheckIn() {
    print("EnabledTrackingState: performing check-in at the current location");
  }

  @override
  void findMyChildren() {
    print("EnabledTrackingState: searching for children...");
  }
}

class DisabledTrackingState implements TrackingState {
  final LocationTracker? _tracker;

  DisabledTrackingState({required LocationTracker? tracker})
      : _tracker = tracker;

  @override
  void startTracking() {
    print("DisabledTrackingState: Received 'start tracking'");
    print("DisabledTrackingState: Changing state to 'enabled'...");
    _tracker?.updateState(state: EnabledTrackingState(tracker: _tracker));
  }

  @override
  void pauseTracking({required Duration duration}) async {
    print("DisabledTrackingState: Pause tracking for ${duration.inSeconds}");

    await Future.delayed(duration);

    print("DisabledTrackingState: Time is over");
    print("DisabledTrackingState: Returning to 'enabled state'...\n");
    _tracker?.updateState(state: EnabledTrackingState(tracker: _tracker));
    _tracker?.startTracking();
  }

  @override
  void stopTracking() {
    print("DisabledTrackingState: Received 'stop tracking'");
    print("DisabledTrackingState: Do nothing...");
  }

  @override
  void makeCheckIn() {
    print("DisabledTrackingState: Received 'make check-in'");
    print("DisabledTrackingState: Changing state to 'enabled'...");
    _tracker?.updateState(state: EnabledTrackingState(tracker: _tracker));
    _tracker?.makeCheckIn();
  }

  @override
  void findMyChildren() {
    print("DisabledTrackingState: Received 'find my children'");
    print("DisabledTrackingState: Changing state to 'enabled'...");
    _tracker?.updateState(state: EnabledTrackingState(tracker: _tracker));
    _tracker?.findMyChildren();
  }
}

void main() {
  print("Client: I'm starting working with a location tracker");
  final tracker = LocationTracker();

  print("---------------");
  tracker.startTracking();

  print("---------------");
  tracker.pauseTracking(duration: Duration(seconds: 2));

  print("---------------");
  tracker.makeCheckIn();

  print("---------------");
  tracker.findMyChildren();

  print("---------------");
  tracker.stopTracking();
}

//  Output Execution result
// Client: I'm starting working with a location tracker
// ---------------
// EnabledTrackingState: startTracking is invoked
// EnabledTrackingState: tracking location....1
// EnabledTrackingState: tracking location....2
// EnabledTrackingState: tracking location....3
// ---------------
// EnabledTrackingState: Received 'pause tracking' for 2
// EnabledTrackingState: Changing state to 'disabled'...
// DisabledTrackingState: Pause tracking for 2
// ---------------
// DisabledTrackingState: Received 'make check-in'
// DisabledTrackingState: Changing state to 'enabled'...
// EnabledTrackingState: performing check-in at the current location
// ---------------
// EnabledTrackingState: searching for children...
// ---------------
// EnabledTrackingState: Received 'stop tracking'
// EnabledTrackingState: Changing state to 'disabled'...
// DisabledTrackingState: Received 'stop tracking'
// DisabledTrackingState: Do nothing...
// DisabledTrackingState: Time is over
// DisabledTrackingState: Returning to 'enabled state'...

// EnabledTrackingState: startTracking is invoked
// EnabledTrackingState: tracking location....1
// EnabledTrackingState: tracking location....2
// EnabledTrackingState: tracking location....3

