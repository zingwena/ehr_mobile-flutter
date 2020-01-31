

import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'MetaDao.dart';

class HtsModelsDao extends MetaDao{

  HtsModelsDao(SqfliteAdapter adapter) : super(adapter);

  @override
  String get tableName => 'HtsModel';

}