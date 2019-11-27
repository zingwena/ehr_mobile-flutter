import 'package:json_annotation/json_annotation.dart';

import 'package:intl/intl.dart';

class CustomDateTimeConverter implements JsonConverter<DateTime, String> {
  const CustomDateTimeConverter();

  @override
  DateTime fromJson(String json) => DateFormat("MMM d, yyyy HH:mm:ss a").parse(json);


  DateTime fromInt(int time) =>DateTime.fromMillisecondsSinceEpoch(time);

  String toSqlDate(DateTime dateTime){
    var df=DateFormat('yyyy-MM-dd');
    return df.format(dateTime);
  }

  @override
  String toJson(DateTime json) => json.toIso8601String();
}