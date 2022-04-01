import 'Builders/Builder.dart';
import 'Types/Computer.dart';

class Director {
  Builder _builder;
  Director(Builder builder) : _builder = builder;
  changeBuilder(Builder builder) => _builder = builder;
  Computer makeComputer() => _builder.computer;
}
