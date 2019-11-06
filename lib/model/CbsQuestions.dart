import 'dart:core';

import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

@CustomDateTimeConverter()
@JsonSerializable(explicitToJson: true)
class CbsQuestion{
  String  sexuallyactive;
  String age_whenclienthadfirstsexualintercourse;
  String numberofsexualpartners;
  String victimofsexualabuse;
  String  hadsexwithmale;
  String  hadsexwithfemale;
  String  unprotectedsex;
  String  hadsexwithsexworker;
  String  exchangedsexformoney;
  String  injectedrecreationaldrugs;
  String  beenincerceratedintojail;
  String  historyofansti;
  String  receivedmedicalinjections;
  String  receivedbloodtransfusions;
  String  tatooedwithunsterilisedinstruments;


  CbsQuestion(this.sexuallyactive, this.age_whenclienthadfirstsexualintercourse,
      this.numberofsexualpartners,this.victimofsexualabuse, this.hadsexwithmale, this.hadsexwithfemale
      ,this.unprotectedsex, this.hadsexwithsexworker, this.exchangedsexformoney, this.injectedrecreationaldrugs, this.beenincerceratedintojail,
      this.historyofansti, this.receivedbloodtransfusions, this.tatooedwithunsterilisedinstruments);



}
