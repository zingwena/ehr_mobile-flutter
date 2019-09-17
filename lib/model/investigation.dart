import 'package:json_annotation/json_annotation.dart';

part 'investigation.g.dart';

@JsonSerializable(explicitToJson: true)
class Investigation {
  String id;
  String sample;
  String test;

  Investigation(this.id, this.sample, this.test);


  factory Investigation.fromJson(Map<String, dynamic> json) =>
      _$InvestigationFromJson(json);

  Map<String, dynamic> toJson() => _$InvestigationToJson(this);

  static List<Investigation> fromJsonDecodedMap(List dynamicList) {
    List<Investigation> investigations = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        Investigation investigation = Investigation.fromJson(e);
        investigations.add(investigation);
      });
    }


    return investigations;
  }

}
