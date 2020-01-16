
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'base_table.dart';
@JsonSerializable(explicitToJson: true)


class ArtTable extends BaseTable{

  String personId;
  String dateOfEnrolmentIntoCare;
  String dateOfHivTest;
  String oiArtNumber;

  static ArtTable fromJson(Map map) {
    var art = ArtTable();

    art.id=map['id'];
    art.status=map['status'];

    art.personId = map['personId'];
    art.dateOfEnrolmentIntoCare = const CustomDateTimeConverter().fromIntToSqlDate(map['dateOfEnrolmentIntoCare']);
    art.dateOfHivTest = const CustomDateTimeConverter().fromIntToSqlDate(map['dateOfHivTest']);
    art.oiArtNumber=map['oiArtNumber'];

    return art;
  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'status':status,
    'personId':personId,
    'dateOfEnrolmentIntoCare':dateOfEnrolmentIntoCare,
    'dateOfHivTest':dateOfHivTest,
    'oiArtNumber':oiArtNumber
  };
}
