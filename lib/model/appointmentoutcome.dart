import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';

part 'appointmentoutcome.g.dart';

@JsonSerializable()
class AppointmentOutcome extends BaseCode {

  AppointmentOutcome(String name,String code){
    this.name = name;
    this.code = code;
  }

  factory AppointmentOutcome.fromJson(Map<String, dynamic> json) => _$AppointmentOutcomeFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentOutcomeToJson(this);

  @override
  String toString() {
    return 'AppointmentOutcome{code: $code, name: $name}';
  }

  static List<AppointmentOutcome> fromJsonDecodedMap(List dynamicList) {
    List<AppointmentOutcome> reasonList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        AppointmentOutcome reason = AppointmentOutcome.fromJson(e);
        reasonList.add(reason);
      });
    }
    return reasonList;
  }
  static mapFromJson(List dynamicList){
    List<AppointmentOutcome> reasonList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        AppointmentOutcome reason= AppointmentOutcome.fromJson(e);
        reasonList.add(reason);
      });
    }
    return reasonList;
  }

}