import 'package:json_annotation/json_annotation.dart';
import 'package:ehr_mobile/model/address.dart';
import 'package:ehr_mobile/model/education_level.dart';
import 'package:ehr_mobile/model/marital_status.dart';
import 'package:ehr_mobile/model/occupation.dart';
import 'package:ehr_mobile/model/religion.dart';

import 'package:intl/intl.dart';
part 'patient.g.dart';

@JsonSerializable()
class Patient {
  int id;

  String firstName;
  String lastName;
  String sex;
  String nationalId;


  int age;

  String selfIdentifiedGender;
  String religion;
  String occupation;
  String maritalStatus;
  String educationLevel;
  String nationality;
  String countryOfBirth;


  Address address;

  Patient.basic(this.firstName, this.lastName,this.sex,this.nationalId,this.religion,this.maritalStatus,this.educationLevel, this.nationality, this.countryOfBirth, this.selfIdentifiedGender, this.occupation);

  Patient(this.id, this.firstName, this.lastName, this.sex, this.nationalId,this.age, this.selfIdentifiedGender, this.religion,
      this.occupation, this.maritalStatus, this.educationLevel, this.address);

  factory Patient.fromJson(Map<String, dynamic> json) => _$PatientFromJson(json);


  Map<String, dynamic> toJson() => _$PatientToJson(this);


  @override
  String toString() {
    return 'Patient{id: $id, firstName: $firstName, lastName: $lastName, sex: $sex, nationalId: $nationalId,  age: $age, selfIdentifiedGender: $selfIdentifiedGender, religion: $religion, occupation: $occupation, maritalStatus: $maritalStatus, educationLevel: $educationLevel, address: $address}';
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
