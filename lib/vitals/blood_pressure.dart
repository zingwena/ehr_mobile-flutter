import 'package:json_annotation/json_annotation.dart';

import 'vitals_base_entity_id.dart';

part 'blood_pressure.g.dart';

@JsonSerializable()
class BloodPressure extends VitalsBaseEntityId {
    String systolic;
    String diastolic;

    BloodPressure();

    factory BloodPressure.fromJson(Map<String,dynamic> json) => _$BloodPressureFromJson(json);

    Map<String, dynamic> toJson() => _$BloodPressureToJson(this);


}
