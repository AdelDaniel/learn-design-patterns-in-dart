class Number {
  int _number;
  Number(int number) : _number = number;
  int get number => _number;
}

abstract class Processor {
  Processor? _nextProcessor;
  Processor nextProcessor(Processor nextProcessor) {
    _nextProcessor = nextProcessor;
    return nextProcessor;
  }

  void process(Number request) {
    if (_nextProcessor != null) _nextProcessor!.process(request);
  }
}

class NegativeProcessor extends Processor {
  void process(Number request) {
    if (request.number < 0) {
      print("NegativeProcessor : ${request.number}");
    }
    super.process(request);
  }
}

class ZeroProcessor extends Processor {
  void process(Number request) {
    if (request.number == 0) {
      print("ZeroProcessor : ${request.number}");
    }
    super.process(request);
  }
}

class PositiveProcessor extends Processor {
  void process(Number request) {
    if (request.number > 0) {
      print("PositiveProcessor : ${request.number}");
    }
    super.process(request);
  }
}

void main() {
  Processor negativeProcessor = NegativeProcessor();
  Processor zeroProcessor = ZeroProcessor();
  Processor positiveProcessor = PositiveProcessor();

  positiveProcessor
      .nextProcessor(zeroProcessor)
      .nextProcessor(negativeProcessor);
  Processor chain = positiveProcessor;
  //Calling chain of responsibility
  chain.process(Number(90));
  chain.process(Number(-50));
  chain.process(Number(0));
  chain.process(Number(91));
}

// Output: 
// PositiveProcessor : 90
// NegativeProcessor : -50
// ZeroProcessor : 0
// PositiveProcessor : 91
 
