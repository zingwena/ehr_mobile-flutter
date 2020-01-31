

class BaseMeta {

  String code;
  String name;

  BaseMeta fromJson(Map map) {
    var town = BaseMeta();
    town.code = map['code'];
    town.name=map['name'];
    return town;
  }

  Map<String, dynamic> toJson() => {
    'code':code,
    'name':name,
  };
}