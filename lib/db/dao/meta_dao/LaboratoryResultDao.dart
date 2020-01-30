

import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import 'MetaDao.dart';

class LaboratoryResultDao extends MetaDao{
  LaboratoryResultDao(SqfliteAdapter adapter) : super(adapter);

  @override
  String get tableName => 'Result';

}