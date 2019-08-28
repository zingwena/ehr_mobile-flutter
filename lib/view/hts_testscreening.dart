import 'dart:convert';

import 'package:ehr_mobile/model/investigation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter/services.dart';


import 'edit_demographics.dart';


class HtsScreeningTest extends StatefulWidget {
  @override
  State createState() {
    return _HtsScreeningTest();
  }
}

class _HtsScreeningTest extends State<HtsScreeningTest> {
  final _formKey = GlobalKey<FormState>();
  String lastName, firstName;
  var selectedDate;
  DateTime date;
  int _result = 0;
  int _testKit = 0;
  int testCount=0;
  List<dynamic>_testKits=[];

  String testKit = "";
  String result = "";
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

     getPersonInvestigation();
         getTestKitsByCount(testCount);
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
      });
  }

  Future<dynamic> getPersonInvestigation() async {
    try {
      Map<String,dynamic> map = json.decode(await htsChannel.invokeMethod('getSample')) ;
      Investigation investigation = Investigation.fromJson(map)  ;
            print("********Investigation sample from android "+investigation.sample);

          setState(() {
          this.sample=investigation.sample;
          this.test=investigation.test;

          });
      print("*********sample from android"+map.toString());
    } catch (e) {
      print("channel failure: '$e'");
    }
    return sample;
  }


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

  void _handleTestKitChange(int value) {
    setState(() {
      _testKit = value;

      switch (_testKit) {
        case 1:
          testKit = "Positive";
          break;
        case 2:
          testKit = "Negative";
          break;
      }
    });
  }

  void _handleResultChange(int value) {
    setState(() {
      _result = value;

      switch (_result) {
        case 1:
          result = "Positive";
          break;
        case 2:
          result = "Negative";
          break;
        case 3:
          result = "Inconclusive";
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


Widget _body(List <dynamic> list){
return  ListView(
        children: <Widget>[
          Stack(
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
                                             sample,
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
                                              (test),
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
                                          child: TextFormField(
                                            controller: TextEditingController(
                                                text: selectedDate),
                                            validator: (value) {
                                              return value.isEmpty
                                                  ? 'Enter some text'
                                                  : null;
                                            },
                                            decoration: InputDecoration(
                                                labelText: 'Start Date',
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
                                        }),
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: TextFormField(
                                            controller: TextEditingController(
                                                text: selectedDate),
                                            validator: (value) {
                                              return value.isEmpty
                                                  ? 'Enter some text'
                                                  : null;
                                            },
                                            decoration: InputDecoration(
                                                labelText: 'Start Time',
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
                                  height: 28,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: TextFormField(
                                            controller: TextEditingController(
                                                text: selectedDate),
                                            validator: (value) {
                                              return value.isEmpty
                                                  ? 'Enter some text'
                                                  : null;
                                            },
                                            decoration: InputDecoration(
                                                labelText: 'Reading Date',
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
                                        }),
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: TextFormField(
                                            controller: TextEditingController(
                                                text: selectedDate),
                                            validator: (value) {
                                              return value.isEmpty
                                                  ? 'Enter some text'
                                                  : null;
                                            },
                                            decoration: InputDecoration(
                                                labelText: 'Reading Time',
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
                                    Text('Positive'),
                                    Radio(
                                        value: 1,
                                        groupValue: _result,
                                        activeColor: Colors.blue,
                                        onChanged: _handleResultChange),
                                    Text('Negative'),
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
                                            padding: const EdgeInsets.all(20.0),
                                            child: Text(
                                              "Save",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
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
                                    Expanded(
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
        ],
      );
  
  
}
  @override
  Widget build(BuildContext context) {
    var list=this._testKits ;
    return Scaffold(
      // appBar: AppBar(
      //  backgroundColor: Colors.blue,
      //  title: Text('Add Patient'),
      //  ),
    
      body:_body(list)
    );
  }


  
}


