import 'dart:convert';

import 'package:ehr_mobile/model/preTest.dart';
import 'package:ehr_mobile/model/purposeOfTest.dart';
import 'package:ehr_mobile/model/htsModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'edit_demographics.dart';

class PatientPretest extends StatefulWidget {
  @override
  State createState() {
    return _PatientPretest();
  }
}

class _PatientPretest extends State<PatientPretest> {
  static const platform = MethodChannel('example.channel.dev/people');

  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  final _formKey = GlobalKey<FormState>();
  PreTest preTest;
  List<HtsModel> _htsModelList;
  List<PurposeOfTest> _purposeOfTestList;

  int _hts = 0;
  int _coupleCounselling = 0;
  int _patientPretest = 0;
  int _optOutTest = 0;
  int _newTest = 0;


  @override
  void initState() {
    getDropDrowns();
    _dropDownMenuItemsHtsModel =
        getDropDownMenuItemsHtsModel();

    _dropDownMenuItemsPurposeOfTest =
    getDropDownMenuItemsPurposeOfTest();
//    List<DropdownMenuItem<String>> _identifierDropdownMenuItem;
//    _identifierDropdownMenuItem = getIdentifierDropdownMenuItems();
//    _identifier = _identifierDropdownMenuItem[0].value;

    _currentHtsModel = _dropDownMenuItemsHtsModel[0].value;
    _currentPurposeOfTest = _dropDownMenuItemsPurposeOfTest[0].value;

    super.initState();
  }

  Future<void> insertPreTest(PreTest preTest) async {


    try {

          await platform.invokeMethod('savePreTest',  jsonEncode(preTest));
    } catch (e) {
      print("channel failure: '$e'");
    }


  }


  Future<void> getDropDrowns() async {

    List htsModelList;
    List purposeOfTestList;


    try {
      htsModelList= jsonDecode(await platform.invokeMethod('htsModelOptions'));
      purposeOfTestList= jsonDecode(await platform.invokeMethod('purposeOfTestsOptions'));
    } catch (e) {
      print("channel failure: '$e'");
    }

    setState(() {
      _htsModelList = PreTest.mapFromJson(htsModelList);
      _purposeOfTestList = PreTest.mapFromJson(purposeOfTestList);
    });


  }


   void _handleHtsChange(int value) {
    setState(() {
      _hts = value;

      switch (_hts) {
        case 0:
          preTest.htsApproach = "PITC";
          break;
        case 1:
          preTest.htsApproach = "CITC";
          break;
      }
    });
  }

   void _handleCoupleCounsellingChange(int value) {
    setState(() {
      _coupleCounselling = value;

      switch (_coupleCounselling) {
        case 0:
          preTest.coupleCounselling = "Yes";
          break;
        case 1:
          preTest.coupleCounselling = "No";
          break;
      }
    });
  }

   void _handlePatientPretestChange(int value) {
    setState(() {
      _patientPretest = value;

      switch (_patientPretest) {
        case 0:
          preTest.preTestInfoGiven = "Yes";
          break;
        case 1:
          preTest.preTestInfoGiven = "No";
          break;
      }
    });
  }

    void _handleOptOutTestChange(int value) {
    setState(() {
      _optOutTest = value;

      switch (_optOutTest) {
        case 0:
          preTest.optOutOfTest = "Yes";
          break;
        case 1:
          preTest.optOutOfTest = "No";
          break;
      }
    });
  }

  void _handleNewTestChange(int value) {
    setState(() {
      _newTest = value;

      switch (_newTest) {
        case 0:
          preTest.newTest = "Yes";
          break;
        case 1:
          preTest.newTest = "No";
          break;
      }
    });
  }

  List<DropdownMenuItem<String>>
      _dropDownMenuItemsHtsModel,
      _dropDownMenuItemsPurposeOfTest;


  String  _currentHtsModel;
  String _currentPurposeOfTest;

  List<DropdownMenuItem<String>>
      getDropDownMenuItemsHtsModel() {
    List<DropdownMenuItem<String>> items = new List();
    for (HtsModel htsModel in _htsModelList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(
          DropdownMenuItem(value: htsModel.id.toString(), child: Text(htsModel.name)));
    }
    return items;
  }

  List<DropdownMenuItem<String>>
  getDropDownMenuItemsPurposeOfTest() {
    List<DropdownMenuItem<String>> items = new List();
    for (PurposeOfTest purposeOfTest in _purposeOfTestList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(
          DropdownMenuItem(value: purposeOfTest.id.toString(), child: Text(purposeOfTest.name)));
    }
    return items;
  }


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
                          value: 0,
                          groupValue: _hts,
                          onChanged: _handleHtsChange),
                      Text('CITC'),
                      Radio(
                          value: 1,
                          groupValue: _hts,
                          onChanged: _handleHtsChange)
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
                          value: 0,
                          groupValue: _hts,
                          onChanged: _handleHtsChange),
                      Text('CITC'),
                      Radio(
                          value: 1,
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
                          value: 0,
                          groupValue: _coupleCounselling,
                          onChanged: _handleCoupleCounsellingChange),
                      Text('No'),
                      Radio(
                          value: 1,
                          groupValue: _coupleCounselling,
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
                          value: 0,
                          groupValue: _patientPretest,
                          onChanged: _handlePatientPretestChange),
                      Text('No'),
                      Radio(
                          value: 1,
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
                          value: 0,
                          groupValue: _optOutTest,
                          onChanged: _handleOptOutTestChange),
                      Text('No'),
                      Radio(
                          value: 1,
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
                          value: 0,
                          groupValue: _newTest,
                          onChanged: _handleNewTestChange),
                      Text('No'),
                      Radio(
                          value: 1,
                          groupValue: _newTest,
                          onChanged: _handleNewTestChange)
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
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


                          insertPreTest(preTest);
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

}
