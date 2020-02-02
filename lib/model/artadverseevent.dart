
import 'package:ehr_mobile/model/base_code.dart';
import 'package:ehr_mobile/model/namecode.dart';
import 'package:ehr_mobile/model/reason.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'appointmentoutcome.dart';
import 'followupreason.dart';
part 'artadverseevent.g.dart';
@JsonSerializable()
@CustomDateTimeConverter()
class ArtAdverseEvent{
  String id;
  String statusId;
  String code;
  String name;
  NameCode reason;

  ArtAdverseEvent(String id, String statusId, String code, String name, NameCode reason){
    this.id = id;
    this.statusId = statusId;
    this.code = code;
    this.name = name;
    this.reason = reason;

  }

  factory ArtAdverseEvent.fromJson(Map<String,dynamic> json) => _$ArtAdverseEventFromJson(json);

  Map<String,dynamic> toJson() => _$ArtAdverseEventToJson(this);

  static mapFromJson(List dynamicList){
    List<ArtAdverseEvent> artadverseList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        ArtAdverseEvent artAdverseEvent= ArtAdverseEvent.fromJson(e);
        artadverseList.add(artAdverseEvent);
      });
    }
    return artadverseList;
  }



}

