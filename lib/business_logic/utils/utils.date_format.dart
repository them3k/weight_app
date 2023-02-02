import 'package:intl/intl.dart' as intl;

class DateFormat {




 static String displayDate(DateTime dateTime) {

   if(dateTime.year == DateTime.now().year){
      return intl.DateFormat('dd MMM').format(dateTime);
   }

    return intl.DateFormat('dd MMM yyyy').format(dateTime);
  }


 static String ddMMMyyyy(DateTime dateTime) =>
     intl.DateFormat('dd MMM yyyy').format(dateTime);


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