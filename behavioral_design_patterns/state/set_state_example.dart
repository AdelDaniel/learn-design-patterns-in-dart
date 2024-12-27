///
///
/// State
abstract class MobileAlertState {
  void alert(AlertStateContext ctx);
}

///  Vibration: Concrete States
class Vibration implements MobileAlertState {
  @override
  void alert(AlertStateContext ctx) => print("Vibration...");
}

///  Silent: Concrete States
class Silent implements MobileAlertState {
  @override
  void alert(AlertStateContext ctx) => print("Silent...");
}

///
///
/// Context
class AlertStateContext {
  MobileAlertState _currentState = Vibration();

  void setState(MobileAlertState state) => _currentState = state;

  void alert() => _currentState.alert(this);
}

///
///
/// Main
void main() {
  AlertStateContext stateContext = AlertStateContext();
  stateContext.alert();
  stateContext.alert();
  stateContext.setState(Silent());
  stateContext.alert();
  stateContext.alert();
  stateContext.alert();
}
