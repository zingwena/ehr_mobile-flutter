
import 'package:ehr_mobile/db/tables/base_table.dart';

class ArtReasonTable extends BaseTable{

  String artStatusId;
  String code;
  String name;

  ArtReasonTable fromJson(Map map) {
    var obj = ArtReasonTable();
    obj.artStatusId = map['artStatusId'];
    obj.code=map['code'];
    obj.name=map['name'];
    obj.id=map['id'];
    return obj;
  }

  Map<String, dynamic> toJson() => {
    'artStatusId':artStatusId,
    'code':code,
    'name':name,
    'id':id,
  };

}