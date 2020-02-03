
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
  NameCode visitType;
  NameCode functionalStatus;
  NameCode visitStatus;
  DateTime ancFirstBookingDate;
  NameCode lactatingStatus;
  NameCode familyPlanningStatus;
  NameCode tbStatus;


  ArtVisit(String id, String artId, String visitId, NameCode visitType, NameCode functionalStatus, NameCode visitStatus,
      DateTime ancFirstBookingDate, NameCode lactatingStatus, NameCode familyPlanningStatus, NameCode tbStatus ){

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

