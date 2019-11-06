import 'dart:core';

import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

@CustomDateTimeConverter()
@JsonSerializable(explicitToJson: true)
class CbsQuestion{
  bool sexuallyactive;
  String age_whenclienthadfirstsexualintercourse;
  String numberofsexualpartners;
  bool victimofsexualabuse;
  bool hadsexwithmale;
  bool hadsexwithfemale;
  bool unprotectedsex;
  bool hadsexwithsexworker;
  bool exchangedsexformoney;
  bool injectedrecreationaldrugs;
  bool beenincerceratedintojail;
  bool historyofansti;
  bool receivedmedicalinjections;
  bool receivedbloodtransfusions;
  bool tatooedwithunsterilisedinstruments;


  CbsQuestion(this.sexuallyactive, this.age_whenclienthadfirstsexualintercourse,
      this.numberofsexualpartners,this.victimofsexualabuse, this.hadsexwithmale, this.hadsexwithfemale
      ,this.unprotectedsex, this.hadsexwithsexworker, this.exchangedsexformoney, this.injectedrecreationaldrugs, this.beenincerceratedintojail,
      this.historyofansti, this.receivedbloodtransfusions, this.tatooedwithunsterilisedinstruments);



}
