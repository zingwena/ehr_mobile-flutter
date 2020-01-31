
class TestKitBatchIssueTable {
  String id;
  String remaining;
  String statusAccepted;
  String expiredStatus;

  String batch_batchNumber;
  String batch_expiryDate;
  String batch_textKitId;
  String batch_testKitName;

  String detail_binType;
  String detail_name;
  String detail_id;

  String quantity;

  TestKitBatchIssueTable fromJson(Map map) {
    var tbi = TestKitBatchIssueTable();
    tbi.id = map['id'];
    tbi.remaining=map['remaining'];

    tbi.statusAccepted = map['statusAccepted'];
    tbi.expiredStatus=map['expiredStatus'];

    tbi.batch_batchNumber=map['batch_batchNumber'];
    tbi.batch_expiryDate=map['batch_expiryDate'];
    tbi.batch_textKitId=map['batch_textKitId'];
    tbi.batch_testKitName=map['batch_testKitName'];

    tbi.detail_binType=map['detail_binType'];
    tbi.detail_name=map['detail_name'];
    tbi.detail_id=map['detail_id'];

    tbi.quantity=map['quantity'];

    return tbi;
  }

  Map<String, dynamic> toJson() => {
    
  'id':id,
  'remaining':remaining,

  'statusAccepted':statusAccepted,
  'expiredStatus':expiredStatus,

  'batch_batchNumber':batch_batchNumber,
  'batch_expiryDate':batch_expiryDate,
  'batch_textKitId':batch_textKitId,
  'batch_testKitName':batch_testKitName,

  'detail_binType':detail_binType,
  'detail_name':detail_name,
  'detail_id':detail_id,

  'quantity':quantity,
  };
}