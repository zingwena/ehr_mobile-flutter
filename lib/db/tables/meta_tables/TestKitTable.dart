

class TestKitTable{
  String code;
  String name;
  String description;

  TestKitTable fromJson(Map map) {
    var testKit = TestKitTable();
    testKit.code = map['code'];
    testKit.name=map['name'];
    testKit.description=map['description'];
    return testKit;
  }

  Map<String, dynamic> toJson() => {
    'code':code,
    'name':name,
    'description':description
  };
}