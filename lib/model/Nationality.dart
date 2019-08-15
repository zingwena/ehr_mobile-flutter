
class Nationality{
  int id;
  String code;
  String name;

  Nationality.fromJson(Map<String, dynamic> json):
      id=json['id'],
      code=json['code'],
      name=json['name'];

  Nationality(this.id, this.code, this.name);

  static mapFromJson(List dynamicList){
    List<Nationality> nationalityList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        Nationality nationality= Nationality.fromJson(e);
        nationalityList.add(nationality);
      });
    }
    return nationalityList;
  }

  @override
  String toString() {
    return 'Nationality{id: $id, code: $code, name: $name}';
  }


}