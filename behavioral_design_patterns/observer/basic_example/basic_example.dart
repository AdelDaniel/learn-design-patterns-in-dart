import 'dart:math' as math;

abstract class BaseObserver {
  /// Receive update from subject
  void Update(BaseSubject subject);
}

abstract class BaseSubject {
  // Attach an observer to the subject.
  void Attach(BaseObserver observer);

  // Detach an observer from the subject.
  void Detach(BaseObserver observer);

  // Notify all observers about an event.
  void Notify();
}

// The Subject owns some important state and notifies observers when the
// state changes.
class Subject implements BaseSubject {
  // For the sake of simplicity, the Subject's state, essential to all
  // subscribers, is stored in this variable.
  int state = 0;

  // List of subscribers. In real life, the list of subscribers can be
  // stored more comprehensively (categorized by event type, etc.).
  List<BaseObserver> _observers = [];

  // The subscription management methods.
  void Attach(BaseObserver observer) {
    print("Subject: Attached an observer.");
    _observers.add(observer);
  }

  void Detach(BaseObserver observer) {
    _observers.remove(observer);
    print("Subject: Detached an observer.");
  }

  // Trigger an update in each subscriber.
  void Notify() {
    print("Subject: Notifying observers...");

    for (var observer in _observers) {
      observer.Update(this);
    }
  }

  // Usually, the subscription logic is only a fraction of what a Subject
  // can really do. Subjects commonly hold some important business logic,
  // that triggers a notification method whenever something important is
  // about to happen (or after it).
  void SomeBusinessLogic() {
    print("\nSubject: I'm doing something important.");
    state = new math.Random().nextInt(10);

    print("Subject: My state has just changed to: $state");
    Notify();
  }
}

// Concrete Observers react to the updates issued by the Subject they had
// been attached to.
class ConcreteObserverA implements BaseObserver {
  void Update(BaseSubject subject) {
    if (subject is Subject) {
      if (subject.state < 3) {
        print("subject is Subject :: (subject.state  < 3)");
      }
    }
    print("Not Subject OR Not (subject.state  < 3)");
  }
}

class ConcreteObserverB implements BaseObserver {
  void Update(BaseSubject subject) {
    if (subject is Subject) {
      print("ConcreteObserverB: Reacted to the event.");
    }
  }
}

void main() {
  // The client code.
  var subject = new Subject();
  var observerA = new ConcreteObserverA();
  subject.Attach(observerA);

  var observerB = new ConcreteObserverB();
  subject.Attach(observerB);

  subject.SomeBusinessLogic();
  subject.SomeBusinessLogic();

  subject.Detach(observerB);

  subject.SomeBusinessLogic();
}
    

//  Output.txt: Execution result
// Subject: Attached an observer.
// Subject: Attached an observer.

// Subject: I'm doing something important.
// Subject: My state has just changed to: 2
// Subject: Notifying observers...
// ConcreteObserverA: Reacted to the event.
// ConcreteObserverB: Reacted to the event.

// Subject: I'm doing something important.
// Subject: My state has just changed to: 1
// Subject: Notifying observers...
// ConcreteObserverA: Reacted to the event.
// Subject: Detached an observer.

// Subject: I'm doing something important.
// Subject: My state has just changed to: 5
// Subject: Notifying observers...
