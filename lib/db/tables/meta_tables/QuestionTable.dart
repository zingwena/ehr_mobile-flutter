

class QuestionTable {

  String categoryId;
  String type;
  String code;
  String name;

  QuestionTable fromJson(Map map) {
    var obj = QuestionTable();
    obj.categoryId = map['categoryId'];
    obj.type=map['type'];
    obj.code=map['code'];
    obj.name=map['name'];
    return obj;
  }

  Map<String, dynamic> toJson() => {
    'categoryId':categoryId,
    'type':type,
    'code':code,
    'name':name,
  };

}