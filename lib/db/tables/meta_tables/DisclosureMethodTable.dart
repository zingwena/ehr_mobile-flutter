
import 'package:ehr_mobile/db/tables/base_table.dart';

class DisclosureMethodTable extends BaseTable{

  String name;

  DisclosureMethodTable fromJson(Map map) {
    var obj = DisclosureMethodTable();
    obj.name=map['name'];
    obj.id=map['id'];
    return obj;
  }

  Map<String, dynamic> toJson() => {
    'name':name,
    'id':id,
  };

}