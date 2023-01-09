import 'observers.dart';

/// Step 1
/// Create Subject class.
class Subject {
  List<Observer> _observers = [];
  late int _state;

  int get getState => _state;

  void setState(int state) {
    _state = state;
    notifyAllObservers();
  }

  void attach(Observer observer) {
    _observers.add(observer);
  }

  void notifyAllObservers() {
    for (Observer observer in _observers) {
      observer.update();
    }
  }
}
