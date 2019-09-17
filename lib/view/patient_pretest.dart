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
  List<HtsModel> _htsModelList=List();
  List<PurposeOfTest> _purposeOfTestList= List();

  int _hts = 0;
 // String _coupleCounselling="" ;
  String _newTest="" ;
  String _htsApproach="" ;

  int _patientPretest = 0;
  //int _optOutTest = 0;
  int newTest = 0;


  bool _preTestInfoGiven=false ;
  String preTestInfoGiven = "NO";

  bool _optOutOfTest=false ;
  String optOutOfTest = "NO";

  bool _coupleCounselling=false;
  String coupleCounselling="NO";


  @override
  void initState() {
  getDropDrowns();

  print('=================================== htsModelList ${_htsModelList.length}');
  print('=================================== purposeOfTestList ${_purposeOfTestList.length}');





    super.initState();
  }

  Future<void> insertPreTest(PreTest preTest) async {


    try {

          await htsChannel.invokeMethod('savePreTest',  jsonEncode(preTest));
    } catch (e) {
      print("channel failure: '$e'");
    }


  }

  List<DropdownMenuItem<String>>
  getDropDownMenuItemsHtsModel() {
    List<DropdownMenuItem<String>> items = new List();
    for (HtsModel htsModel in _htsModelList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(
          DropdownMenuItem(value: htsModel.code, child: Text(htsModel.name)));
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
          DropdownMenuItem(value: purposeOfTest.code, child: Text(purposeOfTest.name)));
    }
    return items;
  }


  Future<void> getDropDrowns() async {

    List htsModelList = [];
    List purposeOfTestList = [];

    try {
      htsModelList= jsonDecode(await htsChannel.invokeMethod('htsModelOptions'));

      purposeOfTestList= jsonDecode(await htsChannel.invokeMethod('purposeOfTestsOptions'));

       } catch (e) {
      print("channel failure: '$e'");
    }

    setState(() {
      _htsModelList = HtsModel.mapFromJson(htsModelList);
      _purposeOfTestList = PurposeOfTest.mapFromJson(purposeOfTestList);


      _dropDownMenuItemsHtsModel =
          getDropDownMenuItemsHtsModel();

      _dropDownMenuItemsPurposeOfTest =
          getDropDownMenuItemsPurposeOfTest();

      _currentHtsModel = _dropDownMenuItemsHtsModel[0].value;
      _currentPurposeOfTest = _dropDownMenuItemsPurposeOfTest[0].value;
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
      _dropDownMenuItemsPurposeOfTest;


  String  _currentHtsModel;
  String _currentPurposeOfTest;




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
                    height: 10.0,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Couple Counselling"),
                      Checkbox(
                        value:_coupleCounselling,
                        onChanged: (bool value) {
                          setState(() {
                            _coupleCounselling=value;
                          });
                          if(value) {
                            setState(() {
                              coupleCounselling="YES";
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Pre-test Information given"),
                      Checkbox(
                        value:_preTestInfoGiven,
                        onChanged: (bool value) {
                          setState(() {
                            _preTestInfoGiven=value;
                          });
                          if(value) {
                            setState(() {
                              preTestInfoGiven="YES";
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


                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Opt Out Of Test"),
                      Checkbox(
                        value:_optOutOfTest,
                        onChanged: (bool value) {
                          setState(() {
                            _optOutOfTest=value;
                          });
                          if(value) {
                            setState(() {
                              optOutOfTest="YES";
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
