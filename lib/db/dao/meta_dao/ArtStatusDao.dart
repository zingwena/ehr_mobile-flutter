

import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import 'MetaDao.dart';

class ArtStatusDao extends MetaDao{
  ArtStatusDao(SqfliteAdapter adapter) : super(adapter);

  @override
  String get tableName => 'ArtStatus';

}