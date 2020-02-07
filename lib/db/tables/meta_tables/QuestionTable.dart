

class QuestionTable {

  String categoryId;
  String type;
  String code;
  String name;
  String workArea;

  QuestionTable fromJson(Map map) {
    var obj = QuestionTable();
    obj.categoryId = map['categoryId'];
    obj.type=map['type'];
    obj.code=map['code'];
    obj.name=map['name'];
    obj.workArea=map['workArea'];
    return obj;
  }

  Map<String, dynamic> toJson() => {
    'categoryId':categoryId,
    'type':type,
    'code':code,
    'name':name,
    'workArea':workArea,
  };

}