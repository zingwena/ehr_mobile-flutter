import 'package:json_annotation/json_annotation.dart';

import 'vitals_base_value.dart';

part 'height.g.dart';

@JsonSerializable()
class Height extends VitalsBaseValue {

  Height();

  factory Height.fromJson(Map<String,dynamic> json) => _$HeightFromJson(json);

  Map<String,dynamic> toJson() => _$HeightToJson(this);

}
