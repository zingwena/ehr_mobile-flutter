
import 'package:ehr_mobile/model/base_code.dart';
import 'package:ehr_mobile/model/namecode.dart';
import 'package:ehr_mobile/model/reason.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'appointmentoutcome.dart';
import 'followupreason.dart';
part 'artsign.g.dart';
@JsonSerializable()
@CustomDateTimeConverter()
class ArtSign{
  String id;
  String artId;
  DateTime date;
  NameCode sign;


  ArtSign(String id, String artId, DateTime date, NameCode sign){

    this.id = id;
    this.artId = artId;
    this.date = date;
    this.sign = sign;
  }

  factory ArtSign.fromJson(Map<String,dynamic> json) => _$ArtSignFromJson(json);

  Map<String,dynamic> toJson() => _$ArtSignToJson(this);

  static mapFromJson(List dynamicList){
    List<ArtSign> artsignList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        ArtSign artsign= ArtSign.fromJson(e);
        artsignList.add(artsign);
      });
    }
    return artsignList;
  }



}

