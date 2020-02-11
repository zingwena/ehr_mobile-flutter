

import 'package:ehr_mobile/db/dao/meta_dao/MetaDao.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:jaguar_query_sqflite/src/adapter.dart';

class FollowUpReasonDao extends MetaDao {

  FollowUpReasonDao(SqfliteAdapter adapter) : super(adapter);

  @override
  String get tableName => 'FollowUpReason';

}