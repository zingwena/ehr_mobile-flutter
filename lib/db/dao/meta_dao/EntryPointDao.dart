

import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'MetaDao.dart';

class EntryPointDao extends MetaDao{

  EntryPointDao(SqfliteAdapter adapter) : super(adapter);

  @override
  String get tableName => 'EntryPoint';

}