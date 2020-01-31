
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import 'MetaDao.dart';

class LactatingStatusDao extends MetaDao {
  LactatingStatusDao(SqfliteAdapter adapter) : super(adapter);

  @override
  String get tableName => 'LactatingStatus';

}