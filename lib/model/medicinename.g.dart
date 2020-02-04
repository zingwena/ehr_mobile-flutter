// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicinename.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineName _$MedicineNameFromJson(Map<String, dynamic> json) {
  return MedicineName(
    json['medicineCategory'] as String,
    json['medicineLevel'] as String,
    json['otc'] as bool,
  );
}

Map<String, dynamic> _$MedicineNameToJson(MedicineName instance) =>
    <String, dynamic>{
      'medicineCategory': instance.medicineCategory,
      'medicineLevel': instance.medicineLevel,
      'otc': instance.otc,
    };
