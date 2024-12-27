/// State Interface
abstract interface class VendingMachineState {
  const VendingMachineState();
  void handle();
}

///
/// Concrete States
///
class ReadyState implements VendingMachineState {
  const ReadyState();
  @override
  void handle() => print("ReadyState");
}

class ProductSelectedState implements VendingMachineState {
  const ProductSelectedState();
  @override
  void handle() => print("ProductSelectedState");
}

class PaymentPendingState implements VendingMachineState {
  const PaymentPendingState();
  @override
  void handle() => print("PaymentPendingState");
}

class OutOfStockState implements VendingMachineState {
  const OutOfStockState();
  @override
  void handle() => print("OutOfStockState");
}

///
/// Context
///

class VendingMachineContext {
  VendingMachineState _state;
  VendingMachineContext(this._state);

  void setState(VendingMachineState state) => _state = state;
  void request() => _state.handle();
}

///
/// Main
///
void main(List<String> args) {
  /// init state
  final VendingMachineState readyState = ReadyState();

  /// context with init state
  final VendingMachineContext context = VendingMachineContext(readyState);
  context.request();

  /// change state
  final VendingMachineState productSelectedState = ProductSelectedState();
  context.setState(productSelectedState);
  context.request();
}
