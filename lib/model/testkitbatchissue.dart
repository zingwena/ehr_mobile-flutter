
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'batch.dart';
import 'bintype_id_name.dart';
part 'testkitbatchissue.g.dart';
@JsonSerializable(explicitToJson: true)
@CustomDateTimeConverter()
class TestKitBatchIssue {
  String id;
  double remaining;
  bool statusAccepted;
  bool expiredStatus;
  Batch batch;
  BinTypeIdName detail;
  double quantity;
  DateTime date;

  TestKitBatchIssue(this.id, this.remaining, this.statusAccepted,
      this.expiredStatus, this.batch, this.detail, this.quantity, this.date);

  factory TestKitBatchIssue.fromJson(Map<String, dynamic> json) => _$TestKitBatchIssueFromJson(json);


  Map<String, dynamic> toJson() => _$TestKitBatchIssueToJson(this);

  static mapFromJson(List dynamicList){
    List<TestKitBatchIssue> testkitBatchList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        TestKitBatchIssue testKitBatchIssue= TestKitBatchIssue.fromJson(e);
        testkitBatchList.add(testKitBatchIssue);
      });
    }
    return testkitBatchList;
  }



  @override
  String toString() {
    return 'TestKitBatchIssue{id: $id, remaining: $remaining, statusAccepted: $statusAccepted, expiredStatus: $expiredStatus, batch: $batch, detail: $detail, quantity: $quantity, date: $date}';
  }

  List<TestKitBatchIssue> fromJsonDecodedMap(List dynamicList) {
    List<TestKitBatchIssue> testKitBatchIssueList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        TestKitBatchIssue testKitBatchIssue = TestKitBatchIssue.fromJson(e);
        testKitBatchIssueList.add(testKitBatchIssue);
      });
    }
    return testKitBatchIssueList;
  }



}