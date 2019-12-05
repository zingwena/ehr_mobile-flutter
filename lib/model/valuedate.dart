import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'valuedate.g.dart';
@JsonSerializable()
class ValueDate{
  String value;
  DateTime date;

  ValueDate(String value, DateTime date){
    this.value = value;
    this.date = date;
  }

  factory ValueDate.fromJson(Map<String, dynamic> json) =>_$ValueDateFromJson(json);

  Map<String, dynamic> toJson() => _$ValueDateToJson(this);

  static List<ValueDate> mapFromJson(List dynamicList){
    List<ValueDate> list=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        ValueDate valueDate=  ValueDate.fromJson(e);
        list.add(valueDate);
      });
    }
    return list;
  }
  static List<ValueDate> fromJsonDecodedMap(List dynamicList) {
    List<ValueDate> valueDateList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        ValueDate valueDate = ValueDate.fromJson(e);
        valueDateList.add(valueDate);
      });
    }
  }
}