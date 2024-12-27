/// 
/// Step 1: Create an interface.
abstract interface class Strategy {
  int doOperation(int num1, int num2);
}

/// 
/// Step 2: Create concrete classes implementing the same interface.

/// OperationAdd
class OperationAdd implements Strategy {
  @override
  int doOperation(int num1, int num2) => num1 + num2;
}

/// OperationSubtract
class OperationSubtract implements Strategy {
  @override
  int doOperation(int num1, int num2) => num1 - num2;
}

/// OperationMultiply
class OperationMultiply implements Strategy {
  @override
  int doOperation(int num1, int num2) => num1 * num2;
}

///
/// Step 3: Create Context Class.
class Context {
  final Strategy _strategy;

  Context(Strategy strategy) : this._strategy = strategy;

  int executeStrategy(int num1, int num2) {
    return _strategy.doOperation(num1, num2);
  }
}

/// 
/// Step 4: Use the Context to see change in behavior when it changes its Strategy.
void main() {
  Context context = Context(OperationAdd());
  print("10 + 5 = " + "${context.executeStrategy(10, 5)}");

  context = Context(OperationSubtract());
  print("10 - 5 = " + "${context.executeStrategy(10, 5)}");

  context = Context(OperationMultiply());
  print("10 * 5 = " + "${context.executeStrategy(10, 5)}");
}

/// Step 5: Verify the output.
// 10 + 5 = 15
// 10 - 5 = 5
// 10 * 5 = 50
