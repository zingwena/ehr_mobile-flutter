import 'package:ehr_mobile/model/address.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:ehr_mobile/util/custom_convertor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class Person{
  String id;
  String status;
  String firstName;
  String lastName;
  String sex;
  String nationalId;
  DateTime birthDate;
  String selfIdentifiedGender;
  String religionId;
  String occupationId;
  String maritalStatusId;
  String educationLevelId;
  String nationalityId;
  String countryId;
  Address address;

  Person.basic(
      this.firstName,
      this.lastName,
      this.sex,
      this.nationalId,
      this.birthDate,
      this.religionId,
      this.maritalStatusId,
      this.educationLevelId,
      this.nationalityId,
      this.countryId,
      this.selfIdentifiedGender,
      this.occupationId);

  Person(
      this.id,
      this.firstName,
      this.lastName,
      this.sex,
      this.nationalId,
      this.birthDate,
      this.selfIdentifiedGender,
      this.religionId,
      this.occupationId,
      this.maritalStatusId,
      this.educationLevelId,
      this.address);

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  factory Person.fromMap(Map<String, dynamic> map)=>_$PersonFromMap(map);

  Map<String, dynamic> toJson() => _$PersonToJson(this);

  Map<String, dynamic> toEhrJson()=>_$PersonToEhrJson(this);

  @override
  String toString() {
    return 'Person{id: $id, status: $status, firstName: $firstName, lastName: $lastName, sex: $sex, nationalId: $nationalId, birthDate: $birthDate, selfIdentifiedGender: $selfIdentifiedGender, religionId: $religionId, occupationId: $occupationId, maritalStatusId: $maritalStatusId, educationLevelId: $educationLevelId, nationalityId: $nationalityId, countryId: $countryId, address: $address}';
  }

  static List<Person> fromJsonDecodedMap(List dynamicList) {
    List<Person> personList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        Person person = Person.fromJson(e);
        personList.add(person);
      });
    }

    return personList;
  }

  static List<Person> mapFromJson(List dynamicList){
    List<Person> religionList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        Person person=  Person.fromJson(e);
        religionList.add(person);
      });
    }
    return religionList;
  }

//  static Person fromMap(Map map) {
//    var person = Person
//  }
}
