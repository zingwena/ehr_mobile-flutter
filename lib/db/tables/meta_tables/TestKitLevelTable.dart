

class TestKitLevelTable {

  String testKitId;
  String testLevel;

  TestKitLevelTable fromJson(Map map) {
    var testKit = TestKitLevelTable();
    testKit.testKitId = map['testKitId'];
    testKit.testLevel=map['testLevel'];
    return testKit;
  }

  Map<String, dynamic> toJson() => {
    'testKitId':testKitId,
    'testLevel':testLevel,
  };
}