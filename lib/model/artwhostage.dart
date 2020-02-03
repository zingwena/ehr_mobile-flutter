
import 'package:ehr_mobile/model/base_code.dart';
import 'package:ehr_mobile/model/namecode.dart';
import 'package:ehr_mobile/model/reason.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'appointmentoutcome.dart';
import 'followupreason.dart';
part 'artwhostage.g.dart';
@JsonSerializable()
@CustomDateTimeConverter()
class ArtWhoStage{
  String id;
  String artId;
  DateTime date;
  NameCode followUpStatus;
  String stage;

  ArtWhoStage(String id, String artId, DateTime date, NameCode followUpStatus, String stage){
    this.id = id;
    this.artId = artId;
    this.date = date;
    this.followUpStatus = followUpStatus;
    this.stage = stage;
  }

  factory ArtWhoStage.fromJson(Map<String,dynamic> json) => _$ArtWhoStageFromJson(json);

  Map<String,dynamic> toJson() => _$ArtWhoStageToJson(this);

  static mapFromJson(List dynamicList){
    List<ArtWhoStage> artsignList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        ArtWhoStage artsign= ArtWhoStage.fromJson(e);
        artsignList.add(artsign);
      });
    }
    return artsignList;
  }



}

