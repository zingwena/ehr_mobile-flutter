import 'package:json_annotation/json_annotation.dart';

import 'base_entity.dart';

part 'patient.g.dart';

@JsonSerializable()
class Patient extends BaseEntity{
  Patient(int id, String name){
    this.id = id;
    this.name = name;

  }

  factory Patient.fromJson(Map<String,dynamic> json) => _$PatientFromJson(json);

  Map<String,dynamic> toJson() => _$PatientToJson(this);

}