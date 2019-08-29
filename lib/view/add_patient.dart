
import 'dart:convert';

import 'package:ehr_mobile/model/patient.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import 'edit_demographics.dart';

class AddPatient extends StatefulWidget {
  @override
  State createState() {
    return _AddPatient();
  }
}

class _AddPatient extends State<AddPatient> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
   static final MethodChannel addPatient= MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/addPatient');
  String lastName, firstName, nationalId, nationalIdNumber;

  var birthDate,displayDate;
  bool showError=false;
  int _gender = 0;
  String gender = "";
  String _identifier;
  List<DropdownMenuItem<String>> _identifierDropdownMenuItem;
  List _identifierList = [
    "Select Identifier",
    "Passport",
    "Birth Certificate",
    "National Id",
    "Driver's Licence"
  ];
  String _nationalIdError="National Id number is invalid";

  @override
  void initState() {
    displayDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    birthDate = DateTime.now();

    _identifierDropdownMenuItem = getIdentifierDropdownMenuItems();
    _identifier = _identifierDropdownMenuItem[0].value;
    super.initState();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),

        firstDate: DateTime(1900, 8),

        lastDate: DateTime(2101));
    if (picked != null && picked != birthDate)
      setState(() {
        birthDate = picked;
        displayDate = DateFormat("yyyy/MM/dd").format(picked);
      });
  }

  void _handleGenderChange(int value) {
    setState(() {
      _gender = value;

      switch (_gender) {
        case 1:
          gender = "MALE";
          break;
        case 2:
          gender = "FEMALE";

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
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Add Patient'),
      ),
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
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      return value.isEmpty ? 'Enter National Id number' : null;
                    },
                    onSaved: (value) => setState(() {

                      nationalId = value;

                    }),
                    decoration: InputDecoration(

                        labelText: _identifier == "Select Identifier"
                            ? "ID Number"
                            : _identifier + " Number",
                        border: OutlineInputBorder()),

                  ),
                  !showError
                      ? SizedBox.shrink()
                      : Text(
                    _nationalIdError ?? "",
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      return value.isEmpty ? 'Enter Last Name' : null;
                    },
                    onSaved: (value) => setState(() {
                      lastName = value;
                    }),
                    decoration: InputDecoration(
                        labelText: 'Last Name', border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      return value.isEmpty ? 'Enter First Name' : null;
                    },
                    onSaved: (value) => setState(() {
                      firstName = value;
                    }),
                    decoration: InputDecoration(
                        labelText: 'First Name', border: OutlineInputBorder()),
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
                            child: Text('Sex'),
                          ),
                          width: 250,
                        ),
                      ),
                      Text('Male'),
                      Radio(
                          value: 1,
                          groupValue: _gender,
                          activeColor: Colors.blue,
                          onChanged: _handleGenderChange),
                      Text('Female'),
                      Radio(
                          value: 2,
                          groupValue: _gender,
                          activeColor: Colors.blue,
                          onChanged: _handleGenderChange)
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

                              TextEditingController(text: displayDate),

                              validator: (value) {
                                return value.isEmpty ? 'Enter some text' : null;
                              },
                              decoration: InputDecoration(

                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(0.0))),

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
                        "Register Patient",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),

                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

//                           Patient patient= Patient.basic(nationalId, firstName, lastName, gender);
//                           await registerPatient(patient);
                          setState(() {
                            nationalIdNumber = nationalId.replaceAll(
                                new RegExp(r'[^\w\s]+'), '');
                          });
                          RegExp regex = new RegExp(
                              r'((\d{8,10})([a-zA-Z])(\d{2})\b)');
                          if (regex.hasMatch(nationalIdNumber)) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditDemographics(
                                            lastName, firstName, birthDate, gender,
                                            nationalId)));
                          }
                          else{

                            showError=true;

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


 Future<void> registerPatient(Patient patient)async{
    String response;
    try {
      String jsonPatient = jsonEncode(patient);
      response= await addPatient.invokeMethod('registerPatient',jsonPatient);
    }
    catch(e){
      print('Something went wrong...... cause $e');
    }
 }

}
