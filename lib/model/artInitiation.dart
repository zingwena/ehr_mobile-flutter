import 'dart:core';

import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artInitiation.g.dart';

@CustomDateTimeConverter()
@JsonSerializable(explicitToJson: true)
class ArtInitiation{
  String id;
  String personId;
  DateTime dateOfEnrolmentIntoCare;
  DateTime dateInitiatedOnArt;
  String clientType;
  String clientEligibility;
  String line;
  String artRegimen;
  String reason;




  ArtInitiation(this.id,this.personId, this.dateOfEnrolmentIntoCare, this.dateInitiatedOnArt,this.clientType,this.clientEligibility,this.line,this.artRegimen,this.reason);


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

}
