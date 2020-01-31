
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import 'MetaDao.dart';

class FollowUpStatusDao extends MetaDao{
  FollowUpStatusDao(SqfliteAdapter adapter) : super(adapter);

  SqfliteAdapter _adapter;

  @override
  String get tableName => 'FollowUpStatus';

}