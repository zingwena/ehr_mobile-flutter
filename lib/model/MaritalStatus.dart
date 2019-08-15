
class MaritalStatus{
  int id;
  String code;
  String name;

 MaritalStatus.fromJson(Map<String, dynamic> json):
        id=json['id'],
        code=json['code'],
        name=json['name'];

  MaritalStatus(this.id, this.code, this.name);

  static mapFromJson(List dynamicList){
    List<MaritalStatus> maritalStatusList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        MaritalStatus nationality= MaritalStatus.fromJson(e);
        maritalStatusList.add(nationality);
      });
    }
    return maritalStatusList;
  }

  @override
  String toString() {
    return 'MaritalStatus{id: $id, code: $code, name: $name}';
  }

}