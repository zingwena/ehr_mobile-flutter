
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import 'base_dao.dart';

class VitalBaseDao extends BaseDao{

  var visitId=StrField('visitId');
  var personId=StrField('personId');
  var dateTime=StrField('dateTime');

}