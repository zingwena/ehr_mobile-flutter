import 'dart:convert';

import 'package:ehr_mobile/model/postTest.dart';
import 'package:ehr_mobile/model/preTest.dart';
import 'package:ehr_mobile/model/purposeOfTest.dart';
import 'package:ehr_mobile/model/htsModel.dart';
import 'package:ehr_mobile/model/reasonForNotIssuingResult.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'edit_demographics.dart';

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
  List<ReasonForNotIssuingResult> _reasonForNotIssuingResult=List();
  bool _resultReceived;
  bool _postTestCounselled;

  int _hts = 0;
  String _coupleCounselling="" ;
  String _newTest="" ;
  String _htsApproach="" ;
  String _preTestInfoGiven="" ;
  String _optOutOfTest="" ;
  int coupleCounselling=0;
  int _patientPretest = 0;
  int _optOutTest = 0;
  int newTest = 0;


  @override
  void initState() {
  getDropDrowns();

 /* print('=================================== htsModelList ${_htsModelList.length}');
  print('=================================== purposeOfTestList ${_purposeOfTestList.length}');*/
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

   //* List htsModelList = [];
    List purposeOfTestList = [];

    List reasonForNotIssuingResultList = [];

    try {
      reasonForNotIssuingResultList= jsonDecode(await htsChannel.invokeMethod('reasonForNotIssuingResultOptions'));

      purposeOfTestList= jsonDecode(await htsChannel.invokeMethod('purposeOfTestsOptions'));

       } catch (e) {
      print("channel failure: '$e'");
    }

    setState(() {
      /*_htsModelList = HtsModel.mapFromJson(htsModelList);
      _purposeOfTestList = PurposeOfTest.mapFromJson(purposeOfTestList);*/

      reasonForNotIssuingResultList = ReasonForNotIssuingResult.mapFromJson(reasonForNotIssuingResultList);


      _dropDownMenuItemsReasonForNotIssuingResult =
          getDropDownMenuItemsReasonForNotIssuingResult();


      _currentHtsModel = _dropDownMenuItemsHtsModel[0].value;
      _currentPurposeOfTest = _dropDownMenuItemsPurposeOfTest[0].value;

      _currentReasonForNotIssuingResult = _dropDownMenuItemsReasonForNotIssuingResult[0].value;
    });






  }


   void _handleHtsChange(int value) {
    setState(() {
      _hts = value;

      switch (_hts) {
        case 1:
          _htsApproach = "PITC";
          break;
        case 2:
          _htsApproach = "CITC";
          break;
      }
    });
  }

   void _handleCoupleCounsellingChange(int value) {
    setState(() {

  coupleCounselling=value;
      switch (coupleCounselling) {
        case 1:
          _coupleCounselling = "Yes";
          break;
        case 2:
          _coupleCounselling = "No";
          break;
      }
    });
  }

   void _handlePatientPretestChange(int value) {
    setState(() {
      _patientPretest = value;

      switch (_patientPretest) {
        case 1:
          _preTestInfoGiven = "Yes";
          break;
        case 2:
          _preTestInfoGiven = "No";
          break;
      }
    });
  }

    void _handleOptOutTestChange(int value) {
    setState(() {
      _optOutTest = value;

      switch (_optOutTest) {
        case 1:
          _optOutOfTest = "Yes";
          break;
        case 2:
          _optOutOfTest = "No";
          break;
      }
    });
  }

  void _handleNewTestChange(int value) {
    setState(() {
      newTest = value;

      switch (newTest) {
        case 1:
          _newTest = "Yes";
          break;
        case 2:
          _newTest = "No";
          break;
      }
    });
  }

  List<DropdownMenuItem<String>>
      _dropDownMenuItemsHtsModel,
      _dropDownMenuItemsPurposeOfTest,
  _dropDownMenuItemsReasonForNotIssuingResult;


  String  _currentHtsModel;
  String _currentPurposeOfTest;
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
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('HTS Approach'),
                          ),
                          width: 250,
                        ),
                      ),
                      Text('PITC'),
                      Radio(
                          value: 1,
                          groupValue: _hts,
                          onChanged: _handleHtsChange),
                      Text('CITC'),
                      Radio(
                          value: 2,
                          groupValue: _hts,
                          onChanged: _handleHtsChange)
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
             /*     Container(
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
                          value: _currentHtsModel,
                          items: _dropDownMenuItemsHtsModel,
                          onChanged: changedDropDownItemHtsModel,
                        ),
                      ),
                      borderSide: BorderSide(
                        color: Colors.blue, //Color of the border
                        style: BorderStyle.solid, //Style of the border
                        width: 2.0, //width of the border
                      ),
                      onPressed: () {},
                    ),
                  ),*/



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
                    height: 20.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('New test in patients life?'),
                          ),
                          width: 250,
                        ),
                      ),
                      Text('PITC'),
                      Radio(
                          value: 1,
                          groupValue: _hts,
                          onChanged: _handleHtsChange),
                      Text('CITC'),
                      Radio(
                          value: 2,
                          groupValue: _hts,
                          onChanged: _handleHtsChange)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Couple Counselling'),
                          ),
                          width: 250,
                        ),
                      ),
                      Text('Yes'),
                      Radio(
                          value: 1,
                          groupValue: coupleCounselling,
                          onChanged: _handleCoupleCounsellingChange),
                      Text('No'),
                      Radio(
                          value: 2,
                          groupValue: coupleCounselling,
                          onChanged: _handleCoupleCounsellingChange)
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
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
                          value: _currentPurposeOfTest,
                          items: _dropDownMenuItemsPurposeOfTest,
                          onChanged: changedDropDownItemPurposeOfTest,
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
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Pre-Test information given.'),
                          ),
                          width: 250,
                        ),
                      ),
                      Text('Yes'),
                      Radio(
                          value: 1,
                          groupValue: _patientPretest,
                          onChanged: _handlePatientPretestChange),
                      Text('No'),
                      Radio(
                          value: 2,
                          groupValue: _patientPretest,
                          onChanged: _handlePatientPretestChange)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Opt out of test'),
                          ),
                          width: 250,
                        ),
                      ),
                      Text('Yes'),
                      Radio(
                          value: 1,
                          groupValue: _optOutTest,
                          onChanged: _handleOptOutTestChange),
                      Text('No'),
                      Radio(
                          value: 2,
                          groupValue: _optOutTest,
                          onChanged: _handleOptOutTestChange)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                'New test for pregnant and lactating women.'),
                          ),
                          width: 250,
                        ),
                      ),
                      Text('Yes'),
                      Radio(
                          value: 1,
                          groupValue: newTest,
                          onChanged: _handleNewTestChange),
                      Text('No'),
                      Radio(
                          value: 2,
                          groupValue: newTest,
                          onChanged: _handleNewTestChange)
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
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

  void changedDropDownItemHtsModel(String value) {
    setState(() {
      _currentHtsModel = value;

    });
  }
  void changedDropDownItemPurposeOfTest(String value) {
    setState(() {
      _currentPurposeOfTest = value;

    });
  }

  void changedDropDownItemReasonForNotIssuingResult(String value) {
    setState(() {
      _currentReasonForNotIssuingResult = value;

    });
  }

}
