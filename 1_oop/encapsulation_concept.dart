import 'dart:developer';

// The client program only knows about the Car and the functions that the Car provides.
// The internal implementation details are hidden from the client program.

abstract class ICar {
  void turnOnCar();
  void turnOffCar();
  String getCarType();
}

// implementation classes of Car.
class ManualCar implements ICar {
  String _carType = "Manual";

  @override
  String getCarType() => _carType;

  @override
  void turnOffCar() => log("turn off the manual car");

  @override
  void turnOnCar() => log("turn on the manual car");
}

class AutomaticCar implements ICar {
  String _carType = "Automatic";

  @override
  String getCarType() => _carType;

  @override
  void turnOffCar() => log("turn off the automatic car");

  @override
  void turnOnCar() => log("turn on the automatic car");
}
// User Program: Let’s look at a test program
// where the Car functions will be used.

void main() {
  ICar car1 = ManualCar();
  ICar car2 = AutomaticCar();

  car1.turnOnCar();
  car1.turnOffCar();
  log(car1.getCarType());

  car2.turnOnCar();
  car2.turnOffCar();
  log(car2.getCarType());
}
