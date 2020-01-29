
class QuestionCategoryTable{

  int sortOrder;
  String workArea;
  String code;
  String name;

  QuestionCategoryTable fromJson(Map map) {
    var obj = QuestionCategoryTable();
    obj.sortOrder = map['sortOrder'];
    obj.workArea=map['workArea'];
    obj.code=map['code'];
    obj.name=map['name'];
    return obj;
  }

  Map<String, dynamic> toJson() => {
    'sortOrder':sortOrder,
    'workArea':workArea,
    'code':code,
    'name':name,
  };

}