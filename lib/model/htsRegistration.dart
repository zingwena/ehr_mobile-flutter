import 'package:json_annotation/json_annotation.dart';
part 'htsRegistration.g.dart';
@JsonSerializable(explicitToJson: true)
class HtsRegistration {
  int id;
  String htsType;

  HtsRegistration(this.id, this.htsType);




  factory HtsRegistration.fromJson(Map<String, dynamic> json) => _$HtsRegistrationFromJson(json);

  Map<String, dynamic> toJson() => _$HtsRegistrationToJson(this);

  static mapFromJson(List dynamicList) {
    List<HtsRegistration> htsRegistrationList = [];
    if (dynamicList != null) {
      dynamicList.forEach((e) {
        HtsRegistration htsRegistration = HtsRegistration.fromJson(e);
        htsRegistrationList.add(htsRegistration);
      });
    }
    return htsRegistrationList;
  }


}
