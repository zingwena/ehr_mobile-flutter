

import 'package:ehr_mobile/db/dao/art_dao/art_dao.dart';
import 'package:ehr_mobile/db/dao/art_dao/ArtSymptomDao.dart';
import 'package:ehr_mobile/db/dao/blood_pressure_dao.dart';
import 'package:ehr_mobile/db/dao/hts_dao/hts_dao.dart';
import 'package:ehr_mobile/db/dao/laboratory_investigation_dao.dart';
import 'package:ehr_mobile/db/dao/person_dao.dart';
import 'package:ehr_mobile/db/dao/person_investigation_dao.dart';
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

Future<String> pullPatientData(ProgressDialog progressDialog) async {
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
    var personInvestigationDao= PersonInvestigationDao(adapter);
    var labInvestigationDao=LaboratoryInvestigationDao(adapter);

    ///Empty existing data first
    htsDao.removeAll();
    personInvestigationDao.removeAll();
    personDao.removeAll();
    visitDao.removeAll();
    labInvestigationDao.removeAll();

    var t = await result.data["people"]['content'];
    for (Map patient in t) {
      try{
          log.i(patient);
          progressDialog.update(message: '${patient['firstname']}  ${patient['lastname']}.....');
          var personId=patient['personId'];
          personDao.insertFromEhr(patient);
          if(patient['history']!=null){
            var history=patient['history'];
            await savePersonInvestigations(history,personInvestigationDao,personId);

            //log.i('${patient['firstname']}  ${patient['lastname']}..... $history');
            ///-------Save Sexual History--------------
            if(history['sexualHistory']!=null){
              var sexualHistory = history['sexualHistory'];
              await saveSexualHistory(sexualHistory);

              ///-------Save Sexual History Questions--------------
              if(sexualHistory['questions']!=null){
                await saveSexualHistoryQuestion(sexualHistory,sexualHistory['sexualHistoryId']);
              }
            }

          }

          for(Map visitHistory in patient['visitHistory']){
            var patientId= visitHistory['patientId'];
            await visitDao.insertFromEhr(visitHistory,patient['personId']);
            await saveVitals(visitHistory,personId, patientId);
            if(visitHistory['hts']!=null){
              if(visitHistory['hts']['laboratoryInvestigation']!=null ){
                await labInvestigationDao.insertFromEhr(visitHistory['hts']['laboratoryInvestigation'],
                    visitHistory['facility']['id']);
              }
              await htsDao.insertFromEhr(visitHistory['hts'],personId,patientId);
            }
          }

          ///-------Save Art --------------
          if(patient['art']!=null){
            var art=patient['art'];
            log.i('${patient['firstname']}  ${patient['lastname']}..... $art');
            await savePatientArt(art,personId);

            if(art['symptoms']!=null){
              await savePatientArtSymptoms(art,art['artId']);
            }
          }

        }catch(e){
          log.e('${patient['firstname']}  ${patient['lastname']}..... $e');
          throw e;
        }
      //await Future.delayed(Duration(milliseconds: 500));
    }
  } else{
    log.e('$result');
  }
  return "$DONE_STATUS";
}

Future<String> savePersonInvestigations(Map map,PersonInvestigationDao dao, String personId) async{
  if(map['investigations']!=null){
    for(Map investigation in map['investigations']){
      await dao.insertFromEhr(investigation,personId);
    }
  }
  return 'DONE_STATUS';
}

Future<String> saveVitals(Map visit, String personId,String patientId) async{
  var dbHandler = DatabaseHelper();
  var adapter = await dbHandler.getAdapter();
  var tempDao = TemperatureDao(adapter);
  var bpDao = BloodPressureDao(adapter);
  var weightDao=WeightDao(adapter);
  if(visit['temperatures']!=null){
    for(Map tempMap in visit['temperatures']){
      await tempDao.insertFromEhr(tempMap,personId,patientId);
    }
  }

  if(visit['bloodPressures']!=null){
    for(Map bpMap in visit['bloodPressures']){
      await bpDao.insertFromEhr(bpMap,personId,patientId);
    }
  }

  if(visit['weight']!=null){
      await weightDao.insertFromEhr(visit['weight'],personId,patientId);
  }

  return 'DONE_STATUS';
}

Future<String> saveSexualHistory(Map sexualHistory) async{
  var dbHandler = DatabaseHelper();
  var adapter = await dbHandler.getAdapter();
  var sexualHistoryDao = SexualHistoryDao(adapter);
  await sexualHistoryDao.insertFromEhr(sexualHistory);
  return 'DONE_STATUS';
}

Future <String> saveSexualHistoryQuestion(Map qns,String sexualHistoryId) async {
  var dbHandler = DatabaseHelper();
  var adapter = await dbHandler.getAdapter();
  var shq = SexualHistoryQuestionDao(adapter);
  for(Map qn in qns['questions']){
    if(qn['sexualHistoryQuestionId']!=null){
      shq.insertFromEhr(qn,sexualHistoryId);
    }
  }
  return '$DONE_STATUS';
}

Future <String> savePatientArt(Map map,String personId) async {
  var dbHandler = DatabaseHelper();
  var adapter = await dbHandler.getAdapter();
  var artDao = ArtDao(adapter);
  artDao.insertFromEhr(map,personId);
  return '$DONE_STATUS';
}

Future <String> savePatientArtSymptoms(Map map,String artId) async {
  var dbHandler = DatabaseHelper();
  var adapter = await dbHandler.getAdapter();
  var artSymptomDao = ArtSymptomDao(adapter);
  for(Map symptom in map['symptoms']){
    if (symptom['artSymptomId'] != null) {
      await artSymptomDao.insertFromEhr(symptom,artId);
    }
    
  }
  return '$DONE_STATUS';
}
