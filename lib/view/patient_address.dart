import 'dart:convert';

import 'package:ehr_mobile/model/address.dart';
import 'package:ehr_mobile/model/patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PatientAddress extends StatefulWidget {
  final Patient patient;

  PatientAddress(this.patient);

  @override
  State createState() {
    return _PatientAddressState();
  }
}

class _PatientAddressState extends State<PatientAddress> {
  static const platform = MethodChannel('example.channel.dev/people');
  static final MethodChannel addPatient= MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/addPatient');

  static const patientPlatform =
  MethodChannel('example.channel.dev/singlePatient');

  final _formKey = GlobalKey<FormState>();
  String schoolHouse, suburbVillage, town, patient;

  List<DropdownMenuItem<String>> _dropDownMenuItems, _dropDownMenuItemsTown;

  String _currentTown;

  List _townList = ["Select Town", "Harare", "Marondera", "Rusape", "Mutare"];

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItemsTown();
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsTown() {
    List<DropdownMenuItem<String>> items = new List();
    for (String town in _townList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(value: town, child: Text(town)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Person Address"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    return value.isEmpty ? 'Enter some text' : null;
                  },
                  onSaved: (value) => setState(() {
                    schoolHouse = value;
                  }),
                  decoration: InputDecoration(
                      labelText: 'School/House No.',
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Divider(),
                TextFormField(
                  validator: (value) {
                    return value.isEmpty ? 'Enter some text' : null;
                  },
                  onSaved: (value) => setState(() {
                    suburbVillage = value;
                  }),
                  decoration: InputDecoration(
                      labelText: 'Suburb/Village',
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Divider(),
                TextFormField(
                  validator: (value) {
                    return value.isEmpty ? 'Enter some text' : null;
                  },
                  onSaved: (value) => setState(() {
                    town = value;
                  }),
                  decoration: InputDecoration(
                      labelText: 'Current Town', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      color: Colors.blue,
                      padding: const EdgeInsets.all(20.0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Back",
                        style: TextStyle(color: Colors.white),

                      ),
                    ),
                    RaisedButton(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      color: Colors.blue,
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Patient patient = widget.patient;
      Address address = Address(schoolHouse, suburbVillage, town);
      patient.address = address;
      registerPatient(patient);

      print('%%%%%%%%%%%%%%%%%%$patient');
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) => Overview(patient)));
    }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
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


  void changedDropDownItemTown(String selectedTown) {
    setState(() {
      _currentTown = selectedTown;
    });
  }
}
