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

  Future<void> pauseTracking({required Duration duration}) async {
    await _trackingState.pauseTracking(duration: duration);
  }

  void updateState({required TrackingState state}) {
    _trackingState = state;
  }
}

/// Abstract interface State
abstract interface class TrackingState {
  void startTracking();
  void stopTracking();
  Future<void> pauseTracking({required Duration duration});
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
  }

  @override
  void stopTracking() {
    print("EnabledTrackingState: Received 'stop tracking'");
    print("EnabledTrackingState: Changing state to 'disabled'...");
    _tracker?.updateState(state: DisabledTrackingState(tracker: _tracker));
    _tracker?.stopTracking();
  }

  @override
  Future<void> pauseTracking({required Duration duration}) async {
    print(
        "EnabledTrackingState: Received 'pause tracking' for ${duration.inSeconds} seconds");
    print("EnabledTrackingState: Changing state to 'disabled'...");
    _tracker?.updateState(state: DisabledTrackingState(tracker: _tracker));
    await _tracker?.pauseTracking(duration: duration);
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
  Future<void> pauseTracking({required Duration duration}) async {
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
    print("DisabledTrackingState: Stop Do nothing...");
  }
}

void main() async {
  print("Client: I'm starting working with a location tracker");
  final tracker = LocationTracker();

  print("-------- startTracking --------");
  tracker.startTracking();

  print("-------- pauseTracking --------");
  await tracker.pauseTracking(duration: Duration(seconds: 2));

  print("-------- stopTracking --------");
  tracker.stopTracking();
}

// Output: 
// Client: I'm starting working with a location tracker
// -------- startTracking --------
// EnabledTrackingState: startTracking is invoked
// EnabledTrackingState: tracking location....1
// EnabledTrackingState: tracking location....2
// -------- pauseTracking --------
// EnabledTrackingState: Received 'pause tracking' for 2 seconds
// EnabledTrackingState: Changing state to 'disabled'...
// DisabledTrackingState: Pause tracking for 2
// DisabledTrackingState: Time is over
// DisabledTrackingState: Returning to 'enabled state'...

// EnabledTrackingState: startTracking is invoked
// EnabledTrackingState: tracking location....1
// EnabledTrackingState: tracking location....2
// -------- stopTracking --------
// EnabledTrackingState: Received 'stop tracking'
// EnabledTrackingState: Changing state to 'disabled'...
// DisabledTrackingState: Received 'stop tracking'
// DisabledTrackingState: Stop Do nothing...

// Exited.
