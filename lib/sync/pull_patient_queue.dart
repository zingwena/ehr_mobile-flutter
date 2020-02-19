


import 'package:ehr_mobile/db/dao/PatientQueueDao.dart';
import 'package:ehr_mobile/db/db_helper.dart';
import 'package:ehr_mobile/graphql/PatientQueQuery.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/util/logger.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../main.dart';

Future<String> fetchPatientQueue() async {
  PatientQueQuery queryMutation = PatientQueQuery();
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
    var queDao = PatientQueueDao(adapter);
    await queDao.removeAll();
    var queues = await result.data['queues']['content'];
    for (Map queue in queues) {
      var queueId=queue['queue']['id'];
      var queueName=queue['queue']['name'];
      for(Map patient in queue['patients']['content']){
        queDao.insertFromEhr(queueId,queueName,patient['patientId']);
      }

    }
  }
  return "$DONE_STATUS";
}
