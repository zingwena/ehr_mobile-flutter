
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';
part 'patient.g.dart';

@JsonSerializable()
class Patient {
  int id;

  String firstName;
  String lastName;
  String sex;
  String nationalId;

  DateTime birthDate;
  int age;

  String selfIdentifiedGender;
  String religion;
  String occupation;
  String maritalStatus;
  String educationLevel;

  String schoolHouse;
  String suburbVillage;
  String town;



  Patient.basic(this.nationalId, this.firstName,this.lastName,this.sex,this.birthDate);

  Patient(
      this.firstName,
      this.lastName,
      this.sex,
      this.nationalId,
      this.birthDate,
      this.selfIdentifiedGender,
      this.religion,
      this.occupation,
      this.maritalStatus,
      this.educationLevel);

 factory Patient.fromJson(Map<String, dynamic> json) => _$PatientFromJson(json);


  Map<String, dynamic> toJson() => _$PatientToJson(this);

  @override
  String toString() {
    return 'Patient{id: $id, firstName: $firstName, lastName: $lastName, sex: $sex, nationalId: $nationalId, birthDate: $birthDate,age: $age selfIdentifiedGender: $selfIdentifiedGender, religion: $religion, occupation: $occupation, maritalStatus: $maritalStatus, educationLevel: $educationLevel, schoolHouse: $schoolHouse, suburbVillage: $suburbVillage, town: $town}';
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
