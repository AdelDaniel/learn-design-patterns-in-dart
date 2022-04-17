// In this pattern,
// normally each receiver contains reference to another receiver.
// If one object cannot handle the request
// then it passes the same to the next receiver and so on.

// Implementation
// We have created an abstract class AbstractLogger with a level of logging.
// Then we have created three types of loggers extending the AbstractLogger.
// Each logger checks the level of message to its level and print accordingly
// otherwise does not print and pass the message to its next logger.

enum LogLevel { INFO, DEBUG, ERROR }

// Step 1
// Create an abstract logger class.
abstract class AbstractLogger {
  LogLevel logLevel;
  AbstractLogger({required this.logLevel});

  //next element in chain or responsibility
  AbstractLogger? nextLogger;
  void setNextLogger(AbstractLogger nextLogger) => this.nextLogger = nextLogger;

  void logMessage(LogLevel level, String message) {
    if (this.logLevel.index <= level.index) {
      write(message);
    }
    if (nextLogger != null) {
      nextLogger!.logMessage(level, message);
    }
  }

  void write(String message);
}

// Step 2
// Create concrete classes extending the logger.
class ConsoleLogger extends AbstractLogger {
  ConsoleLogger(LogLevel level) : super(logLevel: level);
  @override
  void write(String message) => print("Standard Console::Logger: $message");
}

class ErrorLogger extends AbstractLogger {
  ErrorLogger(LogLevel level) : super(logLevel: level);
  @override
  void write(String message) => print("Error Console::Logger: $message");
}

class FileLogger extends AbstractLogger {
  FileLogger(LogLevel level) : super(logLevel: level);
  @override
  void write(String message) => print("File::Logger: $message");
}

// Step 3
// Create different types of loggers.
// Assign them error levels and set next logger in each logger.
// Next logger in each logger represents the part of the chain.
class ChainPatternDemo {
  static AbstractLogger getChainOfLoggers() {
    AbstractLogger errorLogger = ErrorLogger(LogLevel.ERROR);
    AbstractLogger fileLogger = FileLogger(LogLevel.DEBUG);
    AbstractLogger consoleLogger = ConsoleLogger(LogLevel.INFO);

    errorLogger.setNextLogger(fileLogger);
    fileLogger.setNextLogger(consoleLogger);

    return errorLogger;
  }
}

void main(args) {
  AbstractLogger loggerChain = ChainPatternDemo.getChainOfLoggers();
  print("------------------------------------");
  loggerChain.logMessage(LogLevel.INFO, "This is an information.");
  print("------------------------------------");
  loggerChain.logMessage(LogLevel.DEBUG, "This is an debug level information.");
  print("------------------------------------");
  loggerChain.logMessage(LogLevel.ERROR, "This is an error information.");
}

// ------------------------------------
// Standard Console::Logger: This is an information.
// ------------------------------------
// File::Logger: This is an debug level information.
// Standard Console::Logger: This is an debug level information.
// ------------------------------------
// Error Console::Logger: This is an error information.
// File::Logger: This is an error information.
// Standard Console::Logger: This is an error information.