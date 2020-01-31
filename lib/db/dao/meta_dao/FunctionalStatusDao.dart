
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import 'MetaDao.dart';

class FunctionalStatusDao extends MetaDao {
  FunctionalStatusDao(SqfliteAdapter adapter) : super(adapter);

  @override
  String get tableName => 'FunctionalStatus';

}