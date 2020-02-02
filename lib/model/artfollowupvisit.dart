import 'package:ehr_mobile/model/namecode.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';

part 'artfollowupvisit.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class ArtFollowUpVisit  {

  String id;
  String artAppointmentId;
  NameCode outcome;
  DateTime date;

  ArtFollowUpVisit(String id,String artAppointmentId, NameCode outcome, DateTime date){
    this.id = id;
    this.artAppointmentId = artAppointmentId;
    this.outcome = outcome;
    this.date = date;
  }

  factory ArtFollowUpVisit.fromJson(Map<String, dynamic> json) => _$ArtFollowUpVisitFromJson(json);

  Map<String, dynamic> toJson() => _$ArtFollowUpVisitToJson(this);

  @override
  String toString() {
    return 'ArtFollowUpVisit{id: $id, artAppointmentId: $artAppointmentId, outcome: $outcome, date: $date}';
  }

  static List<ArtFollowUpVisit> fromJsonDecodedMap(List dynamicList) {
    List<ArtFollowUpVisit> visitList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        ArtFollowUpVisit artFollowUpvisit = ArtFollowUpVisit.fromJson(e);
        visitList.add(artFollowUpvisit);
      });
    }
    return visitList;
  }
  static mapFromJson(List dynamicList){
    List<ArtFollowUpVisit> visitList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        ArtFollowUpVisit reason= ArtFollowUpVisit.fromJson(e);
        visitList.add(reason);
      });
    }
    return visitList;
  }

}