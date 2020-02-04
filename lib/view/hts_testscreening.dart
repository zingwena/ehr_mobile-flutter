import 'dart:async' as prefix0;
import 'dart:convert';

import 'package:ehr_mobile/model/dto/testkitbatchdto.dart';
import 'package:ehr_mobile/model/investigation.dart';
import 'package:ehr_mobile/model/laboratoryInvestigationTest.dart';
import 'package:ehr_mobile/model/testkitbatchissue.dart';
import 'package:ehr_mobile/model/age.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/model/personInvestigation.dart';
import 'package:ehr_mobile/model/result.dart';
import 'package:ehr_mobile/model/testKit.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/view/patient_post_test.dart';
import 'package:ehr_mobile/view/reception_vitals.dart';
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
import '../sidebar.dart';

class HtsScreeningTest extends StatefulWidget {
  final String personId;
  final String visitId;
  final Person person;
  final String htsId;
  final HtsRegistration htsRegistration;
  HtsScreeningTest(this.personId, this.visitId, this.person, this.htsId, this.htsRegistration);

  @override
  State createState() {
    return _HtsScreeningTest();
  }
}

class _HtsScreeningTest extends State<HtsScreeningTest> {
  final _formKey = GlobalKey<FormState>();
  var selectedDate, selectedStarttime, selectedReadingtime, selectedReadingDate;
  DateTime date, startTime, readingTime,  readingDate;
  HtsRegistration htsRegistration;
  int _result = 0;
  int _testKit = -1;
  int _testKitBatch = -1;
  int testCount=0;
  String id ="1";
  String result_string;
  String labId;
  List<Result>results = List ();
  String testKit = "";
  DateTime date1;
  DateTime date2;
  DateTime date3;
  Result result = Result('', '');
  String labInvestId ;
  String labInvestTestId;
  String test;
  String sample_name;
  String _result_string;
  String _testkit_string_response;
  String test_name;
  TestKit testKitobj  = TestKit('', '', '', '');
  List test_kits = List();
  List _dropDownListtestkits = List();
  List<TestKit>_testkitslist = List();
  List json_result_list = List();
  List _results = List();
  List<Result> _resultsList = List();
  int testkitcount = 0 ;
  String _testkitbatch_string;
  List testkitbatches = List();
  List _dropDownListTestKitBatches = List();
  List<TestKitBatchIssue> _TestkitbatchesList = List();
  String patientBinId;
  String batchIssueId;
  bool _batch_selected = false;
  bool show_batch_error_msg = false;
  Age age;

  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  static const dataChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');


  String facility_name;

  @override
  void initState()   {
      selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
      getPersonInvestigation(widget.personId);
      //getLabInvestigation(widget.personId);
      getLabTest(widget.personId);
      getResults(widget.personId);
      getPersonQueueOrWard(widget.personId);
      getTestName();
     // getLabId();
      getHtsRecord(widget.personId);
      getFacilityName();
      getAge(widget.person);
      date = DateTime.now();
      print("HERE IS THE VISITID IN HTS SCREENING>>>>>>>>>>>>>>>"+ widget.visitId);

    super.initState();
  }
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = DateFormat("yyyy/MM/dd").format(picked);
        date = DateFormat("yyyy/MM/dd").parse(selectedDate);
      });
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

  Future<void>getAge(Person person)async{
    String response;
    try{
      response = await dataChannel.invokeMethod('getage', person.id);
      setState(() {
        age = Age.fromJson(jsonDecode(response));
      });

    }catch(e){
      debugPrint("Exception thrown in get facility name method"+e);

    }
  }


  Future<Null> _selectedStarttime(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedStarttime)
      setState(() {
        selectedStarttime = DateFormat("yyyy/MM/dd").format(picked);
        startTime = DateFormat("yyyy/MM/dd").parse(selectedStarttime);
      });
  }
  Future<Null> _selectedReadingtime(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedReadingtime)
      setState(() {
        selectedReadingtime = DateFormat("yyyy/MM/dd").format(picked);
        readingTime = DateFormat("yyyy/MM/dd").parse(selectedReadingtime);
      });
  }
  Future<Null> _selectedReadingDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedReadingDate)
      setState(() {
        selectedReadingDate = DateFormat("yyyy/MM/dd").format(picked);
        readingDate = DateFormat("yyyy/MM/dd").parse(selectedReadingDate);
      });
  }
  Future<dynamic> getPersonInvestigation(String personId) async {

    var sample_name;
    try {
      sample_name = await htsChannel.invokeMethod('getSample', personId);
          setState(() {
          this.sample_name=sample_name;
          });
    } catch (e) {
      print("channel failure: '$e'");
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

  Future<void> getResults(String personId) async {
    String response;
    try {
      response = await htsChannel.invokeMethod('getTestResults', personId);
      setState(() {
        _result_string = response;
        json_result_list = jsonDecode(_result_string);
        _results = Result.mapFromJson(json_result_list);
        _results.forEach((e) {
          _resultsList.add(e);
        });
      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }
  Future<dynamic> getLabTest(String personId) async {
     String labtestname;
    try {
      labtestname = await htsChannel.invokeMethod('getLabTest', personId);
      setState(() {
        this.test=labtestname;
      });
    } catch (e) {
      print("channel failure: '$e'");
    }

  }
  Future<dynamic> getLabId() async {
    try {
      Map <String,dynamic> data= json.decode(await htsChannel.invokeMethod('getLabInvestigation')) ;
      var labId= data["labId"];
      var visitPatientId= data["visitPatientId"];
            print("Visit Patient Id : $visitPatientId || Lab Id : $labId"  );
     
    } catch (e) {
      print("channel failure: '$e'");
    }
  
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
Future<dynamic> getTestKitsByCount(int count) async {

  try {
      String response = await htsChannel.invokeMethod('getTestKitsByLevel', labInvestId);
       setState(() {
         _testkit_string_response = response;
         test_kits = jsonDecode(_testkit_string_response);
         _dropDownListtestkits = TestKit.mapFromJson(test_kits);
         _dropDownListtestkits.forEach((e){
           _testkitslist.add(e);
         });

       });
    } catch (e) {
      print("channel failure: '$e'");
    }

  }
  Future<dynamic>getTestName()async{
    try{
      String response = await htsChannel.invokeMethod('getTestName', labInvestId);
      setState(() {
        test_name = response;

      });

    }catch(e){

    }
  }
  Future<dynamic> getLabInvestigation(String personId) async {

    try {
      String response = await htsChannel.invokeMethod('getcurrenthts', personId);
      setState(() {
        labInvestId = response;
        debugPrint("HERE IS THE LAB INVESTIGATION ID RETURNED FROM FLUTTER" + response);

      });
    } catch (e) {
      print("channel failure: '$e'");
    }

  }

  Future<dynamic> getTestKitByCode(String code) async {
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
      setState(() {

        htsRegistration = HtsRegistration.fromJson(jsonDecode(hts));
        labInvestId = htsRegistration.laboratoryInvestigationId;
        getTestName();
        getTestKitsByCount(testCount);


      });
    } catch (e) {
      print("channel failure: '$e'");
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
          getTestKitBatches('QUEUE',patientBinId, testKitobj.code);

        }
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

  Widget getTestKitsBatchesLabels(List<TestKitBatchIssue> testkitbatchissues)
  {
    return new Column(children: testkitbatchissues.map((item) =>
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


  void _handleResultChange(int value)  {

      setState(() {
      _result = value;

      switch (_result) {
        case 1:
          _resultsList.forEach((e) {
            if (e.name == "negative " || e.name == "Negative" || e.name == "NEGATIVE"){
              result.code = e.code;
              result.name = e.name;
            }
          });
          break;
        
        case 2:
          _resultsList.forEach((e){
        if(e.name == "positive " || e.name == "Positive" || e.name == "POSITIVE"){
          result.code = e.code;
          result.name = e.name;
        }
      });
      break;
        case 3:

          _resultsList.forEach((e){
            if(e.name == "Inconclusive " || e.name == "Indeterminate" || e.name == "INDERTERMINATE"){
              result.code = e.code;
              result.name = e.name;
            }
          });

          break;

      }


    });

  }

  @override
  Widget build(BuildContext context) {
    var list=this._testkitslist ;
    print("+++++++++++  $list");
    return Scaffold(
      drawer:  Sidebar(widget.person, widget.personId, widget.visitId, htsRegistration, widget.htsId),
      body:
      Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.blue],
              ),
            ),
            height: 250.0,
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
                  child: Column(
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
                    child: Text(test_name, style: TextStyle(
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
                              child: Text("Age -"+age.years.toString() +"years", style: TextStyle(
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
                            return    _body(list);
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
                                              text: 'HIV'),
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
                                            'Test Kit Batches',
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

                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 0.0),
                                          child: DateTimePickerFormField(
                                            inputType: InputType.both,
                                            format: DateFormat(
                                                "EEEE, MMMM d, yyyy 'at' h:mma"),
                                            editable: false,
                                            decoration: InputDecoration(
                                                labelText: 'Start Date and Time',
                                                hasFloatingPlaceholder: false
                                            ),
                                            onChanged: (dt) {
                                              setState(() => date1 = dt);
                                              print('Selected date: $date1');
                                            },
                                          ),
                                        ),
                                        width: 100,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 28,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 0.0),
                                          child: DateTimePickerFormField(
                                            inputType: InputType.both,
                                            format: DateFormat(
                                                "EEEE, MMMM d, yyyy 'at' h:mma"),
                                            editable: false,
                                            decoration: InputDecoration(
                                                labelText: 'End Date and Time',
                                                hasFloatingPlaceholder: false
                                            ),
                                            onChanged: (dt) {
                                              setState(() => date2 = dt);
                                              print('Selected date: $date2');
                                            },
                                          ),
                                        ),
                                        width: 100,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Result',

                                          ),
                                        ),
                                        width: 250,
                                      ),
                                    ),
                                    Text('Negative'),
                                    Radio(
                                        value: 1,
                                        groupValue: _result,
                                        activeColor: Colors.blue,
                                        onChanged: _handleResultChange),
                                    Text('Positive'),
                                    Radio(
                                        value: 2,
                                        groupValue: _result,
                                        activeColor: Colors.blue,
                                        onChanged: _handleResultChange),
                                    Text('Inconclusive'),
                                    Radio(
                                        value: 3,
                                        groupValue: _result,
                                        activeColor: Colors.blue,
                                        onChanged: _handleResultChange),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
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
                                              onPressed: ()  {
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  _formKey.currentState.save();
                                                  LaboratoryInvestigationTest labInvestTest = LaboratoryInvestigationTest(
                                                      widget.visitId,
                                                      labInvestId,
                                                      null, null,
                                                      result, widget.visitId, testKitobj, null, null, widget.personId, batchIssueId);
                                                  if(_batch_selected == true){
                                                    saveLabInvestigationTest(
                                                        labInvestTest);
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                Hts_Result(widget.personId, labInvestTestId, widget.visitId, labInvestId, widget.person, widget.htsId, widget.htsRegistration)
                                                        ));

                                                  }else{
                                                    setState(() {
                                                      show_batch_error_msg = true;


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

  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(text: "HTS Registration",),
          new RoundedButton(text: "HTS Pre-Testing", ),
          new RoundedButton(text: "Testing",selected: true, ),
        ],
      ),
    );
  }
Future<void>validateInputs() async{
    try{


    }catch(e){

    }

}


  Future<void> saveLabInvestigationTest(LaboratoryInvestigationTest laboratoryInvestTest)async{
    print("LAB INVESTIGATION TO BE SAVED"+ laboratoryInvestTest.toString());
    int response;
    var labInvestTestResponse;
    try {
      String jsonLabInvestTest = jsonEncode(laboratoryInvestTest);
      labInvestTestResponse= await htsChannel.invokeMethod('saveLabInvestTest',jsonLabInvestTest);
      setState(() {
        labInvestTestId = labInvestTestResponse;
      });
    }
    catch(e){
      print('Something went wrong...... cause $e');
    }
  }


}


