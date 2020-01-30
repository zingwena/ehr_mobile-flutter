

import '../base_table.dart';

class TestingPlanTable extends BaseTable{

  String name;

  TestingPlanTable fromJson(Map map) {
    var obj = TestingPlanTable();
    obj.name=map['name'];
    obj.id=map['id'];
    return obj;
  }

  Map<String, dynamic> toJson() => {
    'name':name,
    'id':id,
  };

}