import 'package:intl/intl.dart';

extension Formatter on String {
  String formatFigures() {
    int fig = int.tryParse(this) ?? 0;
    if (fig == 0) {
      return '';
    }
    if (fig < 1000) {
      return fig.toString();
    } else if (fig < 1000000) {
      double result = fig / 1000.0;
      return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}k';
    } else {
      double result = fig / 1000000.0;
      return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}M';
    }
  }

  String formatComma() {
    num fig = num.tryParse(this) ?? 0;
    if (fig == 0) {
      return '0';
    }
    var formatter = NumberFormat('#,###');
    return formatter.format(fig);
  }
}
