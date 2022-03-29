// the CoffeeSelection is
enum CoffeeSelection { FILTER_COFFEE, ESPRESSO, CAPPUCCINO }

class CoffeeException implements Exception {
  final String _message;
  const CoffeeException(String message) : _message = message;

  @override
  String toString() => _message;
}

// the CoffeeMachine class hides all the details of the brewing process.
// That makes it easy to use and allows each developer to focus on a specific class.
class CoffeeMachine {
  final Map<CoffeeSelection, CoffeeBean> _beans;
  static const Map<CoffeeSelection, Configuration> _configMap =
      <CoffeeSelection, Configuration>{
    CoffeeSelection.ESPRESSO: const Configuration(8, 28),
    CoffeeSelection.FILTER_COFFEE: const Configuration(30, 480),
  };
  final GrinderUnit _grinderUnit = const GrinderUnit();
  final BrewingUnit _brewingUnit = const BrewingUnit();

  const CoffeeMachine(Map<CoffeeSelection, CoffeeBean> beans)
      : this._beans = beans;

  Coffee brewCoffee(CoffeeSelection selection) {
    try {
      switch (selection) {
        case CoffeeSelection.FILTER_COFFEE:
          return _brewFilterCoffee();
        case CoffeeSelection.ESPRESSO:
          return _brewEspresso();
        default:
          throw CoffeeException(
              "CoffeeSelection [${selection.toString()}] not supported!");
      }
    } catch (e) {
      throw CoffeeException;
    }
  }

  Coffee _brewFilterCoffee() {
    Configuration config = _configMap[CoffeeSelection.FILTER_COFFEE]!;

    // grind the coffee beans
    GroundCoffee groundCoffee = _grinderUnit.grind(
        _beans[CoffeeSelection.FILTER_COFFEE]!, config.getQuantityCoffee);

    // brew a filter coffee
    return _brewingUnit.brew(
        CoffeeSelection.FILTER_COFFEE, groundCoffee, config.getQuantityWater);
  }

  Coffee _brewEspresso() {
    Configuration config = _configMap[CoffeeSelection.ESPRESSO]!;

    // grind the coffee beans
    GroundCoffee groundCoffee = _grinderUnit.grind(
        _beans[CoffeeSelection.ESPRESSO]!, config.getQuantityCoffee);

    // brew an espresso
    return _brewingUnit.brew(
        CoffeeSelection.ESPRESSO, groundCoffee, config.getQuantityWater);
  }
  // the brewEspresso method when you want to support the CoffeeSelection.CAPPUCCINO.
  // You would then just need to implement the required operations to heat the milk,
  // call the brewEspresso method to get an espresso,
  // and add it to the milk.
}

// the classes CoffeeBean and Coffee are simple POJOs >>
// only store a set of attributes without providing any logic.
class CoffeeBean {
  String _name;
  double _quantity;

  CoffeeBean(String name, double quantity)
      : this._name = name,
        this._quantity = quantity;

  @override
  String toString() => "name: $_name quantity: $_quantity";
  String get getDetails => toString();
}

class Coffee {
  final CoffeeSelection _selection;
  final double _quantity;

  const Coffee(CoffeeSelection selection, double quantity)
      : this._selection = selection,
        this._quantity = quantity;
  @override
  String toString() => "selection: $_selection quantity: $_quantity";
  String get getDetails => toString();
}

class GrinderUnit {
  const GrinderUnit();
  GroundCoffee grind(
    CoffeeBean coffeeBean,
    double quantityCoffee,
  ) =>
      GroundCoffee();
}

class BrewingUnit {
  const BrewingUnit();
  Coffee brew(
    CoffeeSelection selection,
    GroundCoffee groundCoffee,
    double quantity,
  ) =>
      Coffee(selection, quantity);
}

class GroundCoffee {}

class Configuration {
  final double _quantityCoffee;
  final double _quantityWater;

  const Configuration(double quantityCoffee, double quantityWater)
      : this._quantityCoffee = quantityCoffee,
        this._quantityWater = quantityWater;

  double get getQuantityCoffee => _quantityCoffee;
  double get getQuantityWater => _quantityWater;
}

void main() {
  // create a Map of available coffee beans
  Map<CoffeeSelection, CoffeeBean> availableCoffeeBeans =
      Map<CoffeeSelection, CoffeeBean>();
  availableCoffeeBeans[CoffeeSelection.ESPRESSO] =
      CoffeeBean("My favorite espresso bean", 1000);
  availableCoffeeBeans[CoffeeSelection.FILTER_COFFEE] =
      CoffeeBean("My favorite filter coffee bean", 1000);

  // get a CoffeeMachine object
  CoffeeMachine machine = CoffeeMachine(availableCoffeeBeans);

  // brew a fresh coffee
  try {
    Coffee espresso = machine.brewCoffee(CoffeeSelection.ESPRESSO);
    print(espresso.getDetails);
  } on CoffeeException catch (e) {
    print(e.toString());
  }
} // end main
// end CoffeeApp
