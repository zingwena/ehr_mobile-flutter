import 'dart:convert';

import 'package:ehr_mobile/model/patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'add_patient.dart';
import 'list_patients.dart';
import 'patient_overview.dart';
import 'reception_vitals.dart';

class SearchPatient extends StatefulWidget {
  _SearchPatientState createState() => _SearchPatientState();
}

class _SearchPatientState extends State<SearchPatient> {
  static const platform = MethodChannel('ehr_mobile.channel/patient');
  String searchItem;
  final _searchFormKey = GlobalKey<FormState>();
  List<Patient> _patientList;

  Future<void> searchPatient(String searchItem) async {
    List<dynamic> list;

    try {
      list =
          jsonDecode(await platform.invokeMethod('searchPatient', searchItem));
    } catch (e) {
      print("channel failure: '$e'");
    }
    setState(() {
      _patientList = Patient.fromJsonDecodedMap(list);
    });

    print("=====================searched$_patientList");
  }

  String nullHandler(String value) {
    return value == null ? "" : value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //  title: Text('Search Patient'),
      // ),
      backgroundColor: Colors.white,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 25.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: Form(
              key: _searchFormKey,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  suffix: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () async {
                        if (_searchFormKey.currentState.validate()) {
                          _searchFormKey.currentState.save();

                          await searchPatient(searchItem);
                        }
                      }),
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  setState(() {
                    searchItem = value;
                  });
                },
              ),
            ),
          ),
          _patientList == null
              ? SizedBox()
              : _patientList != null && _patientList.isNotEmpty
                  ? Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(10.0),
                        children: _patientList.map((patient) {
                          return ListTile(
                            title: Text(nullHandler(patient.firstName) +
                                " " +
                                nullHandler(patient.lastName)),
                            leading: Text(nullHandler(patient.sex)),
                            subtitle:
                                Text(nullHandler(patient.birthDate.toString())),
                            trailing: Text(patient.nationalId),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Overview(patient)));
                            },
                          );
                        }).toList(),
                      ),
                    )
                  : Center(
                      child: Text("No Patients Found"),
                    ),
          _patientList != null
              ? OutlineButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  color: Colors.white,
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Add Patient",
                    style: TextStyle(
                        fontSize: 23,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500),
                  ),
                  borderSide: BorderSide(
                    color: Colors.blue, //Color of the border
                    style: BorderStyle.solid, //Style of the border
                    width: 3.0, //width of the border
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddPatient()),
                  ),
                )
              : SizedBox(),
          OutlineButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            color: Colors.white,
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "VITALS",
              style: TextStyle(
                  fontSize: 23,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
            ),
            borderSide: BorderSide(
              color: Colors.blue, //Color of the border
              style: BorderStyle.solid, //Style of the border
              width: 3.0, //width of the border
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReceptionVitals()),
            ),
          )
        ],
      ),
    );
  }
}
