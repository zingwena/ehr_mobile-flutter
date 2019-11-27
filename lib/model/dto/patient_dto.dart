
import 'package:ehr_mobile/model/htsModel.dart';
import 'package:ehr_mobile/model/htsTest.dart';

import '../person.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class PatientDto{
  Person personDto;
  HtsModel htsDto;
  Map<String, dynamic> toJson() => {'personDto': personDto.toEhrJson() };
}