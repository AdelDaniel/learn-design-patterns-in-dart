// Logger example
// Below is an example of Chain of Responsibilities pattern
// A logger is created using a chain of loggers, each one configured with different log levels.

enum LogLevel {
  INFO,
  DEBUG,
  WARNING,
  ERROR,
  FUNCTIONAL_MESSAGE,
  FUNCTIONAL_ERROR,
  All
}

abstract class LoggerHandler {
  LogLevel logMask;
  LoggerHandler(this.logMask);

  LoggerHandler? next = null;
  LoggerHandler setNext(LoggerHandler nextLogger) {
    LoggerHandler lastLogger = this;
    while (lastLogger.next != null) {
      lastLogger = lastLogger.next!;
    }
    lastLogger.next = nextLogger;
    return this;
  }

  LoggerHandler message(String msg, LogLevel severity) {
    writeMessage(msg);
    if (next != null) {
      next!.message(msg, severity);
    }
    return this;
  }

  void writeMessage(String msg);
}

class ConsoleLogger extends LoggerHandler {
  ConsoleLogger(LogLevel logMask) : super(logMask);
  @override
  void writeMessage(String msg) => print("Writing to console: $msg");
}

class EmailLogger extends LoggerHandler {
  EmailLogger(LogLevel logMask) : super(logMask);
  @override
  void writeMessage(String msg) => print("Sending via email: $msg");
}

class FileLogger extends LoggerHandler {
  FileLogger(LogLevel logMask) : super(logMask);
  @override
  void writeMessage(String msg) => print("Writing to a file log: $msg");
}

void main(List<String> args) {
  // Build the chain of responsibility
  LoggerHandler logger = ConsoleLogger(LogLevel.All)
      .setNext(EmailLogger(LogLevel.FUNCTIONAL_MESSAGE))
      .setNext(FileLogger(LogLevel.WARNING));

  // Handled by ConsoleLogger since the console has a loglevel of all
  print("---------------------------------------------");
  logger.message("Entering function ProcessOrder().", LogLevel.DEBUG);
  print("---------------------------------------------");
  logger.message("Order record retrieved.", LogLevel.INFO);

  // Handled by ConsoleLogger and FileLogger since filelogger implements Warning & Error
  print("---------------------------------------------");
  logger.message(
      "Customer Address details missing in Branch DataBase.", LogLevel.WARNING);
  print("---------------------------------------------");
  logger.message("Customer Address details missing in Organization DataBase.",
      LogLevel.ERROR);

  // Handled by ConsoleLogger and EmailLogger as it implements functional error
  print("---------------------------------------------");
  logger.message("Unable to Process Order ORD1 Dated D1 For Customer C1.",
      LogLevel.FUNCTIONAL_ERROR);

  // Handled by ConsoleLogger and EmailLogger
  print("---------------------------------------------");
  logger.message("Order Dispatched.", LogLevel.FUNCTIONAL_MESSAGE);
}


/* Output
Writing to console: Entering function ProcessOrder().
Writing to console: Order record retrieved.
Writing to console: Customer Address details missing in Branch DataBase.
Writing to a log file: Customer Address details missing in Branch DataBase.
Writing to console: Customer Address details missing in Organization DataBase.
Writing to a log file: Customer Address details missing in Organization DataBase.
Writing to console: Unable to Process Order ORD1 Dated D1 For Customer C1.
Sending via email: Unable to Process Order ORD1 Dated D1 For Customer C1.
Writing to console: Order Dispatched.
Sending via email: Order Dispatched.
*/