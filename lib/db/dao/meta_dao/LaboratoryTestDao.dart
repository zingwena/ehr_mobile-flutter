

import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'MetaDao.dart';

class LaboratoryTestDao extends MetaDao{

  LaboratoryTestDao(SqfliteAdapter adapter) : super(adapter);

  @override
  String get tableName => 'LaboratoryTest';

}