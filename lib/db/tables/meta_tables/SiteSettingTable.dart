
class SiteSettingTable{

  String id;
  String name;


  SiteSettingTable fromJson(Map map) {
    var obj = SiteSettingTable();
    obj.id = map['id'];
    obj.name = map['name'];
    return obj;
  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'name':name,
  };
}