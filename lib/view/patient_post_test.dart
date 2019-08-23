import 'dart:convert';

import 'package:ehr_mobile/model/postTest.dart';

import 'package:ehr_mobile/model/reasonForNotIssuingResult.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';


class PatientPostTest extends StatefulWidget {
  @override
  State createState() {
    return _PatientPostTest();
  }
}

class _PatientPostTest extends State<PatientPostTest> {
  static const platform = MethodChannel('example.channel.dev/people');

  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  final _formKey = GlobalKey<FormState>();
  PostTest postTest;
  List<ReasonForNotIssuingResult> _reasonForNotIssuingResultList=List();
  bool _resultReceived=false;
  String resultReceived="NO";
  bool _postTestCounselled = false;
  String postTestCounselled = "NO";



  @override
  void initState() {
  getDropDrowns();

  print('reasonForNotIssuingResultList${_reasonForNotIssuingResultList.length}');




    super.initState();
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
          DropdownMenuItem(value: reasonForNotIssuingResult.id.toString(), child: Text(reasonForNotIssuingResult.name)));
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


      _reasonForNotIssuingResultList = ReasonForNotIssuingResult.mapFromJson(reasonForNotIssuingResultList);


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
