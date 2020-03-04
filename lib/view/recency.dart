import 'dart:convert';

import 'package:ehr_mobile/model/dto/testkitbatchdto.dart';
import 'package:ehr_mobile/model/investigation.dart';
import 'package:ehr_mobile/model/laboratoryInvestigationTest.dart';
import 'package:ehr_mobile/model/laboratoryInvestigationTestDto.dart';
import 'package:ehr_mobile/model/testkitbatchissue.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/sidebar.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/login_screen.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/model/personInvestigation.dart';
import 'package:ehr_mobile/model/result.dart';
import 'package:ehr_mobile/model/age.dart';
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
import 'package:ehr_mobile/view/summary.dart';
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
  final HtsRegistration htsRegistration;
  RecencyTest(this.personId, this.visitId, this.person, this.htsId,this.htsRegistration);

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
  Age age;
  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  static const dataChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  var facility_name;
  bool _batch_selected = false;
  bool show_batch_error_msg = false;


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
    getPersonQueueOrWard(widget.personId);
    getFacilityName();
    getAge(widget.person);

    super.initState();
  }
  Future<void>getFacilityName()async{
    String response;
    try{
      response = await retrieveString(FACILITY_NAME);
      setState(() {
        facility_name = response;
      });

    }catch(e){
      debugPrint("Exception thrown in get facility name method"+e);

    }
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

  Future<void>getAge(Person person)async{
    String response;
    try{
      response = await dataChannel.invokeMethod('getage', person.id);
      setState(() {
        age = Age.fromJson(jsonDecode(response));
        print("THIS IS THE AGE RETRIEVED"+ age.toString());
      });

    }catch(e){
      debugPrint("Exception thrown in get facility name method"+e);

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
  Future<dynamic> getPersonQueueOrWard(String personId) async {

    var binId_response;
    try {
      binId_response = await htsChannel.invokeMethod('getPatientQueueOrWard', personId);
      debugPrint('FFFFFFFF HERE IS THE BIN ID RESPONSE'+ binId_response);
      setState(() {
        this.patientBinId=binId_response;
        debugPrint('FFFFFFFF HERE IS THE BIN ID RESPONSE AFTER ASSIGNMENT'+ binId_response);

      });
    } catch (e) {
      print("channel failure in getPerson queue or ward: '$e'");
    }

  }


  void _handleTestKitChange(int value) {
    setState(() {
      _testKit = value;
      _testkitslist.forEach((e){
        if(value == _testkitslist.indexOf(e)){
          testKitobj.code = e.code;
          testKitobj.name = e.name;
          _TestkitbatchesList.clear();


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
          _batch_selected = true;


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
                              left: 30.0, right: 30.0, top: 0.0, bottom: 5.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 0.0,
                          child: new Padding(
                            padding: new EdgeInsets.all(25.0),
                            child: new Column(
                              children: <Widget>[

                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 16.0),
                                        child: TextField(
                                          controller: TextEditingController(
                                              text: 'Blood'),
                                          decoration: InputDecoration(
                                            labelText: 'Sample',
                                            // icon: Icon(Icons.add_box, color: Colors.blue),
                                          ),

                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 16.0),
                                        child: TextField(
                                          controller: TextEditingController(
                                              text: investigation_name),
                                          decoration: InputDecoration(
                                            labelText: 'Investigation',
                                            //icon: Icon(Icons.adjust, color: Colors.blue),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
                                            'Test Kit'
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
                                            'Test Kit Batches'
                                          ),
                                        ),
                                        width: 250,
                                      ),
                                    ),
                                    getTestKitsBatchesLabels(_TestkitbatchesList),
                                  ],
                                ),
                                show_batch_error_msg == true ? SizedBox(
                                  height: 20.0, width: 300.0, child: Text("Select testkit batch", style: TextStyle(color: Colors.red, fontSize: 15),),
                                ):SizedBox(height: 0.0, width: 0.0,),
                                SizedBox(
                                  height: 20,
                                ),

                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric( vertical: 16.0,  horizontal: 6.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Results"),
                                          ),
                                          width: 250,
                                        ),
                                      ),
                                      getRecencyResults(_entryPointList),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 24,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: RaisedButton(
                                              elevation: 4.0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(5.0)),
                                              color: Colors.blue,
                                              padding: const EdgeInsets.all( 20.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text('Save', style: TextStyle(color: Colors.white),),
                                                  Spacer(),
                                                  Icon(Icons.save_alt, color: Colors.white,),
                                                ],
                                              ),
                                              onPressed: () async {
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  _formKey.currentState.save();
                                                  if (_formIsValid) {
                                                    LaboratoryInvestigationTestDto labInvestTest = LaboratoryInvestigationTestDto(
                                                        '',
                                                        "ee7d91fc-b27f-11e8-b121-c48e8faf035b ",
                                                        null, null,
                                                        result, widget.visitId, testKitobj, null, null, widget.personId, batchIssueId);

                                                    saveLabInvestigationTest(labInvestTest);
                                                    if(_batch_selected == true){
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  Recency_Result(widget.personId, labInvestTestId, widget.visitId, labInvestId, widget.person, widget.htsId, labInvestTest)

                                                          ));
                                                    }else{
                                                      setState(() {
                                                        show_batch_error_msg = true;

                                                      });

                                                    }

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
                        height: 0.0,
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
      drawer:  Sidebar(widget.person, widget.personId, widget.visitId, htsRegistration, widget.htsId),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.blue],
              ),
            ),
            height: 220.0,
          ),
          new AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            title:new Text(
    facility_name!=null?facility_name: 'Impilo Mobile',   style: TextStyle(
    fontWeight: FontWeight.w300, fontSize: 25.0, ), ),

            actions: <Widget>[


              Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.person_pin, size: 25.0, color: Colors.white,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text("admin", style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12.0,color: Colors.white ),),
                        ),
                      ])
              ),

              Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: IconButton(
                            icon: Icon(Icons.exit_to_app), color: Colors.white,
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),),
                          ),
                          /*  Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text("logout", style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12.0,color: Colors.white ),),
                        ), */

                        ),  ])
              ),
            ],
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 40.0),
              child: new Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text("Recency Testing", style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16.0,color: Colors.white ),),
                  ),

                  Container(
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.person_outline, size: 25.0, color: Colors.white,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(widget.person.firstName + " " + widget.person.lastName, style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14.0,color: Colors.white ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.date_range, size: 25.0, color: Colors.white,),
                            ),
                              Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text("Age -"+age.years.toString()+"years", style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14.0,color: Colors.white ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.person, size: 25.0, color: Colors.white,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text("Sex :"+ widget.person.sex, style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14.0,color: Colors.white ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.verified_user, size: 25.0, color: Colors.white,),
                            ),
                          ])
                  ),
                  _buildButtonsRow(),
                  Expanded(
                    child: new Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.all(8.0),
                      child: DefaultTabController(
                        child: new LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints viewportConstraints) {
                            return  _body(list);
                          },
                        ),
                        length: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[

          new RoundedButton(
            text: "Recency Testing", selected: true,
          ),
          new RoundedButton(
            text: "Close", onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SummaryOverview(widget.person, widget.visitId, widget.htsRegistration, widget.htsId)),
            );
          },
          ),
        ],
      ),
    );
  }


  Future<void> saveLabInvestigationTest(LaboratoryInvestigationTestDto laboratoryInvestTest)async{
    int response;
    var labInvestTestResponse;
    try {

      String jsonLabInvestTest = jsonEncode(laboratoryInvestTest);
      labInvestTestResponse= await htsChannel.invokeMethod('saveRecency',jsonLabInvestTest);
      setState(() {
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
                new RaisedButton(
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),),
                    color: Colors.blue,
                    padding: const EdgeInsets.all(4.0),
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


