import 'dart:convert';

import 'package:ehr_mobile/model/investigation.dart';
import 'package:ehr_mobile/model/laboratoryInvestigationTest.dart';
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
import 'cbsquestion.dart';
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
  int _result = 0;
  int _testKit = 0;
  int testCount=0;
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
  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');

  @override
  void initState()  {
    selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    date = DateTime.now();
    _identifierDropdownMenuItem = getIdentifierDropdownMenuItems();
    _identifier = _identifierDropdownMenuItem[0].value;
    getPersonInvestigation(widget.personId);
    getLabInvestigation(widget.personId);
    getLabTest(widget.personId);
    getResults(widget.personId);
    getLabId();
    getHtsRecord(widget.personId);

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


  Future<void> getResults(String personId) async {
    String response;
    try {
      response = await htsChannel.invokeMethod('getTestResults', personId);
      setState(() {
        _entryPoint = response;
        entryPoints = jsonDecode(_entryPoint);
        _dropDownListEntryPoints = Result.mapFromJson(entryPoints);
        print("HHHHHHHHHHHHHHHHHHH results from android"+ _dropDownListEntryPoints.toString());
        _dropDownListEntryPoints.forEach((e) {
          _entryPointList.add(e);
        });
      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }
  Future<dynamic> getLabTest(String personId) async {

    var labtest_name;
    try {
      labtest_name = await htsChannel.invokeMethod('getLabTest', personId);
      setState(() {
        this.test=labtest_name;
      });
    } catch (e) {
      print("channel failure: '$e'");
    }
    return test;
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
      print("*********sample from android"+_testkitslist.toString());
    } catch (e) {
      print("channel failure: '$e'");
    }

  }
  Future<dynamic>getTestName()async{
    print("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK lab invest id IN TESTNAME"+ labInvestId);

    try{
      String response = await htsChannel.invokeMethod('getTestName', labInvestId);
      setState(() {
        test_name = response;
        print("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH TEST NAME TEST NAME"+ test_name);

      });

    }catch(e){

    }
  }
  Future<dynamic> getLabInvestigation(String personId) async {

    try {
      String response = await htsChannel.invokeMethod('getLabInvestigation', personId);
      setState(() {
        labInvestId = response;

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
      print('HTS IN THE FLUTTER THE RETURNED ONE '+ hts);
    } catch (e) {
      print("channel failure: '$e'");
    }
    setState(() {

      htsRegistration = HtsRegistration.fromJson(jsonDecode(hts));
      print("HERE IS THE HTS AFTER ASSIGNMENT " + htsRegistration.toString());

    });


  }

  void _handleTestKitChange(int value) {
    setState(() {
      _testKit = value;
      switch(_testKit){
        case 1:
          testKitobj.code = '1';
          testKitobj.name = 'Asante';
      }
    });


  }

  void _handleResultChange(int value)  {

    setState(() {
      _result = value;

      switch (_result) {
        case 1:
          result.name = "RTRI Negative";
          result.code = "01";
          break;

        case 2:
          result.name = "Invalid";
          result.code = "02";
          break;
        case 3:
        result.name = "Long Term";
        result.code = "03";
          break;
        case 4:
          result.name ="Recent";
          result.code ="04";

      }


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
                                              ('Blood'),
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
                                              ('HIV'),
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
                                    Row(
                                      children: <Widget>[
                                        Text('Asante'),
                                        Radio(
                                            value: 1,
                                            groupValue:_testKit,
                                            activeColor: Colors.blue,
                                            onChanged: _handleTestKitChange)

                                      ],),
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
                                          padding: const EdgeInsets.all(0.0),
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
                                          padding: const EdgeInsets.all(0.0),
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
                                    Text('RTRI Negative'),
                                    Radio(
                                        value: 1,
                                        groupValue: _result,
                                        activeColor: Colors.blue,
                                        onChanged: _handleResultChange),
                                    Text('Invalid'),
                                    Radio(
                                        value: 2,
                                        groupValue: _result,
                                        activeColor: Colors.blue,
                                        onChanged: _handleResultChange),
                                    Text('Long Term'),
                                    Radio(
                                        value: 3,
                                        groupValue: _result,
                                        activeColor: Colors.blue,
                                        onChanged: _handleResultChange),
                                    Text('Recent'),
                                    Radio(
                                        value: 4,
                                        groupValue: _result,
                                        activeColor: Colors.blue,
                                        onChanged: _handleResultChange),
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
                                                    LaboratoryInvestigationTest labInvestTest = LaboratoryInvestigationTest(
                                                        widget.visitId,
                                                        labInvestId,
                                                        null, null,
                                                        result, widget.visitId, testKitobj, null, null);
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
      // appBar: AppBar(
      //  backgroundColor: Colors.blue,
      //  title: Text('Add Patient'),


      body:_body(list),
      drawer:  new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(accountName: new Text("admin"), accountEmail: new Text("admin@gmail.com"), currentAccountPicture: new CircleAvatar(backgroundImage: new AssetImage('images/mhc.png'))),
            new ListTile(leading: new Icon(Icons.home, color: Colors.blue),title: new Text("Home "), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SearchPatient()),
            )),
            new ListTile(leading: new Icon(Icons.person, color: Colors.blue),title: new Text("Patient Overview "), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Overview(widget.person)),
            )),
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue),title: new Text("Reception Vitals"), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ReceptionVitals(widget.personId, widget.visitId, widget.person)),
            )),
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue),title: new Text("HTS"), onTap: () {
              if(htsRegistration == null ){
                print('bbbbbbbbbbbbbb htsreg null in side bar  ');
                Navigator.push(context,MaterialPageRoute(
                    builder: (context)=>  Registration(widget.visitId, widget.personId, widget.person)
                ));
              } else {
                print('bbbbbbbbbbbbbb htsreg  not null in side bar ');

                Navigator.push(context,MaterialPageRoute(
                    builder: (context)=> HtsRegOverview(htsRegistration, widget.personId, widget.htsId, widget.visitId, widget.person)
                ));
              }
            }),
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue),title: new Text("ART"), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ArtReg(widget.personId, widget.visitId, widget.person, widget.htsRegistration)),
            )),
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue), title: new Text("Sexual History",  style: new TextStyle(
                color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CbsQuestions(widget.personId, widget.htsId, htsRegistration, widget.visitId, widget.person)),
            )),


          ],
        ),
      ),
    );
  }

  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(
            text: "HTS Registration",
          ),
          new RoundedButton(
            text: "HTS Pre-Testing",
            /*    onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PatientPretest(widget.patientId, hts_id)),
            ),*/
          ),
          new RoundedButton(text: "Hts Result", selected: true,
          ),
        ],
      ),
    );
  }

  Future<void> saveLabInvestigationTest(LaboratoryInvestigationTest laboratoryInvestTest)async{
    int response;
    print(">>>>>>>>>>>>>>>>>> SAVE LAB INVESTIGATION TEST"+ laboratoryInvestTest.toString());
    var labInvestTestResponse;
    try {

      String jsonPatient = jsonEncode(laboratoryInvestTest);
      labInvestTestResponse= await htsChannel.invokeMethod('saveLabInvestTest',jsonPatient);
      setState(() {
        print('###################'+ labInvestTestResponse);
        labInvestTestId = labInvestTestResponse;

      });

    }
    catch(e){
      print('Something went wrong...... cause $e');
    }
  }


}


