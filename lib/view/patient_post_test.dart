import 'dart:convert';

import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/indextest.dart';
import 'package:ehr_mobile/model/postTest.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/reasonForNotIssuingResult.dart';
import 'package:ehr_mobile/view/posttest_overview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/view/reception_vitals.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/htsreg_overview.dart';
import 'package:ehr_mobile/view/hts_registration.dart';

import '../sidebar.dart';
class PatientPostTest extends StatefulWidget {
  String result;
  String patientId;
  String visitId;
  Person person;
  String htsId;
  HtsRegistration htsRegistration;
  PatientPostTest(this.result, this.patientId, this.visitId,  this.person, this.htsId, this.htsRegistration);
  @override
  State createState() {
    return _PatientPostTest();
  }
}

class _PatientPostTest extends State<PatientPostTest> {
  static const platform = MethodChannel('example.channel.dev/people');
  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  static const dataChannel =
  MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  final _formKey = GlobalKey<FormState>();
  var selectedDate;
  DateTime date;
  List<ReasonForNotIssuingResult> _reasonForNotIssuingResultList=List();
  bool _resultReceived=false;
  String resultReceived="NO";
  bool _postTestCounselled = false;
  String postTestCounselled = "NO";
  bool _consenttoindex = false;
  String consenttoindex = "NO";
  HtsRegistration htsRegistration;
  List<DropdownMenuItem<String>> _dropDownMenuItemsEntryPoint;
  List<ReasonForNotIssuingResult> _entryPointList = List();
  String _currentEntryPoint;
  String _entryPoint;
  List entryPoints = List();
  List _dropDownListEntryPoints = List();


  @override
  void initState() {

    selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    date = DateTime.now();
  getHtsRecord(widget.patientId);

  print('reasonForNotIssuingResultList${_reasonForNotIssuingResultList.length}');



    super.initState();

  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),

        firstDate: DateTime(1900, 8),

        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = DateFormat("yyyy/MM/dd").format(picked);
      });
  }

  Future<void> insertPostTest(PostTest postTest) async {
    try {
          await htsChannel.invokeMethod('savePostTest',  jsonEncode(postTest));
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
  Future<void> getReasonsForNotIssueingResult() async {
    String response;
    try {
      response = await dataChannel.invokeMethod('getEntryPointsOptions');
      setState(() {
        _entryPoint = response;
        entryPoints = jsonDecode(_entryPoint);
        _dropDownListEntryPoints = ReasonForNotIssuingResult.mapFromJson(entryPoints);
        _dropDownListEntryPoints.forEach((e) {
          _entryPointList.add(e);
        });
        _dropDownMenuItemsEntryPoint = getDropDownMenuItemsReasonForNotIssuingResult();
      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }

  List<DropdownMenuItem<String>>
  getDropDownMenuItemsReasonForNotIssuingResult() {
    List<DropdownMenuItem<String>> items = new List();
    for (ReasonForNotIssuingResult reasonForNotIssuingResult in _reasonForNotIssuingResultList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(
          DropdownMenuItem(value: reasonForNotIssuingResult.code, child: Text(reasonForNotIssuingResult.name)));
    }
    return items;
  }
    @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: new Column(children: <Widget>[
            new Text("Post Test"),
            new Text("Patient Name : " + " "+ widget.person.firstName + " " + widget.person.lastName)

          ],)
      ),
      drawer:  Sidebar(widget.person, widget.patientId, widget.visitId, widget.htsRegistration, widget.htsId),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                "Final Result:",
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
                                (widget.result),
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Results Recieved"),
                      Checkbox(
                        value:_resultReceived,
                        onChanged: (bool value) {
                          setState(() {
                            _resultReceived=value;
                          });
                          if(value) {
                            setState(() {
                              resultReceived="YES";
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
              /*    Row(children: <Widget>[
                    Container(
                      padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                      width: double.infinity,
                      child: OutlineButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        color: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 30.0),
                          child: DropdownButton(
                            hint: Text('Select Entry Point'),
                            icon: Icon(Icons.keyboard_arrow_down),
                            iconEnabledColor: Colors.black,
                            value: _currentEntryPoint,
                            items: _dropDownMenuItemsEntryPoint,
                            onChanged: changedDropDownItemEntryPoint,
                          ),
                        ),
                        borderSide: BorderSide(
                          color: Colors.blue, //Color of the border
                          style: BorderStyle.solid, //Style of the border
                          width: 2.0, //width of the border
                        ),
                        onPressed: () {},
                      ),
                    ),

                  ],),*/

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Post Test Counselled"),
                      Checkbox(
                        value:_postTestCounselled,
                        onChanged: (bool value) {
                          setState(() {
                            _postTestCounselled=value;
                          });
                          if(value) {
                            setState(() {
                              postTestCounselled="YES";
                            });
                          }
                        },
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 10.0,
                  ),

                  postTestCounselled == "YES" ? Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: TextFormField(
                              controller:

                              TextEditingController(text: selectedDate),

                              validator: (value) {
                                return value.isEmpty ? 'Enter some text' : null;
                              },
                              decoration: InputDecoration(
                                  labelText: 'Date Post Test Counselled',
                                  border: OutlineInputBorder()),

                            ),
                          ),
                          width: 100,
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.calendar_today),
                          color: Colors.blue,
                          onPressed: () {
                            _selectDate(context);
                          })
                    ],
                  ): SizedBox(
                    height: 0.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  getIndexQuestion(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      color: Colors.blue,
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Proceed",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        PostTest postTest = new PostTest(widget.htsId, date, true, null, widget.result, false);
                        insertPostTest(postTest);
                        Navigator.push(context,MaterialPageRoute(
                            builder: (context)=> PostTestOverview(postTest, widget.patientId, widget.visitId, widget.person, widget.htsId, _consenttoindex, widget.result, htsRegistration)
                        ));
                      },
                    ),
                  ),
                ],
              )),
        ),
      ),
    );

  }

  Widget getIndexQuestion(){
    if(widget.result == 'POSITIVE' || widget.result == 'Positive' || widget.result == 'positive'){
      return  Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text("Consent to Index testing"),
          Checkbox(
            value:_consenttoindex,
            onChanged: (bool value) {
              setState(() {
                _consenttoindex=value;
              });
              if(value) {
                setState(() {
                  consenttoindex="YES";
                });
              }
            },
          ),
        ],
      );
    } else {
      return SizedBox(
        height: 10.0,
      );
    }

  }
  void changedDropDownItemEntryPoint(String selectedEntryPoint) {
    setState(() {
      _currentEntryPoint = selectedEntryPoint;
     /* _entryPointError = null;
      _entryPointIsValid = !_entryPointIsValid;*/
    });
  }

}
