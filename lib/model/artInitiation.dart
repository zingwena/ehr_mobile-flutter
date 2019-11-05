import 'dart:core';

import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artInitiation.g.dart';

@CustomDateTimeConverter()
@JsonSerializable(explicitToJson: true)
class ArtInitiation{

  String personId;
  String line;
  String artRegimenId;
  String artReasonId;
  //String artStatusId;




  ArtInitiation(this.personId, this.line,this.artRegimenId,this.artReasonId);


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
    return 'ArtInitiation{personId: $personId, line: $line, artRegimenId: $artRegimenId, artReasonId: $artReasonId}';
  }


}
