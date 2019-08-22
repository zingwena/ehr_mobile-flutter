import 'package:json_annotation/json_annotation.dart';
import 'vitals_base_value.dart';

part 'temperature.g.dart';

@JsonSerializable()
class Temperature extends VitalsBaseValue {

  Temperature();

  factory Temperature.fromJson(Map<String, dynamic> json) => _$TemperatureFromJson(json);

  Map<String,dynamic> toJson() => _$TemperatureToJson(this);

}
