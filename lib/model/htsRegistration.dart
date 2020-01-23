import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'htsRegistration.g.dart';
@JsonSerializable(explicitToJson: true)
@CustomDateTimeConverter()
class HtsRegistration {
  String personId;
  String visitId;
  DateTime dateOfHivTest;
  String htsType;
  String entryPointId;
  String laboratoryInvestigationId;

  HtsRegistration(this.personId, this.visitId, this.htsType, this.dateOfHivTest,this.entryPointId, this.laboratoryInvestigationId);

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

  @override
  String toString() {
    return 'HtsRegistration{id: $visitId, dateOfHivTest: $dateOfHivTest, htsType: $htsType, entryPointId: $entryPointId}';
  }


}
