import 'package:json_annotation/json_annotation.dart';

import 'package:intl/intl.dart';

class CustomDateTimeConverter implements JsonConverter<DateTime, String> {
  const CustomDateTimeConverter();

  @override
  DateTime fromJson(String json) {
    if(json == null){
      print("************************* date is nuuuullll");
      return  DateFormat("MMM d, yyyy HH:mm:ss a").parse("Jan 01, 2020 4:19:38 PM");
    }else {

       return DateFormat("MMM d, yyyy HH:mm:ss a").parse(json);
    }
  }


  DateTime fromInt(int time) =>DateTime.fromMillisecondsSinceEpoch(time);

  String fromIntToSqlDate(int time) {
    if(time!=null){
      return toSqlDate(DateTime.fromMillisecondsSinceEpoch(time));
    }
    return toSqlDate(DateTime.now());
  }

  String toSqlDate(DateTime dateTime){
    var df=DateFormat('yyyy-MM-dd');
    return df.format(dateTime);
  }

  String fromIntToSqlDateTime(int time) {
    if(time!=null){
      return toSqlDateTime(DateTime.fromMillisecondsSinceEpoch(time));
    }
    return toSqlDateTime(DateTime.now());
  }

  String toSqlDateTime(DateTime dateTime){
    var df=DateFormat('yyyy-MM-dd HH:mm');
    return df.format(dateTime);
  }

  @override
  String toJson(DateTime json) => json.toIso8601String();

  int fromEhrJson(String date) {
    if(date==null){
      return null;
    }
    var df=DateFormat('yyyy-MM-dd');
    return df.parse(date).millisecondsSinceEpoch;
  }

  int fromEhrDateTimeJson(String date) {
    var df=DateFormat('yyyy-MM-dd\'T\'HH:mm');
    return df.parse(date).millisecondsSinceEpoch;
  }
}