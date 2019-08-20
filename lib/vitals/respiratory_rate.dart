import 'package:json_annotation/json_annotation.dart';
import 'vitals_base_value.dart';

part 'respiratory_rate.g.dart';

@JsonSerializable()
class RespiratoryRate extends VitalsBaseValue {

  RespiratoryRate();

  factory RespiratoryRate.fromJson(Map<String,dynamic> json) => _$RespiratoryRateFromJson(json);

  Map<String,dynamic> toJson() => _$RespiratoryRateToJson(this);
}
