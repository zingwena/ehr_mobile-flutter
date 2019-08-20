import 'package:json_annotation/json_annotation.dart';
import 'vitals_base_value.dart';

part 'weight.g.dart';


@JsonSerializable()
class Weight extends VitalsBaseValue {

  Weight();

  factory Weight.fromJson(Map<String,dynamic> json) => _$WeightFromJson(json);

  Map<String,dynamic> toJson() => _$WeightToJson(this);

}
