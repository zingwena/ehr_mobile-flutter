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
  bool awareofstatus;
  bool patientOnArt;
  bool _consenttoindex = false;
  String consenttoindex = "NO";
  HtsRegistration htsRegistration;
  List<DropdownMenuItem<String>> _dropDownMenuItemsReasons;
  List<ReasonForNotIssuingResult> _reasonsList = List();
  String _currentReasonfornotissuing;
  String _reasonstring;
  List reasons = List();
  List _dropDownListReasons = List();
  int _resultsreceived = 0;
  int _posttestcounselled = 0;
  int _patientawareofstatus = 0;
  int _patientonart = 0;
  int _consentToIndex = 0;


  @override
  void initState() {

    selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    date = DateTime.now();
  getHtsRecord(widget.patientId);
  getReasonsForNotIssueingResult();

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
      response = await dataChannel.invokeMethod('getReasonForNotIssueingReasons');
      setState(() {
        _reasonstring = response;
        reasons = jsonDecode(_reasonstring);
        _dropDownListReasons = ReasonForNotIssuingResult.mapFromJson(reasons);
        _dropDownListReasons.forEach((e) {
          _reasonsList.add(e);
        });
        print("Reasons list here "+ _reasonsList.toString());
        _dropDownMenuItemsReasons = getDropDownMenuItemsReasonForNotIssuingResult();

      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsReasonForNotIssuingResult() {
    List<DropdownMenuItem<String>> items = new List();
    for (ReasonForNotIssuingResult reasonForNotIssuingResult in _reasonsList) {
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
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets
                        .symmetric(
                        vertical: 16.0,
                        horizontal: 60.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets
                                  .all(8.0),
                              child: Text(
                                  'Results Recieved'),
                            ),
                            width: 250,
                          ),
                        ),
                        Text('YES'),
                        Radio(
                            value: 1,
                            groupValue: _resultsreceived,
                            onChanged: _handleResultReceived),
                        Text('NO'),
                        Radio(
                            value: 2,
                            groupValue: _resultsreceived,
                            onChanged: _handleResultReceived)
                      ],
                    ),
                  ),
                  _resultReceived == false ?Container(
               width: double.infinity,
                    child: OutlineButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      color: Colors.white,
                      child: Container(
                        width: double.infinity,
                        child: DropdownButton(
                          isExpanded: true,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconEnabledColor: Colors.black,
                          hint: Text("Select reason for not issuing results"),
                          value: _currentReasonfornotissuing,
                          items: _dropDownMenuItemsReasons,
                          onChanged: changedDropDownItemReasons,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      borderSide: BorderSide(
                        color: Colors.blue, //Color of the border
                        style: BorderStyle.solid, //Style of the border
                        width: 2.0, //width of the border
                      ),
                      onPressed: () {},
                    ),
                  ): SizedBox(height: 0.0),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets
                        .symmetric(
                        vertical: 16.0,
                        horizontal: 60.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets
                                  .all(8.0),
                              child: Text(
                                  'Post Test Counselled'),
                            ),
                            width: 250,
                          ),
                        ),
                        Text('YES'),
                        Radio(
                            value: 1,
                            groupValue: _posttestcounselled,
                            onChanged: _handlePostTestCounselled),
                        Text('NO'),
                        Radio(
                            value: 2,
                            groupValue: _posttestcounselled,
                            onChanged: _handlePostTestCounselled)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  _postTestCounselled == true ? Row(
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
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets
                        .symmetric(
                        vertical: 16.0,
                        horizontal: 60.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets
                                  .all(8.0),
                              child: Text(
                                  'Patient aware of their status'),
                            ),
                            width: 250,
                          ),
                        ),
                        Text('YES'),
                        Radio(
                            value: 1,
                            groupValue: _patientawareofstatus,
                            onChanged: _handlePatientAwareOfStatus),
                        Text('NO'),
                        Radio(
                            value: 2,
                            groupValue: _patientawareofstatus,
                            onChanged: _handlePatientAwareOfStatus)
                      ],
                    ),
                  ),

                  widget.result == 'POSITIVE'?Container(
                    width: double.infinity,
                    padding: EdgeInsets
                        .symmetric(
                        vertical: 16.0,
                        horizontal: 60.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets
                                  .all(8.0),
                              child: Text(
                                  'Is patient on ART ? '),
                            ),
                            width: 250,
                          ),
                        ),
                        Text('YES'),
                        Radio(
                            value: 1,
                            groupValue: _patientonart,
                            onChanged: _handlePatientOnArt),
                        Text('NO'),
                        Radio(
                            value: 2,
                            groupValue: _patientonart,
                            onChanged: _handlePatientOnArt)
                      ],
                    ),
                  ): SizedBox(height: 0.0,),
                  widget.result == 'POSITIVE'?Container(
                    width: double.infinity,
                    padding: EdgeInsets
                        .symmetric(
                        vertical: 16.0,
                        horizontal: 60.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets
                                  .all(8.0),
                              child: Text(
                                  'Consent to Index testing'),
                            ),
                            width: 250,
                          ),
                        ),
                        Text('YES'),
                        Radio(
                            value: 1,
                            groupValue: _consentToIndex,
                            onChanged: _handleConsentForIndex),
                        Text('NO'),
                        Radio(
                            value: 2,
                            groupValue: _consentToIndex,
                            onChanged: _handleConsentForIndex)
                      ],
                    ),
                  ): SizedBox(height: 0.0,),
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
                        PostTest postTest = new PostTest(widget.htsId, date, _resultReceived, _currentReasonfornotissuing, widget.result, this._consenttoindex, _postTestCounselled);

                        //PostTest(this.htsId, this.datePostTestCounselled,this.resultReceived,this.reasonForNotIssuingResult, this.finalResult, this.consentToIndexTesting, this.postTestCounselled);
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

  void _handleResultReceived(int value) {
    setState(() {
      _resultsreceived = value;

      switch (_resultsreceived) {
        case 1:
          _resultReceived = true;
          break;
        case 2:
          _resultReceived = false;
          break;
      }
    });
  }

  void _handleConsentForIndex(int value) {
    setState(() {
      _resultsreceived = value;

      switch (_resultsreceived) {
        case 1:
          _resultReceived = true;
          break;
        case 2:
          _resultReceived = false;
          break;
      }
    });
  }
  void _handlePostTestCounselled(int value) {
    setState(() {
      _posttestcounselled = value;

      switch (_posttestcounselled) {
        case 1:
          _postTestCounselled = true;
          break;
        case 2:
          _postTestCounselled = false;
          break;
      }
    });
  }
  void _handlePatientAwareOfStatus(int value) {
    setState(() {
      _patientawareofstatus = value;

      switch (_patientawareofstatus) {
        case 1:
          awareofstatus = true;
          break;
        case 2:
          awareofstatus = false;
          break;
      }
    });
  }

  void _handlePatientOnArt(int value) {
    setState(() {
      _patientonart = value;

      switch (_patientonart) {
        case 1:
          patientOnArt = true;
          break;
        case 2:
          patientOnArt = false;
          break;
      }
    });
  }



  void changedDropDownItemReasons(String value) {
    setState(() {
      _currentReasonfornotissuing = value;

    });
  }

}
