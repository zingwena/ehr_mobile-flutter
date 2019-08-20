import 'package:json_annotation/json_annotation.dart';
import 'vitals_base_value.dart';

part 'pulse.g.dart';
@JsonSerializable()
class Pulse extends VitalsBaseValue {
  Pulse();

  factory Pulse.from(Map<String,dynamic> json) => _$PulseFromJson(json);

  Map<String,dynamic> toJson() => _$PulseToJson(this);


}
