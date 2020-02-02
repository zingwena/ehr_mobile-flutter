import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';

part 'medicinename.g.dart';

@JsonSerializable()
class MedicineName  {
  String medicineCategory;
  String medicineLevel;
  bool otc;

  MedicineName(String medicineCategory,String medicineLevel, bool otc){
    this.medicineCategory = medicineCategory;
    this.medicineLevel = medicineLevel;
    this.otc = otc;
  }

  factory MedicineName.fromJson(Map<String, dynamic> json) => _$MedicineNameFromJson(json);

  Map<String, dynamic> toJson() => _$MedicineNameToJson(this);

  @override
  String toString() {
    return 'MedicineName{medicineCategory: $medicineCategory, medicineLevel: $medicineLevel, otc: $otc}';
  }

  static List<MedicineName> fromJsonDecodedMap(List dynamicList) {
    List<MedicineName> medicineNameList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        MedicineName medicineName = MedicineName.fromJson(e);
        medicineNameList.add(medicineName);
      });
    }
    return medicineNameList;
  }
  static mapFromJson(List dynamicList){
    List<MedicineName> medicineNameList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        MedicineName reason= MedicineName.fromJson(e);
        medicineNameList.add(reason);
      });
    }
    return medicineNameList;
  }

}