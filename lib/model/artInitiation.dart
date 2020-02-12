import 'dart:core';

import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artInitiation.g.dart';

@CustomDateTimeConverter()
@JsonSerializable(explicitToJson: true)
class ArtInitiation{
  String artId;
  String regimenType;
  String reason;
  String regimen;
  //String artStatusId;

  ArtInitiation(this.artId, this.regimenType,this.reason, this.regimen);


  factory ArtInitiation.fromJson(Map<String, dynamic> json) =>
      _$ArtInitiationFromJson(json);

  Map<String, dynamic> toJson() => _$ArtInitiationToJson(this);

  static List<ArtInitiation> fromJsonDecodedMap(List dynamicList) {
    List<ArtInitiation> artInitiations = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        ArtInitiation artInitiation = ArtInitiation.fromJson(e);
        artInitiations.add(artInitiation);
      });
    }


    return artInitiations;
  }

  @override
  String toString() {
    return 'ArtInitiation{artId: $artId, regimenType: $regimenType, reason: $reason}';
  }


}
