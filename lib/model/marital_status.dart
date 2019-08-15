import 'package:json_annotation/json_annotation.dart';
import 'base_code.dart';

part 'marital_status.g.dart';

@JsonSerializable()
class MaritalStatus extends BaseCode{
  MaritalStatus(int id,String name,String code){
    this.id = id;
    this.name = name;
    this.code = code;
  }

  factory MaritalStatus.fromJson(Map<String, dynamic> json) => _$MaritalStatusFromJson(json);

  Map<String, dynamic> toJson() => _$MaritalStatusToJson(this);

}