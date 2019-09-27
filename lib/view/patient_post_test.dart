import 'dart:convert';

import 'package:ehr_mobile/model/postTest.dart';

import 'package:ehr_mobile/model/reasonForNotIssuingResult.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:flutter/services.dart';
import 'package:ehr_mobile/view/art_registration.dart';
import 'package:ehr_mobile/view/search_patient.dart';



class PatientPostTest extends StatefulWidget {
  String result;
  String patientId;
  PatientPostTest(this.result, this.patientId);
  @override
  State createState() {
    return _PatientPostTest();
  }
}

class _PatientPostTest extends State<PatientPostTest> {
  static const platform = MethodChannel('example.channel.dev/people');

  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');


  final _formKey = GlobalKey<FormState>();

  var selectedDate;
  DateTime date;

  PostTest postTest;
  List<ReasonForNotIssuingResult> _reasonForNotIssuingResultList=List();
  bool _resultReceived=false;
  String resultReceived="NO";
  bool _postTestCounselled = false;
  String postTestCounselled = "NO";




  @override
  void initState() {

    selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    date = DateTime.now();


  getDropDrowns();

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

 /* List<DropdownMenuItem<String>>
  getDropDownMenuItemsPurposeOfTest() {
    List<DropdownMenuItem<String>> items = new List();
    for (PurposeOfTest purposeOfTest in _purposeOfTestList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(
          DropdownMenuItem(value: purposeOfTest.id.toString(), child: Text(purposeOfTest.name)));
    }
    return items;
  }*/


  Future<void> getDropDrowns() async {


    List reasonForNotIssuingResultList = [];

    try {
      reasonForNotIssuingResultList= jsonDecode(await htsChannel.invokeMethod('reasonForNotIssuingResultOptions'));



       } catch (e) {
      print("channel failure: '$e'");
    }

    setState(() {


      reasonForNotIssuingResultList = ReasonForNotIssuingResult.mapFromJson(reasonForNotIssuingResultList);


      _dropDownMenuItemsReasonForNotIssuingResult =
          getDropDownMenuItemsReasonForNotIssuingResult();

      _currentReasonForNotIssuingResult = _dropDownMenuItemsReasonForNotIssuingResult[0].value;
    });
  }



  List<DropdownMenuItem<String>>

  _dropDownMenuItemsReasonForNotIssuingResult;

  String _currentReasonForNotIssuingResult;




  @override
  Widget build(BuildContext context) {



    return Scaffold(
      //  appBar: AppBar(
      //   title: Text('Patient Pretest'),
      //  ),
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
                    height: 20.0,
                  ),



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
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconEnabledColor: Colors.black,
                          value: _currentReasonForNotIssuingResult,
                          items: _dropDownMenuItemsReasonForNotIssuingResult,
                          onChanged: changedDropDownItemReasonForNotIssuingResult,
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


                  SizedBox(
                    height: 10.0,
                  ),


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

                  Row(
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
                  ),
                  SizedBox(
                    height: 35.0,
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
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          insertPostTest(postTest);


                          if(widget.result == "Positive"){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Art_Registration(widget.patientId)));


                          }else{
                            Navigator.push(context,MaterialPageRoute(
                                builder: (context)=> SearchPatient()
                            ));
                          }
                        }
                      },
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }


  void changedDropDownItemReasonForNotIssuingResult(String value) {
    setState(() {
      _currentReasonForNotIssuingResult = value;

    });
  }

}
