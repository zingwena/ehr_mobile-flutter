import 'package:json_annotation/json_annotation.dart';
import 'package:ehr_mobile/model/address.dart';
import 'package:ehr_mobile/model/education_level.dart';
import 'package:ehr_mobile/model/marital_status.dart';
import 'package:ehr_mobile/model/occupation.dart';
import 'package:ehr_mobile/model/religion.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';

import 'package:intl/intl.dart';
part 'patient.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class Patient {
  int id;

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


  Patient.basic(this.firstName, this.lastName,this.sex,this.nationalId,this.birthDate,this.religionId,this.maritalStatusId,this.educationLevelId, this.nationalityId, this.countryId, this.selfIdentifiedGender, this.occupationId);

  Patient(this.id, this.firstName, this.lastName, this.sex, this.nationalId,this.birthDate, this.selfIdentifiedGender, this.religionId,
      this.occupationId, this.maritalStatusId, this.educationLevelId, this.address);

  factory Patient.fromJson(Map<String, dynamic> json) => _$PatientFromJson(json);


  Map<String, dynamic> toJson() => _$PatientToJson(this);


  @override
  String toString() {
    return 'Patient{id: $id, firstName: $firstName, lastName: $lastName, sex: $sex, nationalId: $nationalId, birthDate: $birthDate, selfIdentifiedGender: $selfIdentifiedGender, religionId: $religionId, occupationId: $occupationId, maritalStatusId: $maritalStatusId, educationLevelId: $educationLevelId, nationalityId: $nationalityId, countryId: $countryId, address: $address}';
  }

  static List<Patient> fromJsonDecodedMap(List dynamicList) {
    List<Patient> patientList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        Patient patient = Patient.fromJson(e);
        patientList.add(patient);
      });
    }


    return patientList;
  }

}
