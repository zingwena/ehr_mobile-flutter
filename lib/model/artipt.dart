
import 'package:ehr_mobile/model/base_code.dart';
import 'package:ehr_mobile/model/namecode.dart';
import 'package:ehr_mobile/model/reason.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'appointmentoutcome.dart';
import 'followupreason.dart';
part 'artipt.g.dart';
@JsonSerializable()
@CustomDateTimeConverter()
class ArtIpt {
  String id;
  String artId;
  String reason;
  DateTime date;
  String iptStatus;

  ArtIpt(String id, String artId, String reason, DateTime date, String iptStatus){

    this.id = id;
    this.artId = artId;
    this.reason = reason;
    this.date = date;
    this.iptStatus = iptStatus;

  }
  factory ArtIpt.fromJson(Map<String,dynamic> json) => _$ArtIptFromJson(json);

  Map<String,dynamic> toJson() => _$ArtIptToJson(this);

  static mapFromJson(List dynamicList){
    List<ArtIpt> artiptList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        ArtIpt artIpt= ArtIpt.fromJson(e);
        artiptList.add(artIpt);
      });
    }
    return artiptList;
  }



}

