import 'dart:core';

import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artRegistration.g.dart';

@CustomDateTimeConverter()
@JsonSerializable(explicitToJson: true)
class ArtRegistration {
  String id;
   String personId;
   DateTime dateOfEnrolmentIntoCare;
   DateTime dateOfHivTest;
   String oiArtNumber;





  ArtRegistration(this.id,this.personId, this.dateOfEnrolmentIntoCare, this.dateOfHivTest,this.oiArtNumber);


  factory ArtRegistration.fromJson(Map<String, dynamic> json) =>
      _$ArtRegistrationFromJson(json);

  Map<String, dynamic> toJson() => _$ArtRegistrationToJson(this);

  static List<ArtRegistration> fromJsonDecodedMap(List dynamicList) {
    List<ArtRegistration> artRegistrations = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        ArtRegistration artRegistration = ArtRegistration.fromJson(e);
        artRegistrations.add(artRegistration);
      });
    }


    return artRegistrations;
  }

}
