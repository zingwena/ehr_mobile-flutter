import 'package:ehr_mobile/db/dao/art_dao/ArtAppointmentDao.dart';
import 'package:ehr_mobile/db/dao/art_dao/ArtCurrentStatusDao.dart';
import 'package:ehr_mobile/db/dao/art_dao/ArtLinkageFromDao.dart';
import 'package:ehr_mobile/db/dao/art_dao/ArtVisitDao.dart';
import 'package:ehr_mobile/db/dao/art_dao/ArtWhoStageDao.dart';
import 'package:ehr_mobile/db/dao/art_dao/art_dao.dart';
import 'package:ehr_mobile/db/dao/art_dao/ArtSymptomDao.dart';
import 'package:ehr_mobile/db/dao/blood_pressure_dao.dart';
import 'package:ehr_mobile/db/dao/height_dao.dart';
import 'package:ehr_mobile/db/dao/hts_dao/hts_dao.dart';
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
import 'package:ehr_mobile/graphql/graphql_queries.dart';
import 'package:ehr_mobile/main.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/util/logger.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'pull_patient_queue.dart';

Future<String> pullPatientData(ProgressDialog progressDialog) async {
  progressDialog.update(message: 'Fetching Patient Records...');
  PersonQuery queryMutation = PersonQuery();
  var ip = await retrieveString(SERVER_IP);
  GraphQLClient _client = graphQLConfiguration.clientToQuery(ip);
  QueryResult result = await _client.query(
    QueryOptions(
      document: queryMutation.getAll(),
    ),
  );

  if (!result.hasErrors) {
    var dbHandler = DatabaseHelper();
    var adapter = await dbHandler.getAdapter();
    var personDao = PersonDao(adapter);
    var visitDao = VisitDao(adapter);
    var htsDao = HtsDao(adapter);
    var personInvestigationDao = PersonInvestigationDao(adapter);
    var labInvestigationDao = LaboratoryInvestigationDao(adapter);
    await ArtDao(adapter).removeAll();
    await ArtSymptomDao(adapter).removeAll();
    await ArtVisitDao(adapter).removeAll();

    await ArtCurrentStatusDao(adapter).removeAll();

    ///------EMPTY VITALS----
    await WeightDao(adapter).removeAll();
    await HeightDao(adapter).removeAll();
    await PulseDao(adapter).removeAll();
    await RespiratoryRateDao(adapter).removeAll();
    await BloodPressureDao(adapter).removeAll();

    ///Empty existing data first
    await htsDao.removeAll();
    await personInvestigationDao.removeAll();
    await personDao.removeAll();
    await visitDao.removeAll();
    await labInvestigationDao.removeAll();

    await LaboratoryInvestigationTestDao(adapter).removeAll();

    var t = await result.data["people"]['content'];
    for (Map patient in t) {
      log.i('--------${patient['firstname']}  ${patient['lastname']}.....');
      try{
          progressDialog.update(
              message: '${patient['firstname']}  ${patient['lastname']}.....');
          var personId = patient['personId'];
          personDao.insertFromEhr(patient);

            if (patient['history'] != null) {
              var history = patient['history'];
              await savePersonInvestigations(
                  history, personInvestigationDao, personId);

              ///-------Save Sexual History--------------
              if (history['sexualHistory'] != null) {
                var sexualHistory = history['sexualHistory'];
                await saveSexualHistory(sexualHistory);

                ///-------Save Sexual History Questions--------------
                if (sexualHistory['questions'] != null) {
                  await saveSexualHistoryQuestion(
                      sexualHistory, sexualHistory['sexualHistoryId']);
                }
              }
            }

              for (Map visitHistory in patient['visitHistory']) {
                var patientId = visitHistory['patientId'];
                await visitDao.insertFromEhr(visitHistory, patient['personId']);
                //log.i(visitHistory);
                await saveVitals(visitHistory, personId, patientId);
                  if (visitHistory['hts'] != null) {
                    if (visitHistory['hts']['laboratoryInvestigation'] != null) {
                      var labInvestigation=visitHistory['hts']['laboratoryInvestigation'];
                      await labInvestigationDao.insertFromEhr(labInvestigation,
                          visitHistory['facility']['id']);
                      await saveLabTests(labInvestigation,patientId);
                    }
                    await htsDao.insertFromEhr(
                        visitHistory['hts'], personId, patientId,visitHistory['hts']['laboratoryInvestigation']['laboratoryInvestigationId']);
                  }


              }

              ///-------Save Art --------------
              if (patient['art'] != null) {
                var art = patient['art'];
                await savePatientArt(art, personId);

                if (art['symptoms'] != null) {
                  await savePatientArtSymptoms(art, art['artId']);
                }

                if (art['appointments'] != null) {
                  await saveArtAppointments(art);
                }

                if (art['artCurrentStatus']!= null) {
                  await saveArtCurrentStatus(art['artCurrentStatus'],art['artId']);
                }

                if(art['visits']!=null){
                  await saveArtVisit(art);
                }

                if(art['artLinkagesFrom']!=null){
                  await saveArtLinkageFrom(art,art['artId']);
                }

              }


        }catch(e){
          log.e('${patient['firstname']}  ${patient['lastname']}..... $e');
          //throw e;
        }
      //await Future.delayed(Duration(milliseconds: 500));
    }

    try{
      await fetchPatientQueue();
    }catch(e){
      log.e('$e');
    }


  } else {
    log.e(result.errors);
  }
  return "$DONE_STATUS";
}

Future<String> savePersonInvestigations(
    Map map, PersonInvestigationDao dao, String personId) async {
  if (map['investigations'] != null) {
    for (Map investigation in map['investigations']) {
      await dao.insertFromEhr(investigation, personId);
    }
  }
  return 'DONE_STATUS';
}

Future<String> saveVitals(Map visit, String personId, String patientId) async {
  var dbHandler = DatabaseHelper();
  var adapter = await dbHandler.getAdapter();
  var tempDao = TemperatureDao(adapter);
  var bpDao = BloodPressureDao(adapter);
  var weightDao = WeightDao(adapter);
  var heightDao=HeightDao(adapter);
  var pulseDao=PulseDao(adapter);
  var respiratoryRateDao=RespiratoryRateDao(adapter);
  if (visit['temperatures'] != null) {
    for (Map tempMap in visit['temperatures']) {
      await tempDao.insertFromEhr(tempMap, personId, patientId);
    }
  }

  if (visit['pulses'] != null) {
    for (Map bpMap in visit['pulses']) {
      await pulseDao.insertFromEhr(bpMap, personId, patientId);
    }
  }

  if (visit['respiratoryRates'] != null) {
    for (Map bpMap in visit['respiratoryRates']) {
      await respiratoryRateDao.insertFromEhr(bpMap, personId, patientId);
    }
  }

  if (visit['bloodPressures'] != null) {
    for (Map bpMap in visit['bloodPressures']) {
      await bpDao.insertFromEhr(bpMap, personId, patientId);
    }
  }

  if (visit['weight'] != null) {
    await weightDao.insertFromEhr(visit['weight'], personId, patientId);
  }

  if (visit['height'] != null) {
    await heightDao.insertFromEhr(visit['height'], personId, patientId);
  }
  return '$DONE_STATUS';
}

Future<String> saveSexualHistory(Map sexualHistory) async {
  var dbHandler = DatabaseHelper();
  var adapter = await dbHandler.getAdapter();
  var sexualHistoryDao = SexualHistoryDao(adapter);
  await sexualHistoryDao.insertFromEhr(sexualHistory);
  return '$DONE_STATUS';
}

Future<String> saveSexualHistoryQuestion(
    Map qns, String sexualHistoryId) async {
  var dbHandler = DatabaseHelper();
  var adapter = await dbHandler.getAdapter();
  var shq = SexualHistoryQuestionDao(adapter);
  for (Map qn in qns['questions']) {
    if (qn['sexualHistoryQuestionId'] != null) {
      shq.insertFromEhr(qn, sexualHistoryId);
    }
  }
  return '$DONE_STATUS';
}

Future<String> savePatientArt(Map map, String personId) async {
  var dbHandler = DatabaseHelper();
  var adapter = await dbHandler.getAdapter();
  var artDao = ArtDao(adapter);
  await artDao.insertFromEhr(map, personId);
  return '$DONE_STATUS';
}

Future<String> savePatientArtSymptoms(Map map, String artId) async {
  var dbHandler = DatabaseHelper();
  var adapter = await dbHandler.getAdapter();
  var artSymptomDao = ArtSymptomDao(adapter);
  for (Map symptom in map['symptoms']) {
    if (symptom['artSymptomId'] != null) {
      await artSymptomDao.insertFromEhr(symptom, artId);
    }
  }
  return '$DONE_STATUS';
}

Future<String> saveArtAppointments(Map map) async {
  var dbHandler = DatabaseHelper();
  var adapter = await dbHandler.getAdapter();
  var appointmentDao = ArtAppointmentDao(adapter);
  for (Map appointment in map['appointments']) {
    await appointmentDao.insertFromEhr(appointment);
  }
  return '$DONE_STATUS';
}

Future<String> saveArtCurrentStatus(Map map,String artId) async {
  var dbHandler = DatabaseHelper();
  var adapter = await dbHandler.getAdapter();
  var artCurrentStatusDao = ArtCurrentStatusDao(adapter);
  await artCurrentStatusDao.insertFromEhr(map,artId);
  return '$DONE_STATUS';
}

Future<String> saveArtVisit(Map map) async {
  var dbHandler = DatabaseHelper();
  var adapter = await dbHandler.getAdapter();
  var artVisitDao = ArtVisitDao(adapter);
  for(Map visit in map['visits']){
    await artVisitDao.insertFromEhr(visit,map['artId']);
    if(visit['stage']!=null){
      await saveArtWhoStage(visit['stage'],map['artId'],visit['visitId']);
    }
  }
  return '$DONE_STATUS';
}

Future<String> saveArtWhoStage(Map map,String artId,String visitId) async {
  var dbHandler = DatabaseHelper();
  var adapter = await dbHandler.getAdapter();
  var artWhoStageDao = ArtWhoStageDao(adapter);
  await artWhoStageDao.insertFromEhr(map,artId,visitId);

  return '$DONE_STATUS';
}


Future<String> saveLabTests(Map labInvestigation,String visitId) async {
  var dbHandler = DatabaseHelper();
  var adapter = await dbHandler.getAdapter();
  var labTestsDao = LaboratoryInvestigationTestDao(adapter);
  for(Map test in labInvestigation['tests']){
    await labTestsDao.insertFromEhr(test,labInvestigation['laboratoryInvestigationId'],visitId);
  }
  return '$DONE_STATUS';
}

Future<String> saveArtLinkageFrom(Map artLinkages,String artId) async {
  var dbHandler = DatabaseHelper();
  var adapter = await dbHandler.getAdapter();
  var linkagesDao = ArtLinkageFromDao(adapter);
  for(Map linkage in artLinkages['artLinkagesFrom']){
    await linkagesDao.insertFromEhr(linkage,artId);
  }
  return '$DONE_STATUS';
}
