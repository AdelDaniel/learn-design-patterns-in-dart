// https://refactoring.guru/design-patterns/state

import 'dart:io';

/// States
///
/// Common interface for all states.
/// States are (LockedState -- ReadyState -- PlayingState)
abstract class State {
  final Player player;

  /// Context passes itself through the state constructor. This may help a
  /// state to fetch some useful context data if needed.
  const State(this.player);

  String onLock();
  String onPlay();
  String onNext();
  String onPrevious();
}

/// Locked State
/// Concrete states provide the special implementation for all interface methods.
class LockedState extends State {
  LockedState(super.player) {
    player.setPlaying(false);
  }

  @override
  String onLock() {
    if (player.isPlaying()) {
      player.changeState(ReadyState(player));
      return "Stop playing";
    } else {
      return "Locked...";
    }
  }

  @override
  String onPlay() {
    player.changeState(ReadyState(player));
    return "Ready";
  }

  @override
  String onNext() {
    return "Locked...";
  }

  @override
  String onPrevious() {
    return "Locked...";
  }
}

/// ReadyState
/// They can also trigger state transitions in the context.
class ReadyState extends State {
  ReadyState(super.player);

  @override
  String onLock() {
    player.changeState(LockedState(player));
    return "Locked...";
  }

  @override
  String onPlay() {
    String action = player.startPlayback();
    player.changeState(PlayingState(player));
    return action;
  }

  @override
  String onNext() {
    return "Locked...";
  }

  @override
  String onPrevious() {
    return "Locked...";
  }
}

/// Playing State
class PlayingState extends State {
  PlayingState(super.player);

  @override
  String onLock() {
    player.changeState(LockedState(player));
    player.setCurrentTrackAfterStop();
    return "Stop playing";
  }

  @override
  String onPlay() {
    player.changeState(ReadyState(player));
    return "Paused...";
  }

  @override
  String onNext() {
    return player.nextTrack();
  }

  @override
  String onPrevious() {
    return player.previousTrack();
  }
}

/// ui Player: Player primary code
/// Context
class Player {
  /// Composite
  late State _state;
  bool _playing = false;
  final List<String> _playlist = [];
  int _currentTrack = 0;

  Player() {
    _state = ReadyState(this);
    setPlaying(true);
    for (int i = 1; i <= 12; i++) {
      _playlist.add("Track $i");
    }
  }

  void changeState(State state) => _state = state;

  void setPlaying(bool playing) => _playing = playing;

  bool isPlaying() => _playing;

  String startPlayback() => "Playing  ${_playlist[_currentTrack]}";
  String onPlay() => _state.onPlay();
  String onLock() => _state.onLock();
  String onNext() => _state.onNext();
  String onPrevious() => _state.onPrevious();

  String nextTrack() {
    _currentTrack++;
    if (_currentTrack > _playlist.length - 1) {
      _currentTrack = 0;
    }
    return "Playing ${_playlist[_currentTrack]}";
  }

  String previousTrack() {
    _currentTrack--;
    if (_currentTrack < 0) {
      _currentTrack = _playlist.length - 1;
    }
    return "Playing ${_playlist[_currentTrack]}";
  }

  void setCurrentTrackAfterStop() => _currentTrack = 0;

  @override
  String toString() =>
      'Player(_state: $_state, _playing: $_playing, _currentTrack: $_currentTrack)';
}

/// Demo. Everything comes together here.
void main() {
  Player player = Player();

  print(player.onPlay());
  print(player.onLock());
  print(player.onNext());
  print(player.onPrevious());
  print(player.onLock());

  while (true) {
    print("\n");
    print("Enter Operation: onPlay: 1 - onLock: 2 - onNext: 3 - onPrevious: 4");
    final String? op = stdin.readLineSync()?.toLowerCase().trim();

    print("Now: The player is $player.");
    if (op?.contains('1') == true) {
      print(player.onPlay());
    } else if (op?.contains('2') == true) {
      print(player.onLock());
    } else if (op?.contains('3') == true) {
      print(player.onNext());
    } else if (op?.contains('4') == true) {
      print(player.onPrevious());
    } else {
      print("Invalid operation. Please try again.");
      break;
    }

    print("\n");
  }
}
