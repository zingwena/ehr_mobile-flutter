import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";

class GraphQLConfiguration {

  getClient() {
    var uri="/api/graphql";
    Link link = HttpLink(uri: uri);
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      ),
    );
    return client;
  }

 GraphQLClient clientToQuery(String ip) {
    //var ip=await retrieveString(SERVER_IP);
    var uri="${ip}/api/graphql";
    HttpLink httpLink = HttpLink(uri: uri);

    AuthLink authLink = AuthLink(
      getToken: () async => retrieveString(AUTH_TOKEN),
    );

    Link link = authLink.concat(httpLink);
    return GraphQLClient(
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      link: link,
    );
  }
}