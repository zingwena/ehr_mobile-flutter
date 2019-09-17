import 'dart:convert';

import 'package:ehr_mobile/model/preTest.dart';
import 'package:ehr_mobile/model/purposeOfTest.dart';
import 'package:ehr_mobile/model/htsModel.dart';

import 'package:ehr_mobile/view/hts_testing.dart';
import 'package:ehr_mobile/view/hts_testing.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'edit_demographics.dart';
import 'hts_testscreening.dart';
import 'rounded_button.dart';

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
  String _newTestInLife = "";
  HtsModel htsModel;
  PurposeOfTest purposeOfTest;

  int _patientPretest = 0;
  //int _optOutTest = 0;
  int newTest = 0;
  int newTestInLife = 0;


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

  Future <void> getHtsModelByName(String htsmodelstring) async{
    var model_response;
    try{
        model_response = await htsChannel.invokeMethod('getHtsModel', htsmodelstring);
        htsModel = HtsModel.mapFromJson(model_response);

    }catch (e){
      print("channel failure: '$e'");

    }
  }
  Future <void> getPurposeByName(String purposemodelstring) async{
    var model_response;
    try{
      model_response = await htsChannel.invokeMethod('getPurposeofTest', purposemodelstring);
      purposeOfTest = PurposeOfTest.mapFromJson(model_response);

    }catch (e){
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
 void _handleNewTestInLife(int value){
    setState(() {
      newTestInLife = value;
      switch(newTestInLife){
        case 1:
          _newTestInLife = "Yes";
          break;
        case 2:
          _newTestInLife = "No";
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

  bool showInput = true;
  bool showInputTabOptions = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.blue],
              ),
            ),
            height: 210.0,
          ),
          new AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            title: new Text("Pre-Test Counselling"),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 40.0),
              child: new Column(
                children: <Widget>[
                  _buildButtonsRow(),
                  Expanded(
                    child: WillPopScope(
                      onWillPop: () {
                        if (!showInput) {
                          setState(() {
                            showInput = true;
                            showInputTabOptions = true;
                          });
                          return Future(() => false);
                        } else {
                          return Future(() => true);
                        }
                      },
                      child: new Card(
                        elevation: 4.0,
                        margin: const EdgeInsets.all(8.0),
                        child: DefaultTabController(
                          child: new LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints viewportConstraints) {
                              return Column(
                                children: <Widget>[
                                  //  _buildTabBar(),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: new ConstrainedBox(
                                        constraints: new BoxConstraints(
                                          minHeight:
                                          viewportConstraints.maxHeight -
                                              48.0,
                                        ),
                                        child: new IntrinsicHeight(
                                          child: Column(
                                            children: <Widget>[
                                              Form(
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


                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                      child:        Row(
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
                                                          Text('Yes'),
                                                          Radio(
                                                              value: 1,
                                                              groupValue: newTestInLife,
                                                              onChanged: _handleNewTestInLife),
                                                          Text('No'),
                                                          Radio(
                                                              value: 2,
                                                              groupValue: newTestInLife,
                                                              onChanged: _handleNewTestInLife)
                                                        ],
                                                      ),
                                                    ),


                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                      child: Row(
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


                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                      child: Row(
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
                                                    ),


                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                      child:            Row(
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
                                                    ),


                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                      child:  Row(
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
                                                    ),


                                                    SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
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
                                                            getPurposeByName(_currentPurposeOfTest);
                                                            getHtsModelByName(_currentHtsModel);
                                                            PreTest patient_pretest = PreTest(_htsApproach, _newTest, coupleCounselling,
                                                                preTestInfoGiven, optOutOfTest, _newTest, htsModel,purposeOfTest);
                                                            insertPreTest(patient_pretest);
                                                            Navigator.push(context,MaterialPageRoute(
                                                              builder: (context)=> HtsScreeningTest()
                                                            ));
 /*   Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => Overview(registeredPatient)));
    });*/
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                          length: 3,
                        ),
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

  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(
            text: "Pre-test",selected: true,
          ),
          new RoundedButton(
            text: "Testing",
          ),
          new RoundedButton(text: "Post-Testing",
          ),
        ],
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


