
import 'package:ehr_mobile/model/response.dart';
import 'package:ehr_mobile/model/result.dart';
import 'package:ehr_mobile/model/testKit.dart';
import 'package:json_annotation/json_annotation.dart';
part 'sexualhistoryview.g.dart';

@JsonSerializable()
class SexualHistoryView{
  String id;
 Response question;

 SexualHistoryView(this.id, this.question);


  factory SexualHistoryView.fromJson(Map<String, dynamic> json) => _$SexualHistoryViewFromJson(json);


  Map<String, dynamic> toJson() => _$SexualHistoryViewToJson(this);

  static mapFromJson(List dynamicList){
    List<SexualHistoryView> sexualhistoryviewList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        SexualHistoryView  sexualHistoryView= SexualHistoryView.fromJson(e);
        sexualhistoryviewList.add(sexualHistoryView);
      });
    }
    return sexualhistoryviewList;
  }

  @override
  String toString() {
    return 'SexualHistoryView{id: $id, question: $question,}';
  }

  List<SexualHistoryView> fromJsonDecodedMap(List dynamicList) {
    List<SexualHistoryView> sexualhistoryList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        SexualHistoryView sexualHistoryView = SexualHistoryView.fromJson(e);
        sexualhistoryList.add(sexualHistoryView);
      });
    }
    return sexualhistoryList;
  }


}