
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'base_table.dart';
@JsonSerializable(explicitToJson: true)


class HtsScreeningTable extends BaseTable{

  String visitId;
  int testedBefore;
  int art;
  String result;
  String dateLastTested;
  String dateLastNegative;
  String artNumber;
  int viralLoadDone;
  int cd4Done;

  static HtsScreeningTable fromJson(Map map) {
    var htsScreening = HtsScreeningTable();

    htsScreening.id=map['id'];
    htsScreening.status=map['status'];

    htsScreening.visitId = map['visitId'];
    htsScreening.testedBefore=map['testedBefore'];

    htsScreening.art=map['art'];
    htsScreening.result=map['result'];

    htsScreening.dateLastTested = const CustomDateTimeConverter().fromIntToSqlDate(map['dateLastTested']);
    htsScreening.dateLastNegative = const CustomDateTimeConverter().fromIntToSqlDate(map['dateLastNegative']);

    htsScreening.artNumber=map['artNumber'];

    htsScreening.viralLoadDone=map['viralLoadDone'];
    htsScreening.cd4Done=map['cd4Done'];
    return htsScreening;
  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'status':status,
    'visitId':visitId,
    'testedBefore':testedBefore,
    'art':art,

    'result':result,
    'dateLastTested':dateLastTested,

    'dateLastNegative':dateLastNegative,
    'artNumber':artNumber,

    'viralLoadDone':viralLoadDone,
    'cd4Done':cd4Done,
  };
}
