
import 'package:ehr_mobile/db/tables/hts/hts_table.dart';
import 'package:ehr_mobile/util/logger.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

class HtsDao {
  var id= new StrField('id');
  var personId= new StrField('personId');
  var visitId= new StrField('visitId');
  var htsType= new StrField('htsType');
  var laboratoryInvestigationId= new StrField('laboratoryInvestigationId');
  var dateOfHivTest= new StrField('dateOfHivTest');
  var entryPointId= new StrField('entryPointId');
  var htsApproach= new StrField('htsApproach');
  var reasonForHivTestingId= new StrField('reasonForHivTestingId');
  var htsModelId= new StrField('htsModelId');

  var preTestInformationGiven= new IntField('preTestInformationGiven');
  var newTestInClientLife= new IntField('newTestInClientLife');
  var newTestPregLact= new IntField('newTestPregLact');
  var coupleCounselling= new IntField('coupleCounselling');
  var optOutOfTest= new IntField('optOutOfTest');
  var resultReceived= new IntField('resultReceived');

  var reasonForNotIssuingResultId= new StrField('reasonForNotIssuingResultId');
  var postTestCounselled= new StrField('postTestCounselled');
  var datePostTestCounselled= new DateTimeField('datePostTestCounselled');
  var status = new IntField('status');

  var consentToIndexTesting= new IntField('consentToIndexTesting');
  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'Hts';
  HtsDao(SqfliteAdapter _adapter){
    this._adapter =_adapter;
  }

  Future<int> setSyncd(String personId) async {
    Update updater = new Update(tableName);
    updater.where(this.personId.eq(personId));
    updater.set(this.status, '2');
    var result=await _adapter.update(updater);
    return result;
  }

  /// Finds one Hts by [id]
  Future<HtsTable> findOne(String personId) async {
    Find param = new Find(tableName);
    param.where(this.id.eq(personId));
    Map map = await _adapter.findOne(param);
    var hts = HtsTable.fromJson(map);
    return hts;
  }

  /// Finds one Hts by [personId]
  Future<HtsTable> findByPersonId(String personId) async {
    Find param = new Find(tableName);
    param.where(this.personId.eq(personId));
    Map map = await _adapter.findOne(param);
    var hts;
    if(map!=null){
       hts= HtsTable.fromJson(map);
    }
    return hts;
  }


}