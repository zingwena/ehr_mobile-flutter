import 'package:ehr_mobile/model/namecode.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';

part 'artfollowupcall.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class ArtFollowUpCall  {

  String id;
  String artAppointmentId;
  NameCode outcome;
  DateTime date;
  String followUpType;
  ArtFollowUpCall(String id,String artAppointmentId, NameCode outcome, DateTime date, String followUpType){
    this.id = id;
    this.artAppointmentId = artAppointmentId;
    this.outcome = outcome;
    this.date = date;
    this.followUpType = followUpType;
  }

  factory ArtFollowUpCall.fromJson(Map<String, dynamic> json) => _$ArtFollowUpCallFromJson(json);

  Map<String, dynamic> toJson() => _$ArtFollowUpCallToJson(this);

  @override
  String toString() {
    return 'ArtFollowUpCall{id: $id, artAppointmentId: $artAppointmentId, outcome: $outcome, date: $date}';
  }

  static List<ArtFollowUpCall> fromJsonDecodedMap(List dynamicList) {
    List<ArtFollowUpCall> callList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        ArtFollowUpCall artFollowUpCall = ArtFollowUpCall.fromJson(e);
        callList.add(artFollowUpCall);
      });
    }
    return callList;
  }
  static mapFromJson(List dynamicList){
    List<ArtFollowUpCall> reasonList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        ArtFollowUpCall reason= ArtFollowUpCall.fromJson(e);
        reasonList.add(reason);
      });
    }
    return reasonList;
  }

}