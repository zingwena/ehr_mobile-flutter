import 'dart:convert';

import 'package:ehr_mobile/model/patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    }  catch (e) {
      print("channel failure: '$e'");
    }
    setState(() {
      _patientList = Patient.mapFromJson(list);
    });

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
                  suffix: IconButton(icon: Icon(Icons.search), onPressed: (){
                    if(_searchFormKey.currentState.validate()){
                      _searchFormKey.currentState.save();
                      searchPatient(searchItem);
                    }
                     }),
                  border: OutlineInputBorder(),
                ),
                onSaved: (value){
                  setState(() {
                    searchItem = value;
                  });
                },
              ),
            ),

          ),
          _patientList != null && _patientList.length != 0
              ? Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(10.0),
                    children: _patientList.map((patient) {
                      return ListTile(title: Text(patient.name));
                    }).toList(),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
