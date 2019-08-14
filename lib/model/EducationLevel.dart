
class EducationLevel{
  int id;
  String code;
  String name;

  EducationLevel.fromJson(Map<String, dynamic> json):
        id=json['id'],
        code=json['code'],
        name=json['name'];

  EducationLevel(this.id, this.code, this.name);

  static mapFromJson(List dynamicList){
    List<EducationLevel> educationLevelList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        EducationLevel nationality= EducationLevel.fromJson(e);
        educationLevelList.add(nationality);
      });
    }
    return educationLevelList;
  }

  @override
  String toString() {
    return 'EducationLevel{id: $id, code: $code, name: $name}';
  }


}