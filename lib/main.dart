import 'package:ehr_mobile/graphql/graphQLConf.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'landing_screen.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

void main() => runApp(
    //EhrMobileApp()
  GraphQLProvider(
    client: graphQLConfiguration.getClient(),
    child: CacheProvider(child: EhrMobileApp()),
  ),

);



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
      home: LandingScreen(),
    );
  }
}