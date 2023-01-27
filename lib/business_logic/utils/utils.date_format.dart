import 'package:intl/intl.dart' as intl;

class DateFormat {

 static String displayDate(DateTime dateTime) {
    var outputFormat = intl.DateFormat('dd/MM/yyyy');
    return outputFormat.format(dateTime);
  }

  static String displayDateXAxis(DateTime dateTimeToFormat, [DateTime? now]) {

   if(now == null){
     return intl.DateFormat('dd MMM').format(dateTimeToFormat);
   }

    if(dateTimeToFormat.year == now.year){
      return intl.DateFormat('dd MMM').format(dateTimeToFormat).toUpperCase();
    }

   return intl.DateFormat('MMM yyyy').format(dateTimeToFormat);

  }

}