


import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'MetaDao.dart';

class DiagnosisDao extends MetaDao{

  DiagnosisDao(SqfliteAdapter adapter) : super(adapter);

  @override
  String get tableName => 'Diagnosis';

}