

import 'package:ehr_mobile/db/tables/sexual_history_question_table.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';

import 'base_table.dart';

class SexualHistoryTable extends BaseTable {

  String personId;
  int sexuallyActive;
  String sexWithMaleDate;
  String sexWithFemaleDate;
  String date;
  int numberOfSexualPartners;
  int numberOfSexualPartnersLastTwelveMonths;
  List<SexualHistoryQuestionTable> sexualHistoryQuestionDtos=new List();

  static SexualHistoryTable fromJson(Map map) {
    var sh = SexualHistoryTable();
    sh.id = map['id'];
    sh.status=map['status'];
    sh.personId=map['personId'];
    sh.sexuallyActive=map['sexuallyActive'];
    sh.sexWithMaleDate = const CustomDateTimeConverter().fromIntToSqlDate(map['sexWithMaleDate']);
    sh.sexWithFemaleDate = const CustomDateTimeConverter().fromIntToSqlDate(map['sexWithFemaleDate']);
    sh.date = const CustomDateTimeConverter().fromIntToSqlDate(map['date']);
    if(map['numberOfSexualPartners']!=null){
      sh.numberOfSexualPartners=map['numberOfSexualPartners'];
    }

    if(map['numberOfSexualPartnersLastTwelveMonths']!=null){
      sh.numberOfSexualPartnersLastTwelveMonths=map['numberOfSexualPartnersLastTwelveMonths'];
    }

    return sh;
  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'status':status,
    'personId':personId,

    'sexuallyActive':sexuallyActive,
    'sexWithMaleDate':sexWithMaleDate,
    'sexWithFemaleDate':sexWithFemaleDate,

    'date':date,
    'numberOfSexualPartners':numberOfSexualPartners,
    'numberOfSexualPartnersLastTwelveMonths':numberOfSexualPartnersLastTwelveMonths,
    'sexualHistoryQuestionDtos':sexualHistoryQuestionDtos
  };
}