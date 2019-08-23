import 'package:json_annotation/json_annotation.dart';
import 'base_code.dart';
part 'reasonForNotIssuingResult.g.dart';


@JsonSerializable()
class ReasonForNotIssuingResult extends BaseCode {
  ReasonForNotIssuingResult(int id, String name, String code) {
    this.id = id;
    this.name = name;
    this.code = code;
  }

  factory ReasonForNotIssuingResult.fromJson(Map<String,dynamic> json) => _$ReasonForNotIssuingResultFromJson(json);

  Map<String,dynamic> toJson() => _$ReasonForNotIssuingResultToJson(this);

  static mapFromJson(List dynamicList){
    List<ReasonForNotIssuingResult> reasonForNotIssuingResultList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        ReasonForNotIssuingResult reasonForNotIssuingResult= ReasonForNotIssuingResult.fromJson(e);
        reasonForNotIssuingResultList.add(reasonForNotIssuingResult);
      });
    }
    return reasonForNotIssuingResultList;
  }
}