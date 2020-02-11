import 'dart:convert';

import 'package:ehr_mobile/db/dao/meta_dao/ArtReasonDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/ArtStatusDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/ArtVisitStatusDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/ArtVisitTypeDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/ArvCombinationRegimenDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/AuthorityDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/DiagnosisDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/DisclosureMethodsDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/EducationLevelsDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/EntryPointDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/FacilityDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/FacilityQueueDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/FacilityWardDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/FamilyPlanningStatusDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/FollowUpReasonDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/FollowUpStatusDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/FunctionalStatusDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/HtsModelsDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/InvestigationDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/InvestigationResultDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/InvestigationTestkitDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/IptReasonDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/IptStatusDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/LaboratoryResultDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/LaboratoryTestDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/LactatingStatusDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/MedicineNameDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/MetaDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/PurposeOfTestsDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/QuestionCategoryDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/QuestionDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/ReasonForNotIssuingResultDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/ReligionDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/SamplesDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/SiteSettingDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/TestKitBatchIssueDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/TestKitLevelDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/TestKitsDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/TestingPlanDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/UserDao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/country_dao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/marital_status_dao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/nationality_dao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/occupation_dao.dart';
import 'package:ehr_mobile/db/dao/meta_dao/town_dao.dart';
import 'package:ehr_mobile/db/db_helper.dart';
import 'package:ehr_mobile/graphql/queue_query.dart';
import 'package:ehr_mobile/graphql/site_query.dart';
import 'package:ehr_mobile/graphql/ward_query.dart';
import 'package:ehr_mobile/main.dart';
import 'package:ehr_mobile/model/followupreason.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/util/logger.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:progress_dialog/progress_dialog.dart';


Future<String> pullSiteData() async {
  SiteQuery queryMutation = SiteQuery();
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
    var siteDao = SiteSettingDao(adapter);
    siteDao.removeAll();
    var map = await result.data["site"];
      siteDao.insertFromEhr(map);
  }
  return "$DONE_STATUS";
}




Future<String> pullQueueData(ProgressDialog progressDialog) async{
  QueueQuery query = QueueQuery();
  var ip = await retrieveString(SERVER_IP);
  GraphQLClient _client = graphQLConfiguration.clientToQuery(ip);
  QueryResult result = await _client.query(
    QueryOptions(
      document: query.getAll(),
    ),
  );

  if (!result.hasErrors) {
    var dbHandler = DatabaseHelper();
    var adapter = await dbHandler.getAdapter();
    var facilityQueueDao = FacilityQueueDao(adapter);
    var testKitBatchIssueDao= TestKitBatchIssueDao(adapter);
    await testKitBatchIssueDao.removeAll();
    await facilityQueueDao.removeAll();
    var wards = await result.data["queues"]['content'];
    for (Map map in wards) {
      //progressDialog.update(message:'Fetching Queue: ${map['queue']['name']} data ...');
      await facilityQueueDao.insertFromEhr(map['queueId'],map['queue']['id'],
          map['queue']['name'],map['department']['id'],map['department']['name'], 0);
      for(Map kit in map['currentTestKits']['content']){
        await testKitBatchIssueDao.insertFromEhr(kit, map['queue']['name'], map['queue']['id']);
      }
    }
  }
  return "$DONE_STATUS";
}

Future<String> pullWardData() async {
  WardQuery queryMutation = WardQuery();
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
    var facilityWardDao = FacilityWardDao(adapter);
    facilityWardDao.removeAll();
    var wards = await result.data["wards"]['content'];
    for (Map map in wards) {
      facilityWardDao.insertFromEhr(map['wardId'],map['ward']['id'],
          map['ward']['name'],map['department']['id'],map['department']['name'], 0);

    }
  }
  return "$DONE_STATUS";
}

Future<String> pullMetaData(ProgressDialog progressDialog,String url, String authToken) async {
  var dbHandler = DatabaseHelper();
  var adapter = await dbHandler.getAdapter();
  await initDb(adapter);

  progressDialog.update(message: 'Fetching Users...');
  await fetchUsers(adapter,url,authToken);

  progressDialog.update(message: 'Fetching Towns...');
  await fetchTowns(adapter, url, authToken);

  progressDialog.update(message: 'Fetching Marital Status...');
  await fetchMaritalStatus(adapter, url, authToken);

  progressDialog.update(message: 'Fetching Countries...');
  await fetchCountries(adapter, url, authToken);

  progressDialog.update(message: 'Fetching Nationalities...');
  await fetchNationalities(adapter, url, authToken);

  progressDialog.update(message: 'Fetching Occupations...');
  await fetchOccupations(adapter, url, authToken);

  progressDialog.update(message: 'Fetching Facilities...');
  await fetchFacilities(adapter, url, authToken);

  progressDialog.update(message: 'Fetching Religions...');
  await fetchReligions(adapter, url, authToken);

  progressDialog.update(message: 'Fetching Education Levels...');
  await fetchMeta(
      EducationLevelsDao(adapter), '$url/education-levels', authToken);

  progressDialog.update(message: 'Fetching Entry Points...');
  await fetchMeta(EntryPointDao(adapter), '$url/entryPoints', authToken);

  progressDialog.update(message: 'Fetching Hts Models...');
  await fetchMeta(HtsModelsDao(adapter), '$url/hts-models', authToken);

  progressDialog.update(message: 'Fetching Reason For Not Issuing Results...');
  await fetchMeta(ReasonForNotIssuingResultDao(adapter),
      '$url/reason-for-not-issuing-results', authToken);

  progressDialog.update(message: 'Fetching Purpose Of Tests...');
  await fetchMeta(PurposeOfTestsDao(adapter), '$url/purpose-of-tests', authToken);

  progressDialog.update(message: 'Fetching Test Kits...');
  await fetchTestKits(adapter, url, authToken);

  progressDialog.update(message: 'Fetching Test Kits Levels...');
  await fetchTestKitsLevels(adapter, url, authToken);

  progressDialog.update(message: 'Fetching Laboratory Test...');
  await fetchMeta(LaboratoryTestDao(adapter), '$url/laboratory-tests', authToken);

  progressDialog.update(message: 'Fetching Samples...');
  await fetchMeta(SamplesDao(adapter), '$url/samples', authToken);

  progressDialog.update(message: 'Fetching Diagnosis...');
  await fetchMeta(DiagnosisDao(adapter), '$url/diagnoses', authToken);

  progressDialog.update(message: 'Fetching Diagnosis...');
  await fetchInvestigations(adapter, url, authToken);

  progressDialog.update(message: 'Fetching Diagnosis...');
  await fetchQuestionCategory(adapter,url,authToken);

  progressDialog.update(message: 'Fetching Questions...');
  await fetchQuestions(adapter,url,authToken);

  progressDialog.update(message: 'Fetching Investigation Test Kits...');
  await fetchInvestigationTestKits(adapter,url,authToken);

  progressDialog.update(message: 'Fetching Investigation Results...');
  await fetchInvestigationResults(adapter, url, authToken);

  progressDialog.update(message: 'Fetching Laboratory Result...');
  await fetchMeta(LaboratoryResultDao(adapter), '$url/lab-results', authToken);

  progressDialog.update(message: 'Fetching Art Status...');
  await fetchMeta(ArtStatusDao(adapter), '$url/art-statuses', authToken);

  progressDialog.update(message: 'Fetching Art Reasons...');
  await fetchArtReasons(adapter, url, authToken);

  progressDialog.update(message: 'Fetching Arv Combination Regimens...');
  await fetchArvCombinationRegimens(adapter, url,authToken);

  progressDialog.update(message: 'Fetching Disclosure Methods...');
  await fetchDisclosureMethods(adapter,url,authToken);

  progressDialog.update(message: 'Fetching Testing Plans...');
  await fetchTestingPlans(adapter, url, authToken);

  progressDialog.update(message: 'Fetching Ward Data...');
  await pullWardData();

  progressDialog.update(message: 'Fetching Queue Data...');
  await pullQueueData(progressDialog);

  progressDialog.update(message: 'Fetching Site Data...');
  await pullSiteData();

  progressDialog.update(message: 'Fetching Functional Status...');
  await fetchMeta(FunctionalStatusDao(adapter), '$url/functional-statuses', authToken);

  progressDialog.update(message: 'Fetching Follow Status...');
  await fetchMeta(FollowUpStatusDao(adapter), '$url/follow-up-statuses', authToken);

  progressDialog.update(message: 'Fetching Family Planning Status...');
  await fetchMeta(FamilyPlanningStatusDao(adapter), '$url/family-planning-statuses', authToken);

  progressDialog.update(message: 'Fetching Lactating Status...');
  await fetchMeta(LactatingStatusDao(adapter), '$url/lactating-statuses', authToken);

  progressDialog.update(message: 'Fetching Medicine Names...');
  await fetchMedicineNames(adapter,url,authToken);

  progressDialog.update(message: 'Fetching Art Visit Types...');
  await fetchMeta(ArtVisitTypeDao(adapter), '$url/art-visit-types', authToken);

  progressDialog.update(message: 'Fetching ArtV isit Status...');
  await fetchMeta(ArtVisitStatusDao(adapter), '$url/art-visit-statuses', authToken);

  progressDialog.update(message: 'Fetching Ipt Reason...');
  await fetchMeta(IptReasonDao(adapter), '$url/ipt-reasons', authToken);

  progressDialog.update(message: 'Fetching Ipt Status...');
  await fetchMeta(IptStatusDao(adapter), '$url/ipt-statuses', authToken);

  progressDialog.update(message: 'Fetching Follow Up Reasons...');
  await fetchMeta(FollowUpReasonDao(adapter), '$url/follow-up-reasons', authToken);

  var status='$DONE_STATUS';
  return status;
}

Future<String> initDb(SqfliteAdapter adapter) async {
  var status;

  //await PersonDao(adapter).removeAll();
  //await AuthorityDao(adapter).removeAll();
  await FollowUpReasonDao(adapter).removeAll();
  await UserDao(adapter).removeAll();
  await TownDao(adapter).removeAll();

  await MaritalStatusDao(adapter).removeAll();

  await CountryDao(adapter).removeAll();

  await NationalityDao(adapter).removeAll();

  await OccupationDao(adapter).removeAll();

  await FacilityDao(adapter).removeAll();

  await ReligionDao(adapter).removeAll();

  await EducationLevelsDao(adapter).removeAll();

  await EntryPointDao(adapter).removeAll();

  await HtsModelsDao(adapter).removeAll();

  await HtsModelsDao(adapter).removeAll();

  await ReasonForNotIssuingResultDao(adapter).removeAll();

  await PurposeOfTestsDao(adapter).removeAll();

  await TestKitsDao(adapter).removeAll();

  await TestKitLevelDao(adapter).removeAll();

  await LaboratoryTestDao(adapter).removeAll();
  await SamplesDao(adapter).removeAll();
  await DiagnosisDao(adapter).removeAll();

  await InvestigationDao(adapter).removeAll();

  await QuestionCategoryDao(adapter).removeAll();

  await QuestionDao(adapter).removeAll();

  await InvestigationTestkitDao(adapter).removeAll();

  await InvestigationResultDao(adapter).removeAll();

  await LaboratoryResultDao(adapter).removeAll();
  await ArtStatusDao(adapter).removeAll();
  await ArtReasonDao(adapter).removeAll();
  await ArvCombinationRegimenDao(adapter).removeAll();
  await DisclosureMethodDao(adapter).removeAll();
  await TestingPlanDao(adapter).removeAll();

  await FunctionalStatusDao(adapter).removeAll();
  await FollowUpStatusDao(adapter).removeAll();
  await FamilyPlanningStatusDao(adapter).removeAll();
  await LactatingStatusDao(adapter).removeAll();
  await MedicineNameDao(adapter).removeAll();

  await ArtVisitTypeDao(adapter).removeAll();

  await ArtVisitStatusDao(adapter).removeAll();

  await IptReasonDao(adapter).removeAll();

  await IptStatusDao(adapter).removeAll();

  status = '$DONE_STATUS';
  return status;
}

Future<String> fetchUsers(SqfliteAdapter adapter, String url, String authToken) async {
  var dao = UserDao(adapter);
  var authDao=AuthorityDao(adapter);
  var status;
  await http.get('$url/users?size=$TOWN_FETCH_SIZE', headers: {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json'
  }).then((value) {
    if (value.statusCode == 200) {
      var users = json.decode(value.body);
      for (Map map in users) {
        dao.insertFromEhr(map);
        for(String auth in map['authorities']){
          authDao.insertFromEhr(map['id'],auth);
        }
      }
      status = '$DONE_STATUS';
    } else {
      log.i(value);
      status = '$FAILED_STATUS';
    }
  }).catchError((error) {
    log.i(error);
  });
  return status;
}

Future<String> fetchTowns(
    SqfliteAdapter adapter, String url, String authToken) async {
  var townDao = TownDao(adapter);
  var status;
  await http.get('$url/towns?size=$TOWN_FETCH_SIZE', headers: {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json'
  }).then((value) {
    if (value.statusCode == 200) {
      var towns = json.decode(value.body)['content'];
      for (Map map in towns) {
        townDao.insertFromEhr(map);
      }
      status = '$DONE_STATUS';
    } else {
      log.i(value);
      status = '$FAILED_STATUS';
    }
  }).catchError((error) {
    log.i(error);
  });
  return status;
}

Future<String> fetchMaritalStatus(
    SqfliteAdapter adapter, String url, String authToken) async {
  var maritalStatusDao = MaritalStatusDao(adapter);
  var status;
  await http.get('$url/marital-states?size=$TOWN_FETCH_SIZE', headers: {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json'
  }).then((value) {
    if (value.statusCode == 200) {
      var states = json.decode(value.body)['content'];
      for (Map map in states) {
        maritalStatusDao.insertFromEhr(map);
      }
      status = '$DONE_STATUS';
    } else {
      log.i(value);
      status = '$FAILED_STATUS';
    }
  }).catchError((error) {
    log.i(error);
  });
  return status;
}

Future<String> fetchCountries(
    SqfliteAdapter adapter, String url, String authToken) async {
  var dao = CountryDao(adapter);
  var status;
  await http.get('$url/countries?size=$TOWN_FETCH_SIZE', headers: {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json'
  }).then((value) {
    if (value.statusCode == 200) {
      var values = json.decode(value.body)['content'];
      for (Map map in values) {
        dao.insertFromEhr(map);
      }
      status = '$DONE_STATUS';
    } else {
      log.i(value);
      status = '$FAILED_STATUS';
    }
  }).catchError((error) {
    log.i(error);
  });
  return status;
}

Future<String> fetchNationalities(
    SqfliteAdapter adapter, String url, String authToken) async {
  var dao = NationalityDao(adapter);
  var status;
  await http.get('$url/nationalities?size=$TOWN_FETCH_SIZE', headers: {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json'
  }).then((value) {
    if (value.statusCode == 200) {
      var values = json.decode(value.body)['content'];
      for (Map map in values) {
        dao.insertFromEhr(map);
      }
      status = '$DONE_STATUS';
    } else {
      log.i(value);
      status = '$FAILED_STATUS';
    }
  }).catchError((error) {
    log.i(error);
  });
  return status;
}

Future<String> fetchOccupations(
    SqfliteAdapter adapter, String url, String authToken) async {
  var dao = OccupationDao(adapter);
  var status;
  await http.get('$url/occupations?size=$TOWN_FETCH_SIZE', headers: {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json'
  }).then((value) {
    if (value.statusCode == 200) {
      var values = json.decode(value.body)['content'];
      for (Map map in values) {
        dao.insertFromEhr(map);
      }
      status = '$DONE_STATUS';
    } else {
      log.i(value);
      status = '$FAILED_STATUS';
    }
  }).catchError((error) {
    log.i(error);
  });
  return status;
}

Future<String> fetchFacilities(
    SqfliteAdapter adapter, String url, String authToken) async {
  var dao = FacilityDao(adapter);
  var status;
  await http.get('$url/facilities?size=$TOWN_FETCH_SIZE', headers: {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json'
  }).then((value) {
    if (value.statusCode == 200) {
      var values = json.decode(value.body)['content'];
      for (Map map in values) {
        dao.insertFromEhr(map);
      }
      status = '$DONE_STATUS';
    } else {
      log.i(value);
      status = '$FAILED_STATUS';
    }
  }).catchError((error) {
    log.i(error);
  });
  return status;
}

Future<String> fetchReligions(
    SqfliteAdapter adapter, String url, String authToken) async {
  var dao = ReligionDao(adapter);
  var status;
  await http.get('$url/religions?size=$TOWN_FETCH_SIZE', headers: {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json'
  }).then((value) {
    if (value.statusCode == 200) {
      var values = json.decode(value.body)['content'];
      for (Map map in values) {
        dao.insertFromEhr(map);
      }
      status = '$DONE_STATUS';
    } else {
      log.i(value);
      status = '$FAILED_STATUS';
    }
  }).catchError((error) {
    log.i(error);
  });
  return status;
}

Future<String> fetchMeta(MetaDao dao, String url, String authToken) async {
  var status;
  await http.get('$url?size=$TOWN_FETCH_SIZE', headers: {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json'
  }).then((value) {
    if (value.statusCode == 200) {
      var values = json.decode(value.body)['content'];
      for (Map map in values) {
        dao.insertFromEhr(map);
      }
      status = '$DONE_STATUS';
    } else {
      log.i(value);
      status = '$FAILED_STATUS';
    }
  }).catchError((error) {
    log.i(error);
  });
  return status;
}

Future<String> fetchTestKits(adapter, url, authToken) async {
  var dao = TestKitsDao(adapter);
  var status;
  await http.get('$url/test-kits?size=$TOWN_FETCH_SIZE', headers: {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json'
  }).then((value) {
    if (value.statusCode == 200) {
      var values = json.decode(value.body)['content'];
      for (Map map in values) {
        dao.insertFromEhr(map);
      }
      status = '$DONE_STATUS';
    } else {
      log.i(value);
      status = '$FAILED_STATUS';
    }
  }).catchError((error) {
    log.i(error);
  });
  return status;
}

Future<String> fetchTestKitsLevels(adapter, url, authToken) async {
  var dao = TestKitLevelDao(adapter);
  var status;
  var testLevels = [
    'FIRST',
    'SECOND',
    'THIRD',
    'PARALLEL_ONE',
    'PARALLEL_TWO',
    'SELF',
    'DNA_PCR'
  ];

  testLevels.asMap().forEach((index, testLevel) => {
        http.get('$url/test-kits/test-level/$testLevel', headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json'
        }).then((value) {
          if (value.statusCode == 200) {
            var values = json.decode(value.body);
            for (Map map in values) {
              dao.insertFromEhr(map['code'], testLevel);
            }
            status = '$DONE_STATUS';
          } else {
            status = '$FAILED_STATUS';
          }
        }).catchError((error) {
          log.e(error);
        })
      });
  return status;
}

Future<String> fetchInvestigations(adapter, url, authToken) async {
  var dao = InvestigationDao(adapter);
  var status;
  await http.get('$url/investigations?size=$TOWN_FETCH_SIZE', headers: {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json'
  }).then((value) {
    if (value.statusCode == 200) {
      var values = json.decode(value.body)['content'];
      for (Map map in values) {
        dao.insertFromEhr(map);
      }
      status = '$DONE_STATUS';
    } else {
      log.i(value);
      status = '$FAILED_STATUS';
    }
  }).catchError((error) {
    log.i(error);
  });
  return status;
}

Future<String> fetchQuestionCategory(adapter, url, authToken) async {
  var dao = QuestionCategoryDao(adapter);
  var status;
  await http.get('$url/question-categories-other-clients?size=$TOWN_FETCH_SIZE', headers: {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json'
  }).then((value) {
    if (value.statusCode == 200) {
      var values = json.decode(value.body)['content'];
      for (Map map in values) {
        dao.insertFromEhr(map);
      }
      status = '$DONE_STATUS';
    } else {
      log.i(value);
      status = '$FAILED_STATUS';
    }
  }).catchError((error) {
    log.i(error);
  });
  return status;
}

Future<String> fetchQuestions(adapter, url, authToken) async {
  var dao = QuestionDao(adapter);
  var status;
  await http.get('$url/questions?size=$TOWN_FETCH_SIZE', headers: {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json'
  }).then((value) {
    if (value.statusCode == 200) {
      var values = json.decode(value.body);
      for (Map map in values['content']) {
        dao.insertFromEhr(map).catchError((error){
          log.e(error);
        });
      }
      status = '$DONE_STATUS';
    } else {
      log.i(value);
      status = '$FAILED_STATUS';
    }
  }).catchError((error) {
    log.i(error);
  });
  return status;
}

Future<String> fetchInvestigationTestKits(adapter, url, authToken) async {
  var dao = InvestigationTestkitDao(adapter);
  var status;
  await http.get('$url/investigations/get-all-test-kits?size=$TOWN_FETCH_SIZE', headers: {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json'
  }).then((value) {
    if (value.statusCode == 200) {
      var values = json.decode(value.body);
      for (Map map in values['content']) {
        dao.insertFromEhr(map).catchError((error){
          log.e(error);
        });
      }
      status = '$DONE_STATUS';
    } else {
      log.i(value);
      status = '$FAILED_STATUS';
    }
  }).catchError((error) {
    log.i(error);
  });
  return status;
}

Future<String> fetchInvestigationResults(adapter, url, authToken) async {
  var dao = InvestigationResultDao(adapter);
  var status;
  await http.get('$url/investigations/result?size=$TOWN_FETCH_SIZE', headers: {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json'
  }).then((value) {
    if (value.statusCode == 200) {
      var values = json.decode(value.body);
      for (Map map in values['content']) {
        dao.insertFromEhr(map).catchError((error){
          log.e(error);
        });
      }
      status = '$DONE_STATUS';
    } else {
      log.i(value);
      status = '$FAILED_STATUS';
    }
  }).catchError((error) {
    log.i(error);
  });
  return status;
}

Future<String> fetchArtReasons(adapter, url, authToken) async {
  var dao = ArtReasonDao(adapter);
  var status;
  await http.get('$url/art-reasons?size=$TOWN_FETCH_SIZE', headers: {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json'
  }).then((value) {
    if (value.statusCode == 200) {
      var values = json.decode(value.body);
      for (Map map in values['content']) {
        dao.insertFromEhr(map).catchError((error){
          log.e(error);
        });
      }
      status = '$DONE_STATUS';
    } else {
      log.i(value);
      status = '$FAILED_STATUS';
    }
  }).catchError((error) {
    log.i(error);
  });
  return status;
}

Future<String> fetchArvCombinationRegimens(adapter, url, authToken) async {
  var dao = ArvCombinationRegimenDao(adapter);
  var status;
  await http.get('$url/arv-combination-regimens-for-export?size=$TOWN_FETCH_SIZE', headers: {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json'
  }).then((value) {
    if (value.statusCode == 200) {
      var values = json.decode(value.body);
      for (Map map in values['content']) {
        dao.insertFromEhr(map).catchError((error){
          log.e(error);
        });
      }
      status = '$DONE_STATUS';
    } else {
      log.i(value);
      status = '$FAILED_STATUS';
    }
  }).catchError((error) {
    log.i(error);
  });
  return status;
}

Future<String> fetchDisclosureMethods(adapter, url, authToken) async {
  var dao = DisclosureMethodDao(adapter);
  var status;
  await http.get('$url/disclosure-methods?size=$TOWN_FETCH_SIZE', headers: {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json'
  }).then((value) {
    if (value.statusCode == 200) {
      var values = json.decode(value.body);
      for (Map map in values['content']) {
        dao.insertFromEhr(map).catchError((error){
          log.e(error);
        });
      }
      status = '$DONE_STATUS';
    } else {
      log.i(value);
      status = '$FAILED_STATUS';
    }
  }).catchError((error) {
    log.i(error);
  });
  return status;
}

Future<String> fetchTestingPlans(adapter, url, authToken) async {
  var dao = TestingPlanDao(adapter);
  var status;
  await http.get('$url/testing-plans?size=$TOWN_FETCH_SIZE', headers: {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json'
  }).then((value) {
    if (value.statusCode == 200) {
      var values = json.decode(value.body);
      for (Map map in values['content']) {
        dao.insertFromEhr(map).catchError((error){
          log.e(error);
        });
      }
      status = '$DONE_STATUS';
    } else {
      log.i(value);
      status = '$FAILED_STATUS';
    }
  }).catchError((error) {
    log.i(error);
  });
  return status;
}

Future<String> fetchMedicineNames(adapter,url,authToken) async {
  var dao = MedicineNameDao(adapter);
  var status;
  await http.get('$url/medicine-names?size=$TOWN_FETCH_SIZE', headers: {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json'
  }).then((value) {
    if (value.statusCode == 200) {
      var values = json.decode(value.body);
      for (Map map in values['content']) {
        dao.insertFromEhr(map).catchError((error){
          log.e(error);
        });
      }
      status = '$DONE_STATUS';
    } else {
      log.i(value);
      status = '$FAILED_STATUS';
    }
  }).catchError((error) {
    log.i(error);
  });
  return status;
}

