import 'Builders/Builder.dart';
import 'Builders/ComputerCSBuilder.dart';
import 'Builders/ComputerXLBuilder.dart';
import 'Director.dart';
import 'Types/Computer.dart';

void main() {
  // first create CS computer
  Builder computerCSBuilder = ComputerCSBuilder();
  Director director = Director(computerCSBuilder);
  Computer computer1 = director.makeComputer();
  print(computer1);
  Builder computerXLBuilder = ComputerXLBuilder();
  director.changeBuilder(computerXLBuilder);
  Computer computer2 = director.makeComputer();
  print(computer2);
}
