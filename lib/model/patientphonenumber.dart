import 'package:json_annotation/json_annotation.dart';
//part 'patientphonenumber.g.dart';



@JsonSerializable()
class patientphonenumber{

  int id;
  String personId;
  String phonenumber_1;
  String phonenumber_2;

  patientphonenumber.basic(this.personId, this.phonenumber_1, this.phonenumber_2);
  patientphonenumber(this.id, this.personId, this.phonenumber_1, this.phonenumber_2);


/*
  factory patientphonenumber.fromJson(Map<String, dynamic> json) => _$PatientphonenumberFromJson(json);


  Map<String, dynamic> toJson() => _$patientphonenumberToJson(this);*/


  @override
  String toString() {
    return 'Patientphonenumber{id: $id, personId: $personId, phonenumber_1: $phonenumber_1, phonenumber_2: $phonenumber_2}';
  }

  static List<patientphonenumber> fromJsonDecodedMap(List dynamicList) {
    List<patientphonenumber> PatientphonenumberList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
      /*  patientphonenumber patient_phonenumber = patientphonenumber.fromJson(e);
        PatientphonenumberList.add(patientphonenumber);*/
      });
    }


    return PatientphonenumberList;
  }

}