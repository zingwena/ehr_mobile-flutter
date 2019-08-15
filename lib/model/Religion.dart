

class Religion{
  int id;
  String code;
  String name;
  Religion.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        code = json['code'],
        name = json['name'];

  Religion(this.id, this.code, this.name);

static List<Religion> mapFromJson(List dynamicList){
  List<Religion> religionList=[];
  if(dynamicList!=null){
    dynamicList.forEach((e){
      Religion religion=  Religion.fromJson(e);
      religionList.add(religion);
    });
  }
  return religionList;
}

  @override
  String toString() {
    return 'Religion{id: $id, code: $code, name: $name}';
  }


}