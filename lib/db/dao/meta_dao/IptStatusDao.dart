
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'MetaDao.dart';

class IptStatusDao extends MetaDao{

  IptStatusDao(SqfliteAdapter adapter) : super(adapter);

  @override
  String get tableName => 'IptStatus';

}