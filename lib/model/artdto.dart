
import 'package:ehr_mobile/model/base_code.dart';
import 'package:ehr_mobile/model/namecode.dart';
import 'package:ehr_mobile/model/reason.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'appointmentoutcome.dart';
import 'followupreason.dart';
part 'artdto.g.dart';
@JsonSerializable(explicitToJson: true)
@CustomDateTimeConverter()
class Artdto {
   String personId;
   DateTime date;
   String artNumber;
   bool enlargedLymphNode;
   bool pallor;
   bool jaundice;
   bool cyanosis;
   String mentalStatus;
   String centralNervousSystem;
   DateTime dateOfHivTest;
   DateTime dateEnrolled;
   bool tracing;
   bool followUp;
   bool hivStatus;
   String relation;
   DateTime dateOfDisclosure;
   String reason;
   String linkageFrom;
   DateTime dateHivConfirmed;
   String linkageNumber;
   String hivTestUsed;
   String otherInstitution;
   NameCode testReason;
   bool reTested;
   DateTime dateRetested;
   NameCode facility;

   Artdto(this.personId, this.date, this.artNumber, this.enlargedLymphNode,
       this.pallor, this.jaundice, this.cyanosis, this.mentalStatus,
       this.centralNervousSystem, this.dateOfHivTest, this.dateEnrolled,
       this.tracing, this.followUp, this.hivStatus, this.relation,
       this.dateOfDisclosure, this.reason, this.linkageFrom,
       this.dateHivConfirmed, this.linkageNumber, this.hivTestUsed,
       this.otherInstitution, this.testReason, this.reTested, this.dateRetested,
       this.facility);

   factory Artdto.fromJson(Map<String,dynamic> json) => _$ArtdtoFromJson(json);

  Map<String,dynamic> toJson() => _$ArtdtoToJson(this);

   static mapFromJson(List dynamicList){
    List<Artdto> artdtoList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        Artdto artdto= Artdto.fromJson(e);
        artdtoList.add(artdto);
      });
    }
    return artdtoList;
  }



}

