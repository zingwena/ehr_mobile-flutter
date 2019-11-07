import 'package:json_annotation/json_annotation.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
part 'indextest.g.dart';
@JsonSerializable()
@CustomDateTimeConverter()
class IndexTest{
  String personId;
  DateTime date;

  IndexTest(String personId, DateTime date){
    this.personId = personId;
    this.date = date;
  }

  factory IndexTest.fromJson(Map<String, dynamic> json) => _$IndexTestFromJson(json);

  Map<String, dynamic> toJson() => _$IndexTestToJson(this);

  static mapFromJson(List dynamicList) {
    List<IndexTest> IndexTestList = [];
    if (dynamicList != null) {
      dynamicList.forEach((e) {
        IndexTest indexTest = IndexTest.fromJson(e);
        IndexTestList.add(indexTest);
      });
    }
    return IndexTestList;
  }

  @override
  String toString() {
    return 'IndexTest{personId: $personId, date: $date,}';
  }

}
