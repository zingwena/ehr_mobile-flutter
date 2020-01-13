import 'dart:core';

import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'artregmendto.g.dart';

@CustomDateTimeConverter()
@JsonSerializable(explicitToJson: true)
class ArtRegimenDto{
  String personId;
  String line;

  ArtRegimenDto(this.personId, this.line);

  factory ArtRegimenDto.fromJson(Map<String, dynamic> json) =>
      _$ArtRegimenDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ArtRegimenDtoToJson(this);

  static List<ArtRegimenDto> fromJsonDecodedMap(List dynamicList) {
    List<ArtRegimenDto> artRegimenDtoList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        ArtRegimenDto artRegimenDto = ArtRegimenDto.fromJson(e);
        artRegimenDtoList.add(artRegimenDto);
      });
    }

    return artRegimenDtoList;
  }

  @override
  String toString() {
    return 'ArtRegimenDto{personId: $personId, line: $line}';
  }


}
