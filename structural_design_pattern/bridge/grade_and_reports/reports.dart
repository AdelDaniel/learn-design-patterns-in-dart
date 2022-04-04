abstract class Report {
  String showPrimaryGradeReport();
  String showSecondaryGradeReport();
  String showGrade3Report();
}

class HTMLReport implements Report {
  String showPrimaryGradeReport() =>
      "<h1>This is a grade Primary report</h1>\n";
  String showSecondaryGradeReport() =>
      "<h1>This is a grade Secondary report</h1>\n";
  String showGrade3Report() => "<h1>This is a grade 3 report</h1>\n";
}

class PlainTextReport implements Report {
  String showPrimaryGradeReport() => "This is a grade Primary report\n";
  String showSecondaryGradeReport() => "This is a grade Secondary report\n";
  String showGrade3Report() => "This is a grade 3 report\n";
}

class XMLReport implements Report {
  String showPrimaryGradeReport() =>
      "<StudentReport>This is a grade Primary report</StudentReport>\n";
  String showSecondaryGradeReport() =>
      "<StudentReport>This is a grade Secondary report</StudentReport>\n";
  String showGrade3Report() =>
      "<StudentReport>This is a grade 3 report</StudentReport>\n";
}
