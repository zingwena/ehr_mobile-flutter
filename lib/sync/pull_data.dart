
import 'dart:convert';

import 'package:ehr_mobile/db/dao/meta_dao/country_dao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/marital_status_dao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/nationality_dao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/occupation_dao.dart';
import 'package:ehr_mobile/db/dao/person_dao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/town_dao.dart';
import 'package:ehr_mobile/db/db_helper.dart';
import 'package:ehr_mobile/graphql/graphql_queries.dart';
import 'package:ehr_mobile/main.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/util/logger.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

Future<String> pullPatientData() async {
  PersonQuery queryMutation = PersonQuery();
  var ip=await retrieveString(SERVER_IP);
  GraphQLClient _client = graphQLConfiguration.clientToQuery(ip);
  QueryResult result = await _client.query(
    QueryOptions(
      document: queryMutation.getAll(),
    ),
  );

  if (!result.hasErrors) {
    var dbHandler=DatabaseHelper();
    var adapter = await dbHandler.getAdapter();
    var personDao=PersonDao(adapter);
    personDao.removeAll();
    var t = await result.data["people"]['content'];

    for (var i = 0; i < t.length; i++) {
      personDao.insertFromEhr(t[i]);
    }
  }
  return "DONE";
}

Future <String> pullMetaData(String url,String authToken) async {
  var dbHandler=DatabaseHelper();
  var adapter = await dbHandler.getAdapter();
  await initDb(adapter);
  await fetchTowns(adapter,url,authToken);
  await fetchMaritalStatus(adapter,url,authToken);
  await fetchCountries(adapter,url,authToken);
  await fetchNationalities(adapter,url,authToken);
  await fetchOccupations(adapter,url,authToken);

}

Future<String>initDb(SqfliteAdapter adapter){

  var personDao=PersonDao(adapter);
  personDao.removeAll();

  var townDao=TownDao(adapter);
  townDao.removeAll();

  var maritalStateDao=MaritalStatusDao(adapter);
  maritalStateDao.removeAll();

  var countryDao=CountryDao(adapter);
  countryDao.removeAll();

  var nationalityDao=NationalityDao(adapter);
  nationalityDao.removeAll();

  var occupationsDao=OccupationDao(adapter);
  occupationsDao.removeAll();
}

Future<String> fetchTowns(SqfliteAdapter adapter,String url,String authToken) async {
  var townDao=TownDao(adapter);
  var status;
  await http.get('$url/towns?size=$TOWN_FETCH_SIZE',headers: {'Authorization': 'Bearer $authToken', 'Content-Type':'application/json'}).then((value){
    if(value.statusCode==200){
      var towns=json.decode(value.body)['content'];
      for(Map map in towns){
        townDao.insertFromEhr(map);
      }
      status='DONE';
    } else {
      log.i(value);
      status='FAILED';
    }
  }).catchError((error){
    log.i(error);
  });
  return status;
}


Future<String> fetchMaritalStatus(SqfliteAdapter adapter,String url,String authToken) async {
  var maritalStatusDao=MaritalStatusDao(adapter);
  var status;
  await http.get('$url/marital-states?size=$TOWN_FETCH_SIZE',headers: {'Authorization': 'Bearer $authToken', 'Content-Type':'application/json'}).then((value){
    if(value.statusCode==200){
      var states=json.decode(value.body)['content'];
      for(Map map in states){
        maritalStatusDao.insertFromEhr(map);
      }
      status='DONE';
    } else {
      log.i(value);
      status='FAILED';
    }
  }).catchError((error){
    log.i(error);
  });
  return status;
}

Future<String> fetchCountries(SqfliteAdapter adapter,String url,String authToken) async {
  var dao=CountryDao(adapter);
  var status;
  await http.get('$url/countries?size=$TOWN_FETCH_SIZE',headers: {'Authorization': 'Bearer $authToken', 'Content-Type':'application/json'}).then((value){
    if(value.statusCode==200){
      var values=json.decode(value.body)['content'];
      for(Map map in values){
        dao.insertFromEhr(map);
      }
      status='DONE';
    } else {
      log.i(value);
      status='FAILED';
    }
  }).catchError((error){
    log.i(error);
  });
  return status;
}

Future<String> fetchNationalities(SqfliteAdapter adapter,String url,String authToken) async {
  var dao=NationalityDao(adapter);
  var status;
  await http.get('$url/nationalities?size=$TOWN_FETCH_SIZE',headers: {'Authorization': 'Bearer $authToken', 'Content-Type':'application/json'}).then((value){
    if(value.statusCode==200){
      var values=json.decode(value.body)['content'];
      for(Map map in values){
        dao.insertFromEhr(map);
      }
      status='DONE';
    } else {
      log.i(value);
      status='FAILED';
    }
  }).catchError((error){
    log.i(error);
  });
  return status;
}

Future<String> fetchOccupations(SqfliteAdapter adapter,String url,String authToken) async {
  var dao=OccupationDao(adapter);
  var status;
  await http.get('$url/occupations?size=$TOWN_FETCH_SIZE',headers: {'Authorization': 'Bearer $authToken', 'Content-Type':'application/json'}).then((value){
    if(value.statusCode==200){
      var values=json.decode(value.body)['content'];
      for(Map map in values){
        dao.insertFromEhr(map);
      }
      status='DONE';
    } else {
      log.i(value);
      status='FAILED';
    }
  }).catchError((error){
    log.i(error);
  });
  return status;
}


