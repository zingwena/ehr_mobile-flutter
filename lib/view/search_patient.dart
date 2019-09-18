import 'dart:convert';


import 'package:ehr_mobile/model/person.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
  List<Person> _patientList;

  Future<void> searchPatient(String searchItem) async {
    List<dynamic> list;

    try {
      list =
          jsonDecode(await platform.invokeMethod('searchPerson', searchItem));
    } catch (e) {
      print("channel failure: '$e'");
    }
    setState(() {
      _patientList = Person.fromJsonDecodedMap(list);
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
                            isThreeLine: true,
                            leading: Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: IconButton(
                                // For this situation your icon name should be humanFemale
                                icon: new Icon(patient.sex == "MALE" ? MdiIcons.humanMale : MdiIcons.humanFemale,
                                    color: Colors.blue, size: 35),
                                onPressed: () {},
                              ),
                            ),
                            title: Text(
                              patient.firstName + " " + patient.lastName,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    'ID Number : ' + nullHandler(patient.nationalId),
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'DOB : ' + nullHandler(DateFormat("yyyy/MM/dd").format(patient.birthDate)),
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            trailing: Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                              child: Icon(
                                Icons.chevron_right,
                                size: 36,
                                color: Colors.blue,
                              ),
                            ),
                            onTap: (){
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

        ],
      ),
    );
  }
}
