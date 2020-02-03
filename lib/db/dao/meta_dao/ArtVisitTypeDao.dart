

import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import 'MetaDao.dart';

class ArtVisitTypeDao extends MetaDao {

  ArtVisitTypeDao(SqfliteAdapter adapter) : super(adapter);

  @override
  String get tableName => 'ArtVisitType';

}