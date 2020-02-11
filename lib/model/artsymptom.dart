
import 'package:ehr_mobile/model/base_code.dart';
import 'package:ehr_mobile/model/namecode.dart';
import 'package:ehr_mobile/model/reason.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'appointmentoutcome.dart';
import 'followupreason.dart';
part 'artsymptom.g.dart';
@JsonSerializable()
@CustomDateTimeConverter()
class ArtSymptom{
  String id;
  String artId;
  DateTime date;
  NameCode symptom;



  ArtSymptom(String id, String artId, DateTime date, NameCode symptom){

    this.id = id;
    this.artId = artId;
    this.date = date;
    this.symptom = symptom;
  }

  factory ArtSymptom.fromJson(Map<String,dynamic> json) => _$ArtSymptomFromJson(json);

  @override
  String toString() {
    return 'ArtSymptom{id: $id, artId: $artId, date: $date, symptom:$symptom}';
  }


  Map<String,dynamic> toJson() => _$ArtSymptomToJson(this);

  static mapFromJson(List dynamicList){
    List<ArtSymptom> artsymptomList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        ArtSymptom artsign= ArtSymptom.fromJson(e);
        artsymptomList.add(artsign);
      });
    }
    return artsymptomList;
  }



}

