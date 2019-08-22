import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter/services.dart';

import 'edit_demographics.dart';

class HivScreening extends StatefulWidget {
  @override
  State createState() {
    return _HivScreening();
  }
}

class _HivScreening extends State<HivScreening> {
  final _formKey = GlobalKey<FormState>();
  String lastName, firstName;
  var selectedDate;
  DateTime date;
  int _result = 0;
  int _prophylaxisTest = 0;
  int _test = 0;
  String result = "";
  String test = "";
  String prophylaxisTest = "";
  String _identifier;
  List<DropdownMenuItem<String>> _identifierDropdownMenuItem;
  List _identifierList = [
    "Select Identifier",
    "Passport",
    "Birth Certificate",
    "National Id",
    "Driver's Licence"
  ];

  @override
  void initState() {
    selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    date = DateTime.now();
    _identifierDropdownMenuItem = getIdentifierDropdownMenuItems();
    _identifier = _identifierDropdownMenuItem[0].value;
    super.initState();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1920, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = DateFormat("yyyy/MM/dd").format(picked);
      });
  }

  void _handleGenderChange(int value) {
    setState(() {
      _result = value;

      switch (_result) {
        case 1:
          result = "Yes";
          break;
        case 2:
          result = "No";
          break;
        case 3:
          result = "Unknown";
          break;
      }
    });
  }

  void _handleProphylaxisTestChange(int value) {
    setState(() {
      _prophylaxisTest = value;

      switch (_prophylaxisTest) {
        case 1:
          prophylaxisTest = "Yes";
          break;
        case 2:
          prophylaxisTest = "No";
          break;
      }
    });
  }

  void _handleTestChange(int value) {
    setState(() {
      _test = value;

      switch (_test) {
        case 1:
          test = "Yes";
          break;
        case 2:
          test = "No";
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

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      // appBar: AppBar(
      // title: Text('HIV Screening'),
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
                            child:
                                Text('Have you ever been on HIV Prophylaxis'),
                          ),
                          width: 250,
                        ),
                      ),
                      Text('Yes'),
                      Radio(
                          value: 1,
                          groupValue: _prophylaxisTest,
                          onChanged: _handleProphylaxisTestChange),
                      Text('No'),
                      Radio(
                          value: 2,
                          groupValue: _prophylaxisTest,
                          onChanged: _handleProphylaxisTestChange)
                    ],
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
                            child: Text('Have you ever been tested?'),
                          ),
                          width: 250,
                        ),
                      ),
                      Text('Yes'),
                      Radio(
                          value: 1,
                          groupValue: _test,
                          onChanged: _handleTestChange),
                      Text('No'),
                      Radio(
                          value: 2,
                          groupValue: _test,
                          onChanged: _handleTestChange)
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
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
                                  labelText: 'HIV Test Date',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(0.0))),
                            ),
                          ),
                          width: 100,
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.calendar_today,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            _selectDate(context);
                          })
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text('HIV RESULT?'),
                          ),
                          width: 300,
                        ),
                      ),
                      Text('[ - ]'),
                      Radio(
                          value: 1,
                          groupValue: _result,
                          onChanged: _handleGenderChange),
                      Text('[ + ]'),
                      Radio(
                          value: 2,
                          groupValue: _result,
                          onChanged: _handleGenderChange),
                      Text('Unknown'),
                      Radio(
                          value: 3,
                          groupValue: _result,
                          onChanged: _handleGenderChange),
                    ],
                  ),
                  SizedBox(
                    height: 25.0,
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
                        "SAVE",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();


                          print("=--------------------=-=-=-=-=-");
                          print(selectedDate);
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) => EditDemographics(
//                                      lastName, firstName, date, result)));
//////
//              Scaffold.of(context).showSnackBar(SnackBar(content: Text('Contact saved')));
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
}
