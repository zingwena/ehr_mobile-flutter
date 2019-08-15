import 'package:json_annotation/json_annotation.dart';

import 'base_entity.dart';

part 'patient.g.dart';


@JsonSerializable(explicitToJson: true)
class Patient extends BaseEntity{

  String email;


  Patient(int id,String name,this.email) {
    this.id = id;
    this.name = name;
  }

  factory Patient.fromJson(Map<String,dynamic> json) => _$PatientFromJson(json);


  Map<String, dynamic> toJson() => _$PatientToJson(this);

  static mapFromJson(List dynamicList){
    List<Patient> patientList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        Patient patient = Patient.fromJson(e);
        patientList.add(patient);
      });
    }
    return patientList;
  }
}