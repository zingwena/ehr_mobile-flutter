
import 'package:ehr_mobile/model/base_code.dart';
import 'package:ehr_mobile/model/namecode.dart';
import 'package:ehr_mobile/model/reason.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'appointmentoutcome.dart';
import 'followupreason.dart';
part 'artoi.g.dart';
@JsonSerializable()
@CustomDateTimeConverter()
class ArtOi{
  String id;
  String artId;
  DateTime date;
  NameCode oi;

  ArtOi(String id, String artId, DateTime date, NameCode oi){

    this.id = id;
    this.artId = artId;
    this.date = date;
    this.oi = oi;
  }

  factory ArtOi.fromJson(Map<String,dynamic> json) => _$ArtOiFromJson(json);


  @override
  String toString() {
    return 'ArtOi{id: $id, artId: $artId, date: $date, oi:$oi}';
  }

  Map<String,dynamic> toJson() => _$ArtOiToJson(this);

  static mapFromJson(List dynamicList){
    List<ArtOi> artoiList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        ArtOi artOi= ArtOi.fromJson(e);
        artoiList.add(artOi);
      });
    }
    return artoiList;
  }



}

