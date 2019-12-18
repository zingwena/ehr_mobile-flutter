

import 'dart:async';
import 'dart:convert';

import 'package:ehr_mobile/db/dao/blood_pressure_dao.dart';
import 'package:ehr_mobile/db/dao/height_dao.dart';
import 'package:ehr_mobile/db/dao/hts_dao/hts_dao.dart';
import 'package:ehr_mobile/db/dao/hts_dao/index_contact_dao.dart';
import 'package:ehr_mobile/db/dao/hts_dao/index_test_dao.dart';
import 'package:ehr_mobile/db/dao/person_dao.dart';
import 'package:ehr_mobile/db/dao/pulse_dao.dart';
import 'package:ehr_mobile/db/dao/respiratory_rate_dao.dart';
import 'package:ehr_mobile/db/dao/temperature_dao.dart';
import 'package:ehr_mobile/db/dao/weight_dao.dart';
import 'package:ehr_mobile/db/db_helper.dart';
import 'package:ehr_mobile/db/tables/blood_pressure_table.dart';
import 'package:ehr_mobile/db/tables/height_table.dart';
import 'package:ehr_mobile/db/tables/hts/index_contact_table.dart';
import 'package:ehr_mobile/db/tables/hts/index_test_table.dart';
import 'package:ehr_mobile/db/tables/pulse_table.dart';
import 'package:ehr_mobile/db/tables/respiratory_rate_table.dart';
import 'package:ehr_mobile/db/tables/temperature_table.dart';
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
    dto = await setHts(adapter,dto);
    dto = await setVitals(adapter, dto);
    dto = await setIndexTest(adapter,dto);
    //dto = await setIndexContacts(adapter,dto);
    if(person.status=='0'){
      http.post('$url/data-sync/patient',headers: {'Authorization': 'Bearer $token', 'Content-Type':'application/json'},body: json.encode(dto)).then((value){
        log.i(value.statusCode);
        log.i(json.decode(value.body));
        if(value.statusCode==201){
          personDao.setSyncd(person.id);
        } else{

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
    log.i(hts.htsApproach);
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
    setIndexContacts(adapter,indexTest.id,dto);
  }
  return dto;
}

Future <PatientDto> setIndexContacts(SqfliteAdapter adapter,String indexTestId,PatientDto dto) async {
  var indexContactDao=IndexContactDao(adapter);
  var indexContacts=await indexContactDao.findByIndexTestId(indexTestId);
  for(IndexContactTable contact in indexContacts){
        log.i('------->$contact');
  }
  return dto;
}