
import 'package:ehr_mobile/db/tables/base_table.dart';
import 'package:ehr_mobile/db/tables/phone_number_table.dart';
import 'package:ehr_mobile/model/address.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';
@JsonSerializable(explicitToJson: true)
class PersonTable extends BaseTable{

  String selfIdentifiedGender;
  String sex;
  String firstName;
  String lastName;
  String nationalId;
  String religionId;
  String occupationId;
  String maritalStatusId;
  String educationLevelId;
  DateTime birthDate;
  String nationalityId;
  String countryId;

  String countryOfBirthId;
  Address address;
  PhoneNumberTable phoneNumberTable;

  static PersonTable fromJson(Map map) {
    var person = PersonTable();

    person.id = map['id'];
    person.status=map['status'];
    person.sex=map['sex'];
    person.selfIdentifiedGender=map['selfIdentifiedGender'];
    person.firstName = map['firstName'];
    person.lastName=map['lastName'];
    person.nationalId=map['nationalId'];

    person.religionId = map['religionId'];
    person.occupationId=map['occupationId'];
    person.maritalStatusId=map['maritalStatusId'];

    person.educationLevelId = map['educationLevelId'];
    person.birthDate=map['birthDate'];
    person.nationalityId=map['nationalityId'];

    person.countryId = map['countryId'];

    return person;
  }

  Map<String, dynamic> toJson() => {
    'id': id,

    'status': status,
    'sex': sex,
    'selfIdentifiedGender':selfIdentifiedGender,
    'firstName': firstName,

    'lastName': lastName,
    'nationalId': nationalId,
    'religionId': religionId,

    'occupationId': occupationId,
    'maritalStatusId':maritalStatusId,
    'educationLevelId': educationLevelId,

    'birthDate': birthDate,
    'nationalityId': nationalityId,
    'countryId': countryId,
  };

  Map<String, dynamic> toEhrJson() => <String, dynamic>{
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'sex': sex,
    'nationalId': nationalId,
    'birthDate': const CustomDateTimeConverter().toSqlDate(birthDate),
    'selfIdentifiedGender': selfIdentifiedGender,
    'religionId': religionId,
    'occupationId': occupationId,
    'maritalStatusId': maritalStatusId,
    'educationLevelId': educationLevelId,
    'nationalityId': nationalityId,
    'countryOfBirthId': countryOfBirthId,
    'addressDto': address,
    'gender':sex,
    'phoneNumber1':phoneNumberTable.phoneNumber1,
    'phoneNumber2':phoneNumberTable.phoneNumber2,
  };

}