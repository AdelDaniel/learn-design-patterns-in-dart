import 'reports.dart';

class PrimaryGrade extends Grade {
  PrimaryGrade(Report report) : super(report);

  @override
  String showReport() => report.showPrimaryGradeReport();
}

class SecondaryGrade extends Grade {
  SecondaryGrade(Report report) : super(report);

  @override
  String showReport() => report.showSecondaryGradeReport();
}

class Grade3Report extends Grade {
  Grade3Report(Report report) : super(report);

  @override
  String showReport() => report.showGrade3Report();
}

abstract class Grade {
  Report report;
  Grade(this.report);
  String showReport();
}
