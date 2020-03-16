
import 'package:ehr_mobile/db/tables/art_initiation_table.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'base_table.dart';
@JsonSerializable(explicitToJson: true)


class ArtTable extends BaseTable{

  String personId;
  String date;
  String artNumber;
  bool enlargedLymphNode;
  bool pallor;
  bool jaundice;
  bool cyanosis;
  String mentalStatus;
  String centralNervousSystem;
  String dateOfHivTest;
  String  dateEnrolled;
  bool tracing;
  bool followUp;
  bool hivStatus;
  String relation;
  String dateOfDisclosure;
  String reason;

  static ArtTable fromJson(Map map) {
    var art = ArtTable();

    art.id=map['id'];
    art.status=map['status'];
    art.personId = map['personId'];
    art.dateEnrolled = const CustomDateTimeConverter().fromIntToSqlDate(map['dateEnrolled']);
    art.date = const CustomDateTimeConverter().fromIntToSqlDate(map['date']);
    art.dateOfHivTest = const CustomDateTimeConverter().fromIntToSqlDate(map['dateOfHivTest']);
    art.artNumber=map['artNumber'];
    art.enlargedLymphNode=map['enlargedLymphNode'];
    art.pallor=map['pallor'];
    art.cyanosis=map['cyanosis'];
    art.mentalStatus=map['mentalStatus'];
    art.centralNervousSystem=map['centralNervousSystem'];
    art.tracing=map['tracing'];
    art.followUp=map['followUp'];
    art.hivStatus=map['hivStatus'];
    art.relation=map['relation'];
    art.dateOfDisclosure= const CustomDateTimeConverter().fromIntToSqlDate(map['dateOfDisclosure']);
    art.reason=map['reason'];
    return art;
  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'status':status,
    'personId':personId,
    'dateEnrolled':dateEnrolled,
    'date' : date,
    'dateOfHivTest':dateOfHivTest,
    'artNumber':artNumber,
    'enlargedLymphNode': enlargedLymphNode,
     'pallor': pallor,
     'jaundice': jaundice,
     'cyanosis': cyanosis,
     'mentalStatus': mentalStatus,
     'centralNervousSystem': centralNervousSystem,
     'dateOfHivTest': dateOfHivTest,
     'dateEnrolled': dateEnrolled,
     'tracing ': tracing,
      'followUp': followUp,
      'hivStatus': hivStatus,
      'relation': relation,
       'dateOfDisclosure': dateOfDisclosure,
       'reason': reason


  };
}
