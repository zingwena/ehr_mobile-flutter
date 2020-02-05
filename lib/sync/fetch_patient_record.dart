
import 'dart:convert';

import 'package:ehr_mobile/db/dao/blood_pressure_dao.dart';
import 'package:ehr_mobile/db/dao/hts_dao/hts_dao.dart';
import 'package:ehr_mobile/db/dao/laboratory_investigation_dao.dart';
import 'package:ehr_mobile/db/dao/person_dao.dart';
import 'package:ehr_mobile/db/dao/person_investigation_dao.dart';
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
import 'package:jaguar_query_sqflite/src/adapter.dart';
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
      log.i(patient);
      progressDialog.update(message: '${patient['firstname']}  ${patient['lastname']}.....');
      var personId=patient['personId'];
      personDao.insertFromEhr(patient);
      if(patient['history']!=null){
        await savePersonInvestigations(patient['history'],personInvestigationDao,personId);
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
      //await Future.delayed(Duration(milliseconds: 500));
    }
  } else{
    log.e('$result');
  }
  return "$DONE_STATUS";
}

Future<String> savePersonInvestigations(Map map,PersonInvestigationDao dao, String personId) async{
  log.i(map);
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
