
import 'base_code.dart';
class Country extends BaseCode{
  int id;
  String code;
  String name;

  Country.fromJson(Map<String, dynamic>  json):
      id=json['id'],
      code=json['code'],
      name=json['name'];

  Country(this.id, this.code, this.name);

  @override
  String toString() {
    return 'Country{id: $id, code: $code, name: $name}';
  }

  static mapFromJson(List dynamicList){
    List<Country> countryList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        Country country= Country.fromJson(e);
        countryList.add(country);

      });
    }
    return countryList;
  }


}