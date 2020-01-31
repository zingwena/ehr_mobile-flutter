


import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'MetaDao.dart';

class SamplesDao extends MetaDao{

  SamplesDao(SqfliteAdapter adapter) : super(adapter);

  @override
  String get tableName => 'Sample';

}