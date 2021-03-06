
import 'package:ehr_mobile/db/tables/hts/hts_table.dart';
import 'package:ehr_mobile/model/enums/enums.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
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

  Future insertFromEhr(Map map,String ehrPersonId, String patientId,String labInvestigationId) async {

    Insert inserter = new Insert(tableName);
    inserter.set(personId,ehrPersonId);
    inserter.set(id, map['htsId']);
    inserter.set(visitId, patientId);
    map['htsType']!=null ? inserter.set(htsType, map['htsType']):inserter.set(htsType, 'PITC');
    inserter.set(laboratoryInvestigationId, labInvestigationId);
    inserter.set(dateOfHivTest,const CustomDateTimeConverter().fromEhrJson(map['dateOfHivTest']));
    if (map['entryPoint'] != null) {
      inserter.set(entryPointId,map['entryPoint']['id']);
    }
    inserter.set(htsApproach,map['approach']);

    if(map['purpose']!=null){
      inserter.set(reasonForHivTestingId,map['purpose']['id']);
    }
    if(map['model']!=null){
      inserter.set(htsModelId,map['model']['id']);
    }

    map['preTestInformationGiven']!=null
        ? inserter.set(preTestInformationGiven,map['preTestInformationGiven']):
    inserter.set(preTestInformationGiven,false);

    map['firstHivTest']!=null? inserter.set(newTestInClientLife,map['firstHivTest']):inserter.set(newTestInClientLife,true);
    //inserter.set(newTestPregLact,map['testForPregnancy']); //TODO needs clarification

    map['coupleCounselling']!=null?inserter.set(coupleCounselling,map['coupleCounselling']):inserter.set(coupleCounselling,false);
    inserter.set(optOutOfTest,map['optOut']);
    inserter.set(resultReceived,map['resultsIssued']);
    if(map['reasonForNotIssuingResult']!=null){
      inserter.set(reasonForNotIssuingResultId,map['reasonForNotIssuingResult']['id']);
    }

    map['postTestCounselling']!=null ? inserter.set(postTestCounselled,map['postTestCounselling'])
        :inserter.set(postTestCounselled,true);

    if(map['postDateCounselled']!=null){
      inserter.set(datePostTestCounselled,const CustomDateTimeConverter().fromEhrJson(map['postDateCounselled']));
    }
    map['consentToIndexTesting']!=null? inserter.set(consentToIndexTesting, map['consentToIndexTesting']):
    inserter.set(consentToIndexTesting, true);
    inserter.set(status, 'IMPORTED');
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}