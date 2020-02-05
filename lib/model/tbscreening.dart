import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';

part 'tbscreening.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class TbScreening extends BaseCode {

  String visitId;
  bool presumptive;
  String note;
  DateTime time;
  bool fever;
  bool coughing;
  bool weightLoss;
  bool nightSweats;
  bool bmiUnderSeventeen;


  TbScreening(this.visitId, this.presumptive, this.note, this.time, this.fever,
      this.coughing, this.weightLoss, this.nightSweats, this.bmiUnderSeventeen);

  factory TbScreening.fromJson(Map<String, dynamic> json) => _$TbScreeningFromJson(json);

  Map<String, dynamic> toJson() => _$TbScreeningToJson(this);

  @override
  String toString() {
    return 'TbScreening{visitId: $visitId, presumptive: $presumptive, note: $note, time: $time, fever: $fever, coughing : $coughing,'
        'weightloss : $weightLoss, nightsweats: $nightSweats, bmiunderseventeen: $bmiUnderSeventeen}';
  }

  static List<TbScreening> fromJsonDecodedMap(List dynamicList) {
    List<TbScreening> tbscreeningList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        TbScreening tbScreening = TbScreening.fromJson(e);
        tbscreeningList.add(tbScreening);
      });
    }


    return tbscreeningList;
  }

  static mapFromJson(List dynamicList){
    List<TbScreening> resultList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        TbScreening result= TbScreening.fromJson(e);
        resultList.add(result);
      });
    }
    return resultList;
  }

}