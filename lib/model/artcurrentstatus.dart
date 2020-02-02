import 'package:ehr_mobile/model/namecode.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';

part 'artcurrentstatus.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class ArtCurrentStatus  {
  String id;
  DateTime date;
  String artId;
  String state;
  NameCode regimen;
  NameCode reason;
  String regimenType;
  NameCode adverseEventStatus;


  ArtCurrentStatus(String id, DateTime date, String artId, String state, NameCode regimen, NameCode reason,
      String regimenType, NameCode adverseEventStatus ){
    this.id = id;
    this.date = date;
    this.artId = artId;
    this.state = state;
    this.regimen = regimen;
    this.reason = reason;
    this.regimenType = regimenType;
    this.adverseEventStatus = adverseEventStatus;
  }

  factory ArtCurrentStatus.fromJson(Map<String, dynamic> json) => _$ArtCurrentStatusFromJson(json);

  Map<String, dynamic> toJson() => _$ArtCurrentStatusToJson(this);

  @override
  String toString() {
    return 'ArtCurrentStatus{id: $id, date: $date, artId: $artId, state: $state, regimen: $regimen, reason: $reason,'
        ', regimenType: $regimenType, adverseEventStatus: $adverseEventStatus}';
  }

  static List<ArtCurrentStatus> fromJsonDecodedMap(List dynamicList) {
    List<ArtCurrentStatus> statusList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        ArtCurrentStatus status = ArtCurrentStatus.fromJson(e);
        statusList.add(status);
      });
    }
    return statusList;
  }
  static mapFromJson(List dynamicList){
    List<ArtCurrentStatus> statusList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        ArtCurrentStatus status= ArtCurrentStatus.fromJson(e);
        statusList.add(status);
      });
    }
    return statusList;
  }

}