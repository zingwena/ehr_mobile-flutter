import 'dart:convert';

import 'package:ehr_mobile/model/investigation.dart';
import 'package:ehr_mobile/model/laboratoryInvestigationTest.dart';
import 'package:ehr_mobile/model/personInvestigation.dart';
import 'package:ehr_mobile/model/result.dart';
import 'package:ehr_mobile/view/patient_post_test.dart';
import 'package:ehr_mobile/view/hts_result.dart';
import 'package:ehr_mobile/view/SecondResultPage.dart';
import 'package:ehr_mobile/view/ThirdResult.dart';
import 'package:ehr_mobile/view/fourthresultpage.dart';





import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter/services.dart';

import 'dart:async';
import 'package:intl/intl.dart' show DateFormat;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';


import 'edit_demographics.dart';


class FourthHtsScreeningTest extends StatefulWidget {
  final String personId;
  final String visitId;
  final String third_result_string ;
  FourthHtsScreeningTest(this.personId, this.visitId, this.third_result_string);

  @override
  State createState() {
    return _HtsScreeningTest();
  }
}

class _HtsScreeningTest extends State<FourthHtsScreeningTest> {
  final _formKey = GlobalKey<FormState>();
  var selectedDate, selectedStarttime, selectedReadingtime, selectedReadingDate;
  DateTime date, startTime, readingTime,  readingDate;
  int _result = 0;
  int _testKit = 0;
  int testCount=0;
  String id ="1";
  String result_string;
  List<dynamic>_testKits=[];
  String labId;
  List<Result>results = List ();
  String testKit = "";
  //Result result = Result.screen();
  DateTime date1;
  DateTime date2;
  DateTime date3;
  Result result = Result('Positive', '01');
  bool _entryPointIsValid = false;
  bool _formIsValid = true;
  bool _showError = false;
  String labInvestId;
  String _identifier;
  String test;
  String sample;
  List<DropdownMenuItem<String>> _identifierDropdownMenuItem;
  List _identifierList = [
    "Select Identifier",
    "Passport",
    "Birth Certificate",
    "National Id",
    "Driver's Licence"
  ];
  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');

  @override
  void initState()  {
    selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    date = DateTime.now();
    _identifierDropdownMenuItem = getIdentifierDropdownMenuItems();
    _identifier = _identifierDropdownMenuItem[0].value;

    getPersonInvestigation(widget.personId);
    getTestKitsByCount(testCount);
    getLabTest(widget.personId);
    getLabId();
    getResults();
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
        print(">>>>>>>>>>>>>>>>>>>>> selected starttime date" + selectedStarttime);
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
        this.sample=sample_name;
/*
          this.test=investigation.test;
*/

      });
    } catch (e) {
      print("channel failure: '$e'");
    }
    return sample;
  }
  Future<dynamic> getLabTest(String personId) async {

    var labtest_name;
    try {
      labtest_name = await htsChannel.invokeMethod('getLabTest', personId);
      setState(() {
        this.test=labtest_name;
/*
          this.test=investigation.test;
*/

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

      // setState(() {
      // this.labId = labIdFromChannel;

      // });

    } catch (e) {
      print("channel failure: '$e'");
    }

  }

// void getTestKits(){
//   _testKits.forEach((f)=>{})
// }
  Future<dynamic> getTestKitsByCount(int count) async {
    try {

      List<dynamic> testKits = json.decode(await htsChannel.invokeMethod('getTestKitsByLevel',count.toString()) );

      setState(() {
        _testKits=testKits;
      });
      print("*********sample from android"+testKits.toString());
    } catch (e) {
      print("channel failure: '$e'");
    }
    return sample;
  }
  Future<dynamic> getResults() async {
    try {

      String response = await htsChannel.invokeMethod('getResults');
      List<Result> resultsList = Result.fromJsonDecodedMap(jsonDecode(response));
      print("********* HTS RESPOOONSE Response"+response);
    } catch (e) {
      print("channel failure: '$e'");
    }
    return sample;
  }





  void _handleTestKitChange(int value) {
    setState(() {
      _testKit = value;

      switch (_testKit) {
        case 1:
          testKit = "Standard Q HIV 1/2 Ab ";
          break;
        case 2:
          testKit = "Determine";
          break;
      }
    });
  }



  void _handleResultChange(int value)  {

    setState(() {
      _result = value;

      switch (_result) {
        case 1:
          result.code = "01";
          result.name ="Negative";
          result_string = "Negative";
          //testCount+=1;
          break;

        case 2:
          result.code = "02";
          result.name="Positive";
          result_string = "Positive";
          //htsChannel.invokeMapMethod('saveResult',result);
          break;
        case 3:
          result.code = "03";
          result.name ="Inconclusive";
          result_string = "Inconclusive";
          break;

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
                                    Text('Standard Q HIV 1/2 Ab'),
                                    Radio(
                                        value: 1,
                                        groupValue: _testKit,
                                        activeColor: Colors.blue,
                                        onChanged: _handleTestKitChange),
                                    Text('Determine'),
                                    Radio(
                                        value: 2,
                                        groupValue: _testKit,
                                        activeColor: Colors.blue,
                                        onChanged: _handleTestKitChange)
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
                                                        id,
                                                        result_string,
                                                        null, null,
                                                        result, widget.visitId, testKit);
                                                    print(
                                                        '************************* SAVE LAB TEST ${labInvestTest
                                                            .toString()}');


                                                    saveLabInvestigationTest(
                                                        labInvestTest);
                                                  if(widget.third_result_string == result_string){
                                                    result_string = widget.third_result_string;
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                FourthHts_Result(widget.personId, labInvestId, widget.visitId, result_string)
                                                        ));
                                                  }else{
                                                    result_string = "Inconclusive";
                                                  }


                                                  } else {
                                                    setState(() {
                                                      _showError = true;
                                                    });
                                                  }
                                                }
                                              }
                                            /*   onPressed: () {
                                                print(">>>>>>>>>>>>>>> save button pressed");
                                                  */ /*labInvestTest.result  = result;*/ /*
                                                  labInvestTest.startdate = date;
                                                  labInvestTest.starttime = startTime;
                                                  labInvestTest.readingdate = readingDate;
                                                  labInvestTest.readingtime = readingTime;
                                                  saveLabInvestigationTest(labInvestTest);
                                              }
*/
//                                            onPressed: () => Navigator.push(
//                                              context,
//                                              MaterialPageRoute(
//                                                  builder: (context) =>
//                                                      LoginScreen()),
//                                            ),
                                          ),
                                        ),
                                        width: 100,
                                      ),
                                    ),
                                    /* Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: RaisedButton(
                                            elevation: 4.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(5.0)),
                                            color: Colors.red,
                                            padding: const EdgeInsets.all(20.0),
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),

                                          ),
                                        ),
                                        width: 100,
                                      ),
                                    ),*/
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
    var list=this._testKits ;
    print("+++++++++++  $list");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Third Confirmatory Testing'),
        ),
        // appBar: AppBar(
        //  backgroundColor: Colors.blue,
        //  title: Text('Add Patient'),


        body:_body(list)
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
        labInvestId = labInvestTestResponse;

      });

    }
    catch(e){
      print('Something went wrong...... cause $e');
    }
  }


}

