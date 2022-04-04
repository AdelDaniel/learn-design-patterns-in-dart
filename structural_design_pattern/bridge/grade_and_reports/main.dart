import 'grades.dart';
import 'reports.dart';

void main() {
  // Show any Report Type You Need
  // here I choosed  Html Report
  Report HtmlReport = HTMLReport();

  // Then inject Report type to what grade you want to show
  // here I choosed  Primary
  Grade primaryGrade = PrimaryGrade(HtmlReport);

  print(primaryGrade.showReport());
}
