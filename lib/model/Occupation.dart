
class Occupation{
  int id;
  String code;
  String name;

  Occupation.fromJson(Map<String, dynamic> json):
        id=json['id'],
        code=json['code'],
        name=json['name'];

  Occupation(this.id, this.code, this.name);

  static mapFromJson(List dynamicList){
    List<Occupation> occupationList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        Occupation nationality= Occupation.fromJson(e);
        occupationList.add(nationality);
      });
    }
    return occupationList;
  }

  @override
  String toString() {
    return 'Occupation{id: $id, code: $code, name: $name}';
  }

}