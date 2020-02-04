

import 'package:ehr_mobile/db/dao/meta_dao/MetaDao.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

class ArtVisitStatusDao extends MetaDao{

  ArtVisitStatusDao(SqfliteAdapter adapter) : super(adapter);

  @override
  String get tableName => 'ArtVisitStatus';

}