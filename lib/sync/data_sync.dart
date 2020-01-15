

import 'dart:async';
import 'dart:convert';

import 'package:ehr_mobile/db/dao/blood_pressure_dao.dart';
import 'package:ehr_mobile/db/dao/height_dao.dart';
import 'package:ehr_mobile/db/dao/hts_dao/hts_dao.dart';
import 'package:ehr_mobile/db/dao/hts_dao/index_contact_dao.dart';
import 'package:ehr_mobile/db/dao/hts_dao/index_test_dao.dart';
import 'package:ehr_mobile/db/dao/laboratory_investigation_dao.dart';
import 'package:ehr_mobile/db/dao/laboratory_investigation_test_dao.dart';
import 'package:ehr_mobile/db/dao/person_dao.dart';
import 'package:ehr_mobile/db/dao/person_investigation_dao.dart';
import 'package:ehr_mobile/db/dao/pulse_dao.dart';
import 'package:ehr_mobile/db/dao/respiratory_rate_dao.dart';
import 'package:ehr_mobile/db/dao/sexual_history_dao.dart';
import 'package:ehr_mobile/db/dao/sexual_history_question_dao.dart';
import 'package:ehr_mobile/db/dao/temperature_dao.dart';
import 'package:ehr_mobile/db/dao/visit_dao.dart';
import 'package:ehr_mobile/db/dao/weight_dao.dart';
import 'package:ehr_mobile/db/db_helper.dart';
import 'package:ehr_mobile/db/tables/blood_pressure_table.dart';
import 'package:ehr_mobile/db/tables/height_table.dart';
import 'package:ehr_mobile/db/tables/hts/index_contact_table.dart';
import 'package:ehr_mobile/db/tables/hts/index_test_table.dart';
import 'package:ehr_mobile/db/tables/laboratory_investigation_table.dart';
import 'package:ehr_mobile/db/tables/laboratory_investigation_test_table.dart';
import 'package:ehr_mobile/db/tables/person_investigation_table.dart';
import 'package:ehr_mobile/db/tables/pulse_table.dart';
import 'package:ehr_mobile/db/tables/respiratory_rate_table.dart';
import 'package:ehr_mobile/db/tables/sexual_history_question_table.dart';
import 'package:ehr_mobile/db/tables/temperature_table.dart';
import 'package:ehr_mobile/db/tables/visit_table.dart';
import 'package:ehr_mobile/db/tables/weight_table.dart';
import 'package:ehr_mobile/model/dto/patient_dto.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/util/logger.dart';

import 'package:http/http.dart' as http;
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

syncPatient(String token, String url) async {
  var dbHandler=DatabaseHelper();
  var adapter = await dbHandler.getAdapter();
  var personDao=PersonDao(adapter);
  List<Person> persons = await personDao.findAll();
  for(Person person in persons){
    var dto=PatientDto();
    dto.personDto=person;
    log.i(person);
    dto=await setVisit(adapter,dto);
    dto = await setHts(adapter,dto);
    dto = await setVitals(adapter, dto);
    dto = await setIndexTest(adapter,dto);
    //dto = await setIndexContacts(adapter,dto);
    dto=await setPersonInvestigations(adapter,dto);
    dto = await setSexualHistory(adapter,dto);

    var encoded=json.encode(dto);
    log.i(encoded.contains('sexualHistoryQuestion'));
    //log.i(encoded);
    if(person.status=='0' || person.status=='1'){
      http.post('$url/data-sync/patient',headers: {'Authorization': 'Bearer $token', 'Content-Type':'application/json'},body: json.encode(dto)).then((value){
        log.i(value.statusCode);
        log.i(json.decode(value.body));
        if(value.statusCode==201){
          personDao.setSyncd(person.id);
        } else {
          log.i(value);
        }
      }).catchError((error){
        log.i(error);
      });
    }
  }
}

Future<PatientDto> setVitals(SqfliteAdapter adapter,PatientDto dto) async {
  var vitals=List();
  var bpDao=BloodPressureDao(adapter);
  var bps=await bpDao.findByPersonId(dto.personDto.id);
  for(BloodPressureTable bp in bps){
    var jsonBp=bp.toJson();
    jsonBp['vitalName']='BLOOD_PRESSURE';
    vitals.add(jsonBp);
  }

  var respRateDao=RespiratoryRateDao(adapter);
  var respRates=await respRateDao.findByPersonId(dto.personDto.id);
  for(RespiratoryTable rate in respRates){
    var jsonBp=rate.toJson();
    jsonBp['vitalName']='RESPIRATORY_RATE';
    vitals.add(jsonBp);
  }

  var heightDao = HeightDao(adapter);
  var heights=await heightDao.findByPersonId(dto.personDto.id);
  for(HeightTable height in heights){
    var jsonBp=height.toJson();
    jsonBp['vitalName']='HEIGHT';
    vitals.add(jsonBp);
  }

  var pulseDao = PulseDao(adapter);
  var pulses=await pulseDao.findByPersonId(dto.personDto.id);
  for(PulseTable pulse in pulses){
    var jsonBp=pulse.toJson();
    jsonBp['vitalName']='PULSE';
    vitals.add(jsonBp);
  }

  var weightDao = WeightDao(adapter);
  var weights=await weightDao.findByPersonId(dto.personDto.id);
  for(WeightTable weight in weights){
    var jsonBp=weight.toJson();
    jsonBp['vitalName']='WEIGHT';
    vitals.add(jsonBp);
  }

  var tempDao = TemperatureDao(adapter);
  var temps=await tempDao.findByPersonId(dto.personDto.id);
  for(TemperatureTable temp in temps){
    var jsonBp=temp.toJson();
    jsonBp['vitalName']='TEMPERATURE';
    vitals.add(jsonBp);
  }
  dto.vitalDtos=vitals;
  return dto;
}

Future <PatientDto> setHts(SqfliteAdapter adapter,PatientDto dto) async{
  var htsDao=HtsDao(adapter);
  var hts = await htsDao.findByPersonId(dto.personDto.id);
  if(hts!=null){
    log.i('===================================HTS====${hts.id}');
    dto.htsDto=hts;
  }
  return dto;
}

Future <PatientDto> setIndexTest(SqfliteAdapter adapter,PatientDto dto) async {
  var indexTestDao=IndexTestDao(adapter);
  var indexTest=await indexTestDao.findByPersonId(dto.personDto.id);
  if(indexTest!=null){
    log.i('------->${indexTest.personId}');
    indexTest.visitId=dto.htsDto.visitId;
    dto.indexTestDto=indexTest;
    dto.indexTestDto.indexContactDtos=await setIndexContacts(adapter,indexTest.id);
  }
  return dto;
}

Future <List<IndexContactTable>> setIndexContacts(SqfliteAdapter adapter,String indexTestId) async {
  var indexContactDao=IndexContactDao(adapter);
  var indexContacts=await indexContactDao.findByIndexTestId(indexTestId);
  List<IndexContactTable>indexes=List();
  for(IndexContactTable contact in indexContacts){
    indexes.add(contact);
    log.i('-------CONTACT----->$contact');
  }
  return indexes;
}

Future <PatientDto> setPersonInvestigations(SqfliteAdapter adapter,PatientDto dto) async {
  var personInvestigationDao=PersonInvestigationDao(adapter);
  var personInvestigation=await personInvestigationDao.findByPersonId(dto.personDto.id);
  if(personInvestigation!=null){
    dto.personInvestigationDto=personInvestigation;
    dto=await setLabInvestigations(adapter,personInvestigation.id,dto);
  }
  return dto;
}

Future <PatientDto> setLabInvestigations(SqfliteAdapter adapter,String personInvestigationId,PatientDto dto) async {
  var labInvestigationDao=LaboratoryInvestigationDao(adapter);
  var labInvestigation=await labInvestigationDao.findPersonInvestigationId(personInvestigationId);
    log.i('======>${labInvestigation.facilityId}');
    dto.laboratoryInvestigationDto=labInvestigation;
    var labTests=await getLabInvestigationTests(adapter,labInvestigation.id);
    labInvestigation.laboratoryInvestigationTestDtos=labTests;
  return dto;
}

Future <List<LaboratoryInvestigationTestTable>> getLabInvestigationTests(SqfliteAdapter adapter,String laboratoryInvestigationId) async {
  var labInvestigationTestDao=LaboratoryInvestigationTestDao(adapter);
  var labInvestigations=await labInvestigationTestDao.findByLaboratoryInvestigationId(laboratoryInvestigationId);
  List<LaboratoryInvestigationTestTable> labTests=List();
  for(LaboratoryInvestigationTestTable labInvestigationTest in labInvestigations){
    log.i('======>StartTime--${labInvestigationTest.startTime}');
    log.i('======>EndTime--${labInvestigationTest.endTime}');
    log.i('======>resultCode--${labInvestigationTest.resultCode}');
    log.i('======>resultName--${labInvestigationTest.resultName}');
    labTests.add(labInvestigationTest);
  }
  return labTests;
}

Future <PatientDto> setSexualHistory(SqfliteAdapter adapter,PatientDto dto) async {
  var sexualHistoryDao=SexualHistoryDao(adapter);
  var sexualHistory=await sexualHistoryDao.findByPersonId(dto.personDto.id);
  if(sexualHistory!=null){
    dto.sexualHistoryDto=sexualHistory;
    var sexualHistoryQns=await setSexualHistoryQuestions(adapter,sexualHistory.id);
    sexualHistory.sexualHistoryQuestionDtos=sexualHistoryQns;
  }
  return dto;
}

Future <List<SexualHistoryQuestionTable>> setSexualHistoryQuestions(SqfliteAdapter adapter,String sexualHistoryId) async {
  var sexualHistoryQuestionDao=SexualHistoryQuestionDao(adapter);
  var sexualHistoryQuestions=await sexualHistoryQuestionDao.findBySexualHistoryId(sexualHistoryId);
  List<SexualHistoryQuestionTable> sexualHistoryQuestionsList=List();
  for(SexualHistoryQuestionTable sexualHistoryQuestion in sexualHistoryQuestions){
    log.i('======>sexualHistoryQuestion--${sexualHistoryQuestion.id}');
    sexualHistoryQuestionsList.add(sexualHistoryQuestion);
  }
  log.i(sexualHistoryQuestionsList);
  return sexualHistoryQuestionsList;
}

Future <PatientDto> setVisit(SqfliteAdapter adapter,PatientDto dto) async {
  var visitDao=VisitDao(adapter);
  var visit = await visitDao.findByPersonId(dto.personDto.id);
  if(visit!=null){
    log.i('===================================Visit====${visit.id}');
    dto.patientId=visit.id;
    dto.personId=visit.personId;
    dto.patientType=visit.patientType;
    dto.hospitalNumber=visit.hospitalNumber;
    dto.time=visit.time;
    dto.name=visit.name;
    dto.code=visit.code;
  }
  return dto;
}
