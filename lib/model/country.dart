
import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';

part 'country.g.dart';

@JsonSerializable()
class Country extends BaseCode{

  Country(String name,String code){
    this.name = name;
    this.code = code;
  }

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);

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