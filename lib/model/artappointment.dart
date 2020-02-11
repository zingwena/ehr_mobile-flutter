
import 'package:ehr_mobile/model/base_code.dart';
import 'package:ehr_mobile/model/namecode.dart';
import 'package:ehr_mobile/model/reason.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'appointmentoutcome.dart';
import 'followupreason.dart';
part 'artappointment.g.dart';
@JsonSerializable()
@CustomDateTimeConverter()
class ArtAppointment {
  String id;
  String artId;
  String reason;
  DateTime date;

  ArtAppointment(String id, String artId, String reason, DateTime date  ){

     this.id = id;
      this.artId = artId;
      this.reason = reason;
      this.date = date;


  }
  factory ArtAppointment.fromJson(Map<String,dynamic> json) => _$ArtAppointmentFromJson(json);

  Map<String,dynamic> toJson() => _$ArtAppointmentToJson(this);


  @override
  String toString() {
    return 'ArtAppointment{artId: $artId, reason: $reason}, date: $date,  ';
  }

  static mapFromJson(List dynamicList){
    List<ArtAppointment> artappointmentList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        ArtAppointment artAppointment= ArtAppointment.fromJson(e);
        artappointmentList.add(artAppointment);
      });
    }
    return artappointmentList;
  }



}

