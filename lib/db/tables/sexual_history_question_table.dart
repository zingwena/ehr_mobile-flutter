
import 'package:ehr_mobile/util/response_type_convertor.dart';

import 'base_table.dart';

class SexualHistoryQuestionTable extends BaseTable {

  String sexualHistoryId;
  String responseType;
  String code;
  String name;

  static SexualHistoryQuestionTable fromJson(Map map) {
    var shQn = SexualHistoryQuestionTable();
    shQn.id = map['id'];
    shQn.status=map['status'];
    shQn.sexualHistoryId=map['sexualHistoryId'];
    shQn.responseType= map['responseType'];
    shQn.code = map['code'];
    shQn.name = map['name'];
    return shQn;
  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'status':status,
    'sexualHistoryId':sexualHistoryId,

    'responseType':responseType,
    'code':code,
    'name':name,
  };
}