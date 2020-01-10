import 'dart:convert';

import 'package:ehr_mobile/model/dto/testkitbatchdto.dart';
import 'package:ehr_mobile/model/investigation.dart';
import 'package:ehr_mobile/model/laboratoryInvestigationTest.dart';
import 'package:ehr_mobile/model/testkitbatchissue.dart';
import 'package:ehr_mobile/sidebar.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/model/personInvestigation.dart';
import 'package:ehr_mobile/model/result.dart';
import 'package:ehr_mobile/model/testKit.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/view/patient_post_test.dart';
import 'package:ehr_mobile/view/reception_vitals.dart';
import 'package:ehr_mobile/view/recency_result.dart';
import 'package:ehr_mobile/view/htsreg_overview.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/view/hts_registration.dart';
import 'package:ehr_mobile/view/hts_result.dart';
import 'package:ehr_mobile/view/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:intl/intl.dart' show DateFormat;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'sexualhistoryform.dart';
import 'edit_demographics.dart';


class RecencyTest extends StatefulWidget {
  final String personId;
  final String visitId;
  final Person person;
  final String htsId;
  final String indexTestId;
  final HtsRegistration htsRegistration;
  RecencyTest(this.personId, this.visitId, this.person, this.htsId, this.indexTestId, this.htsRegistration);

  @override
  State createState() {
    return _Recency();
  }
}

class _Recency extends State<RecencyTest> {
  final _formKey = GlobalKey<FormState>();
  var selectedDate, selectedStarttime, selectedReadingtime, selectedReadingDate;
  DateTime date, startTime, readingTime,  readingDate;
  HtsRegistration htsRegistration;
  int _result = -1;
  int _testKit = -1;
  int testCount=0;
  int _testKitBatch = -1;
  String id ="1";
  String result_string;
  String labId;
  List<Result>results = List ();
  String testKit = "";
  //Result result = Result.screen();
  DateTime date1;
  DateTime date2;
  DateTime date3;
  Result result = Result('01', 'RTI');
  bool _entryPointIsValid = false;
  bool _formIsValid = true;
  bool _showError = false;
  String labInvestId ;
  String labInvestTestId;
  String _identifier;
  String test;
  String sample_name;
  String investigation_name;
  List<DropdownMenuItem<String>> _identifierDropdownMenuItem;
  String _entryPoint;
  String _testkit_string_response;
  String test_name;
  int recency_count = 0;
  TestKit testKitobj  = TestKit('', '', '', '');
  List test_kits = List();
  List _dropDownListtestkits = List();
  List<TestKit>_testkitslist = List();
  List entryPoints = List();
  List _dropDownListEntryPoints = List();
  List<Result> _entryPointList = List();
  int testkitcount = 0 ;
  String investigationId = "ee7d91fc-b27f-11e8-b121-c48e8faf035b ";
  List _identifierList = [
    "Select Identifier",
    "Passport",
    "Birth Certificate",
    "National Id",
    "Driver's Licence"
  ];
  String __result;
  List __results = List();
  List _radiobuttonResults = List();
  List<Result> _resultList = List();
  String _testkitbatch_string;
  List testkitbatches = List();
  List _dropDownListTestKitBatches = List();
  List<TestKitBatchIssue> _TestkitbatchesList = List();
  String patientBinId;
  String batchIssueId;
  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');

  @override
  void initState()  {
    selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    date = DateTime.now();
    _identifierDropdownMenuItem = getIdentifierDropdownMenuItems();
    _identifier = _identifierDropdownMenuItem[0].value;
    getSampleName();
    getInvestigationName();
    getLabInvestigation(widget.personId);
    getLabTest(widget.personId);
    getResults(investigationId);
    getLabId();
    getTestKitsByInvestigationId(investigationId);
    getHtsRecord(widget.personId);

    super.initState();
  }
   Future<dynamic> getSampleName() async {

    var sample_name;
    try {
      sample_name = await htsChannel.invokeMethod('getRecencySample');
      setState(() {
        this.sample_name=sample_name;
        print('THIs is the sample name returned'+ this.sample_name);
      });
    } catch (e) {
      print("channel failure: '$e'");
    }

  }
  Future<dynamic> getInvestigationName() async {

    var _investigation_name;

    try {
      _investigation_name = await htsChannel.invokeMethod('getRecencyInvestigation');
      setState(() {
        this.investigation_name=_investigation_name;
        print('THIs is the investigation name returned'+ this.investigation_name);
      });
    } catch (e) {
      print("channel failure: '$e'");
    }

  }




  Future<void> getResults(String investigationId) async {
    String response;
    try {
      response = await htsChannel.invokeMethod('getRecencyResults');
      setState(() {
        _entryPoint = response;
        entryPoints = jsonDecode(_entryPoint);
        _dropDownListEntryPoints = Result.mapFromJson(entryPoints);
        print("HHHHHHHHHHHHHHHHHHH results from android in recency"+ _dropDownListEntryPoints.toString());
        _dropDownListEntryPoints.forEach((e) {
          _entryPointList.add(e);
        });
      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }
  Future<void> getLabTest(String personId) async {

    var labtest_name;
    try {
      labtest_name = await htsChannel.invokeMethod('getLabTest', personId);
      setState(() {
        this.test=labtest_name;
      });
    } catch (e) {
      print("channel failure: '$e'");
    }
  }
  Future<void> getLabId() async {
    try {
      Map <String,dynamic> data= json.decode(await htsChannel.invokeMethod('getLabInvestigation')) ;
      var labId= data["labId"];
      var visitPatientId= data["visitPatientId"];
      print("Visit Patient Id : $visitPatientId || Lab Id : $labId"  );

    } catch (e) {
      print("channel failure: '$e'");
    }

  }


  Future<void> getTestKitsByInvestigationId(String investigationId) async {

    try {
      String response = await htsChannel.invokeMethod('getRecencyTestkits', investigationId);
      setState(() {
        _testkit_string_response = response;
        test_kits = jsonDecode(_testkit_string_response);
        _dropDownListtestkits = TestKit.mapFromJson(test_kits);
        _dropDownListtestkits.forEach((e){
          _testkitslist.add(e);
        });

      });
      print("*********sample from android"+_testkitslist.toString());
    } catch (e) {
      print("channel failure: '$e'");
    }

  }
  Future<void>getTestName()async{
    try{
      String response = await htsChannel.invokeMethod('getTestName', labInvestId);
      setState(() {
        test_name = response;

      });

    }catch(e){

    }
  }
  Future<void> getLabInvestigation(String personId) async {

    try {
      String response = await htsChannel.invokeMethod('getLabInvestigation', personId);
      setState(() {
        labInvestId = response;

      });
    } catch (e) {
      print("channel failure: '$e'");
    }

  }

  Future<void> getTestKitByCode(String code) async {
    try {
      String response = await htsChannel.invokeMethod('getTestkitbycode', code);
      setState(() {
        testKit = response;

      });
    } catch (e) {
      print("channel failure: '$e'");
    }

  }
  Future<void> getHtsRecord(String patientId) async {
    var  hts;
    try {
      hts = await htsChannel.invokeMethod('getcurrenthts', patientId);
      print('HTS IN THE FLUTTER THE RETURNED ONE '+ hts);
    } catch (e) {
      print("channel failure: '$e'");
    }
    setState(() {

      htsRegistration = HtsRegistration.fromJson(jsonDecode(hts));
      print("HERE IS THE HTS AFTER ASSIGNMENT " + htsRegistration.toString());

    });


  }
  Future<dynamic>getTestKitBatches(String binType, String binId , String testKitId)async{
    String testkitsresponse;
    try{
      TestKitBatchDto testKitBatchDto = new TestKitBatchDto(binType, binId, testKitId);
      testkitsresponse = await htsChannel.invokeMethod('getTestKitBatches', jsonEncode(testKitBatchDto));
      debugPrint('ggggggggggggggggg testkit batches returned'+ testkitsresponse);
      setState(() {
        _testkitbatch_string = testkitsresponse;
        testkitbatches = jsonDecode(_testkitbatch_string);
        _dropDownListTestKitBatches = TestKitBatchIssue.mapFromJson(testkitbatches);
        _dropDownListTestKitBatches.forEach((e){
          _TestkitbatchesList.add(e);
        });
        debugPrint('ggggggggggggggggg testkit batches after assignment'+ _TestkitbatchesList.toString());
      });

    }catch(e){
      print("Exception thrown in getTestKitBatches method in flutter: '$e'");


    }
  }

  void _handleTestKitChange(int value) {
    setState(() {
      _testKit = value;
      _testkitslist.forEach((e){
        if(value == _testkitslist.indexOf(e)){
          testKitobj.code = e.code;
          testKitobj.name = e.name;

        }
        getTestKitBatches('QUEUE',patientBinId, testKitobj.code);

      });
    });


  }
  void _handleTestKitBatchChange(int value) {
    setState(() {
      _testKitBatch = value;
      _TestkitbatchesList.forEach((e){
        if(value == _TestkitbatchesList.indexOf(e)){
          batchIssueId = e.id;


        }
      });

    });

  }

  void _handleResultChange(int value)  {

    setState(() {
      _result = value;
      _entryPointList.forEach((e) {
        if (value == _entryPointList.indexOf(e)){
          result.code = e.code;
          result.name = e.name;
        }
      });

    });

  }


  List<DropdownMenuItem<String>> getIdentifierDropdownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String identifier in _identifierList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(value: identifier, child: Text(identifier)));
    }
    return items;
  }


  Widget _body(List <dynamic> list) {
    return ListView(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[

                      Container(
                        height: 900,
                        child: Card(
                          margin: new EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 50.0, bottom: 5.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 0.0,
                          child: new Padding(
                            padding: new EdgeInsets.all(25.0),
                            child: new Column(
                              children: <Widget>[
                                new Container(
                                  child: new Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Sample :",
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          width: 100,
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Text(
                                              (sample_name),
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          width: 100,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                new Container(
                                  child: new Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Investigation :",
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          width: 100,
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Text(
                                              (investigation_name),
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          width: 100,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: <Widget>[

                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Test Kit',
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        width: 250,
                                      ),
                                    ),
                                 getTestKIts(_testkitslist),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Test Kit Batches',
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        width: 250,
                                      ),
                                    ),
                                    getTestKitsBatchesLabels(_TestkitbatchesList),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(children: <Widget>[
                                  Text("Results"),
                                  SizedBox(width: 10.0),
                                  getRecencyResults(_entryPointList),

                                ],),

                                SizedBox(
                                  height: 24,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: RaisedButton(
                                              elevation: 4.0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(5.0)),
                                              color: Colors.blue,
                                              padding: const EdgeInsets.all(
                                                  20.0),
                                              child: Text(
                                                "Save",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight
                                                        .w500),
                                              ),
                                              onPressed: () async {
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  _formKey.currentState.save();
                                                  if (_formIsValid) {
                                                    print('HERE IS THE TESTKIT OBJECT USED >>>>>>>>>> NAME' + testKitobj.name+ ">>>>>>>>>>>>>>>>>>> CODE"+ testKitobj.code);
                                                    LaboratoryInvestigationTest labInvestTest = LaboratoryInvestigationTest(
                                                        widget.visitId,
                                                        labInvestId,
                                                        null, null,
                                                        result, widget.visitId, testKitobj, null, null, widget.personId, batchIssueId);
                                                    saveLabInvestigationTest(labInvestTest);
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                Recency_Result(widget.personId, labInvestTestId, widget.visitId, labInvestId, widget.person, widget.htsId, labInvestTest, widget.indexTestId)

                                                    ));
                                                  } else {
                                                    setState(() {
                                                      _showError = true;
                                                    });
                                                  }
                                                }
                                              }

                                          ),
                                        ),
                                        width: 100,
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var list=this._testkitslist ;
    print("+++++++++++  $list");
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: new Column(children: <Widget>[
            new Text("Recency Testing"),
            new Text("Patient Name : " + " "+ widget.person.firstName + " " + widget.person.lastName)

          ],)
      ),
      body:_body(list),
      drawer:  Sidebar(widget.person, widget.personId, widget.visitId, htsRegistration, widget.htsId),
    );
  }


  Future<void> saveLabInvestigationTest(LaboratoryInvestigationTest laboratoryInvestTest)async{
    int response;
    print(">>>>>>>>>>>>>>>>>> SAVE LAB INVESTIGATION TEST"+ laboratoryInvestTest.toString());
    var labInvestTestResponse;
    try {

      String jsonLabInvestTest = jsonEncode(laboratoryInvestTest);
      labInvestTestResponse= await htsChannel.invokeMethod('saveRecency',jsonLabInvestTest);
      setState(() {
        print('###################'+ labInvestTestResponse);
        labInvestTestId = labInvestTestResponse;

      });

    }
    catch(e){
      print('Something went wrong...... cause $e');
    }
  }

  Widget getTestKIts(List<TestKit> testkits)
  {
    return new Row(children: testkits.map((item) =>
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(item.name),
                Radio(
                    value: testkits.indexOf(item),
                    groupValue: _testKit,
                    activeColor: Colors.blue,
                    onChanged: _handleTestKitChange)

              ],),
          ],
        ),).toList());
  }
  Widget getRecencyResults(List<Result> results)
  {
    return new Row(children: results.map((item) =>
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(item.name),
                Radio(
                    value: results.indexOf(item),
                    groupValue: _result,
                    activeColor: Colors.blue,
                    onChanged: _handleResultChange)

              ],),
          ],
        ),).toList());
  }

  Widget getTestKitsBatchesLabels(List<TestKitBatchIssue> testkitbatchissues)

  {
    return new Row(children: testkitbatchissues.map((item) =>
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                new FlatButton(
                    color: Colors.blue,
                    onPressed: (){}, child:Column(children: <Widget>[Row(children: <Widget>[ Text(DateFormat("yyyy/MM/dd").format(item.batch.expiryDate), style: TextStyle(color: Colors.white, fontSize: 10),)],),
                  Row(children: <Widget>[ Text(item.remaining.toString(), style: TextStyle(color: Colors.white, fontSize: 10),)],)],)) ,
                Radio(
                    value: testkitbatchissues.indexOf(item),
                    groupValue: _testKitBatch,
                    activeColor: Colors.blue,
                    onChanged: _handleTestKitBatchChange)

              ],),
          ],
        ),).toList());
  }




}


