
import 'package:ehr_mobile/model/base_code.dart';
import 'package:ehr_mobile/model/namecode.dart';
import 'package:ehr_mobile/model/reason.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'appointmentoutcome.dart';
import 'followupreason.dart';
part 'artvisit.g.dart';
@JsonSerializable()
@CustomDateTimeConverter()
class ArtVisit{
  String id;
  String artId;
  String visitId;
  String visitType;
  String functionalStatus;
  String visitStatus;
  DateTime ancFirstBookingDate;
  String lactatingStatus;
  String familyPlanningStatus;
  String tbStatus;
  String stage;


  ArtVisit(String id, String artId, String visitId, String visitType, String functionalStatus, String visitStatus,
      DateTime ancFirstBookingDate, String lactatingStatus, String familyPlanningStatus, String tbStatus, stage ){

    this.id = id;
    this.artId = artId;
    this.visitId = visitId;
    this.visitType = visitType;
    this.functionalStatus = functionalStatus;
    this.visitStatus = visitStatus;
    this.ancFirstBookingDate = ancFirstBookingDate;
    this.lactatingStatus = lactatingStatus;
    this.familyPlanningStatus = familyPlanningStatus;
    this.tbStatus = tbStatus;
    this.stage = stage;
  }

  factory ArtVisit.fromJson(Map<String,dynamic> json) => _$ArtVisitFromJson(json);

  Map<String,dynamic> toJson() => _$ArtVisitToJson(this);

  static mapFromJson(List dynamicList){
    List<ArtVisit> artvisitList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        ArtVisit artvisit= ArtVisit.fromJson(e);
        artvisitList.add(artvisit);
      });
    }
    return artvisitList;
  }



}

