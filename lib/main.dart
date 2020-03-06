import 'dart:convert';

import 'package:cron/cron.dart';
import 'package:ehr_mobile/db/dao/visit_dao.dart';
import 'package:ehr_mobile/db/db_helper.dart';
import 'package:ehr_mobile/db/tables/visit_table.dart';
import 'package:ehr_mobile/graphql/graphQLConf.dart';
import 'package:ehr_mobile/model/discharge_patient.dart';
import 'package:ehr_mobile/util/discharge_patient_process.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'landing_screen.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
const visitChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/visitChannel');

void main() {
  var cron = new Cron();

  var dbHandler = DatabaseHelper();
  final now = DateTime.now();
  final lastMidnight = new DateTime(now.year, now.month, now.day);
  final lastMidNightMinusOneSecond =
      lastMidnight.subtract(new Duration(minutes: 1));

  cron.schedule(new Schedule.parse('*/60 * * * *'), () async {
    var adapter = await dbHandler.getAdapter();
    var visitDao = VisitDao(adapter);
    var visits = await visitDao.findByTimeAndDischargedNotNull(lastMidnight, lastMidNightMinusOneSecond);
    dischargePatient(visits, lastMidNightMinusOneSecond);

  });

  runApp(
    //EhrMobileApp()
    GraphQLProvider(
      client: graphQLConfiguration.getClient(),
      child: CacheProvider(child: EhrMobileApp()),
    ),
  );
}

class EhrMobileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //fillList();
    return MaterialApp(
      title: 'Impilo Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingScreghen(),
    );
  }
}
