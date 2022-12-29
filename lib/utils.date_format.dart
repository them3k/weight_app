import 'package:intl/intl.dart' as intl;

class DateFormat {

 static String displayDate(DateTime dateTime) {
    var outputFormat = intl.DateFormat('dd/MM/yyyy');
    return outputFormat.format(dateTime);
  }
}