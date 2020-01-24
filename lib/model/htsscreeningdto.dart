import 'package:ehr_mobile/util/custom_date_converter.dart';

import 'package:json_annotation/json_annotation.dart';
part 'htsscreeningdto.g.dart';
@JsonSerializable()
class HtsScreeningdto{
  String personId;
  String visitId;
  bool testedBefore;
  bool art;
  String result;
  DateTime dateLastTested;
  String artNumber;
  bool beenOnPrep;
  String prepOption;
  String viralLoadDone;
  String cd4Done;
  DateTime dateEnrolled;
  DateTime  dateLastNegative;
  DateTime  viralLoadDate;
  DateTime  cd4CountDate;

  HtsScreeningdto(String personId, String visitId, bool testedBefore, bool art, String result, DateTime dateLastNegative,   DateTime dateLastTested, DateTime dateEnrolled, String artNumber, bool beenOnPrep,
      String prepOption, String viralLoadDone, DateTime viralLoadDate ,String cd4Done, DateTime cd4CountDate){
    this.personId = personId;
    this.visitId = visitId;
    this.testedBefore = testedBefore;
    this.art = art;
    this.result = result;
    this.artNumber = artNumber;
    this.beenOnPrep = beenOnPrep;
    this.dateLastNegative = dateLastNegative;
    this.dateLastTested = dateLastTested;
    this.dateEnrolled = dateEnrolled;
    this.prepOption = prepOption;
    this.viralLoadDone = viralLoadDone;
    this.viralLoadDate = viralLoadDate;
    this.cd4Done = cd4Done;
    this.cd4CountDate = cd4CountDate;
  }


  factory HtsScreeningdto.fromJson(Map<String, dynamic> json) => _$HtsScreeningFromJson(json);

  Map<String, dynamic> toJson() => _$HtsScreeningToJson(this);
  @override
  String toString() {
    return 'HtsScreeningdto{visitId: $visitId, testedBefore: $testedBefore, art: $art, '
        'result: $result, dateLastNegative: $dateLastNegative,dateLastTested:$dateLastTested, artNumber:$artNumber,  beenOnPrep:$beenOnPrep, prepOption:$prepOption, viralLoadDone:$viralLoadDone, cd4Done:$cd4Done}';
  }

  static List<HtsScreeningdto> fromJsonDecodedMap(List dynamicList) {
    List<HtsScreeningdto> htsscreeningtList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        HtsScreeningdto htsScreening = HtsScreeningdto.fromJson(e);
        htsscreeningtList.add(htsScreening);
      });
    }
    return htsscreeningtList;
  }
}