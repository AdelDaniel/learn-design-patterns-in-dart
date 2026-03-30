// behavioral_design_patterns/mediator/examples/planes.dart
// https://www.geeksforgeeks.org/system-design/mediator-design-pattern/
// Mediator Design Pattern example(with implementation)

// Problem Statement:
// Several airplanes in an airport must coordinate their movements and communicate with one another in order to prevent collisions and guarantee safe takeoffs and landings.
// Direct communication between aircraft without a centralized mechanism could result in chaos and higher risk.

// What can be the challenges while implementing this system?
// Air Traffic Complexity:
//   Direct communication between airplanes might result in complex and error-prone coordination, especially when dealing with multiple aircraft in the same airspace.
// Collision Risks:
//   Without a centralized control mechanism, the risk of collisions between airplanes during takeoffs, landings, or mid-flight maneuvers increases.

// How Mediator Pattern help to solve above challenges?
// By managing the complex coordination and communication between aircraft and air traffic controllers,
// the mediator pattern contributes to a safer and better-organized aviation system.

// Centralized Control: By serving as a mediator, the air traffic control tower helps aircraft communicate with one another.
// This guarantees that every aircraft is aware of the location and intentions of every other aircraft.
//
// Collision Avoidance: The mediator (air traffic control tower) manages the flow of airplanes, preventing collisions by providing clear instructions and coordinating their movements.

// MediatorDesignPatternExample
// Below is the code of above problem statement using Command Pattern:

/// 1. Colleague Interface(Airplane)
/// Colleague Interface
abstract interface class Airplane {
  void requestTakeoff();
  void requestLanding();
  void notifyAirTrafficControl(String message);
}

/// 2. Concrete Colleague Classes (CommercialAirplane && PassengersAirplane)
class CommercialAirplane implements Airplane {
  final AirTrafficControlTower _mediator;

  CommercialAirplane(AirTrafficControlTower mediator) : _mediator = mediator;

  @override
  void requestTakeoff() => _mediator.requestTakeoff(this);

  @override
  void requestLanding() => _mediator.requestLanding(this);

  @override
  void notifyAirTrafficControl(String message) =>
      print("Commercial Airplane: $message");
}

class PassengersAirplane implements Airplane {
  final AirTrafficControlTower _mediator;

  PassengersAirplane(AirTrafficControlTower mediator) : _mediator = mediator;

  @override
  void requestTakeoff() => _mediator.requestTakeoff(this);

  @override
  void requestLanding() => _mediator.requestLanding(this);

  @override
  void notifyAirTrafficControl(String message) =>
      print("Passengers Airplane: $message");
}

/// 3. Mediator Interface(AirTrafficControlTower)
abstract interface class AirTrafficControlTower {
  void requestTakeoff(Airplane airplane);
  void requestLanding(Airplane airplane);
}

/// 4. Concrete Mediator Class(AirportControlTower)
class AirportControlTower implements AirTrafficControlTower {
  // Logic for coordinating takeoff
  @override
  void requestTakeoff(Airplane airplane) {
    airplane.notifyAirTrafficControl("Requesting takeoff clearance.");
  }

  // Logic for coordinating landing
  @override
  void requestLanding(Airplane airplane) {
    airplane.notifyAirTrafficControl("Requesting landing clearance.");
  }
}

// main
void main(args) {
  // Instantiate the Mediator (Airport Control Tower)
  AirTrafficControlTower controlTower = AirportControlTower();

  // Instantiate Concrete Colleagues (Commercial Airplanes)
  Airplane airplane1 = CommercialAirplane(controlTower);
  Airplane airplane2 = CommercialAirplane(controlTower);

  // Set up the association between Concrete Colleagues and the Mediator
  airplane1.requestTakeoff();
  airplane2.requestLanding();

  // Output:
  // Commercial Airplane: Requesting takeoff clearance.
  // Commercial Airplane: Requesting landing clearance.
}

// Commercial Airplane: Requesting takeoff clearance.
// Commercial Airplane: Requesting landing clearance.
