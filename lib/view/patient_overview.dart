import 'dart:convert';
import 'package:ehr_mobile/model/patient.dart';
import 'package:ehr_mobile/view/patient_post_test.dart';
import 'package:ehr_mobile/view/patient_pretest.dart';
import 'package:flutter/material.dart';

import 'hiv_screening.dart';
import 'home_page.dart';
import 'reception_vitals.dart';
import 'package:ehr_mobile/model/address.dart';

class Overview extends StatefulWidget {
  final Patient patient;

  Overview(this.patient);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OverviewState();
  }
}

class OverviewState extends State<Overview> {

  Patient _patient;
  Map<String, dynamic> details;

  @override
  void initState() {
    _patient = widget.patient;
    super.initState();
  }

  String nullHandler(String value) {
    return value == null ? "" : value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Patient Record'),
      ),
      backgroundColor: Colors.blue.shade200,
      body: ListView(
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
                        height: 860,
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: RaisedButton(
                                            elevation: 4.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5.0)),color: Colors.blue,
                                            padding: const EdgeInsets.all(20.0),
                                            child: Text(
                                              "Vitals",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),onPressed: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReceptionVitals(_patient.id)),
                                            ),
                                          ),
                                        ),
                                        width: 100,
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: RaisedButton(
                                            elevation: 4.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5.0)),color: Colors.blue,
                                            padding: const EdgeInsets.all(20.0),
                                            child: Text(
                                              "HTS",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            onPressed: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HivScreening()),
                                            ),
                                          ),
                                        ),
                                        width: 100,
                                      ),
                                    ),

                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: RaisedButton(
                                            elevation: 4.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5.0)),color: Colors.blue,
                                            padding: const EdgeInsets.all(20.0),
                                            child: Text(
                                              "Pre-Test",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            onPressed: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PatientPretest()),
                                            ),
                                          ),
                                        ),
                                        width: 100,
                                      ),
                                    ),

                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: RaisedButton(
                                            elevation: 4.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5.0)),color: Colors.blue,
                                            padding: const EdgeInsets.all(20.0),
                                            child: Text(
                                              "Post Test Counselling",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            onPressed: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PatientPostTest()),
                                            ),
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
                                              "Close Patient Record",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                               onPressed: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage()),
                                            ),

                                          ),
                                        ),
                                        width: 100,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                new Container(
                                  child: new Text(
                                    "Demographic Details",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: TextField(
                                            controller: TextEditingController(
                                                text:  _patient.firstName + " " + _patient.lastName),
                                            decoration: InputDecoration(
                                              labelText: 'Full Name',
                                              border: OutlineInputBorder(),
                                            ),
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        width: 100,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: TextField(
                                            controller: TextEditingController(
                                          text: nullHandler(_patient.sex)),

                                            decoration: InputDecoration(
                                              labelText: 'Sex',
                                              border: OutlineInputBorder(),
                                            ),
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        width: 100,
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: TextField(
                                            controller: TextEditingController(
                                                text: nullHandler(_patient.nationalId)),
                                            decoration: InputDecoration(
                                              labelText: 'National ID',
                                              border: OutlineInputBorder(),
                                            ),
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        width: 100,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: TextField(
                                            controller: TextEditingController(
                                                text: '20/01/1988'),
                                            decoration: InputDecoration(
                                              labelText: 'Date Of Birth',
                                              border: OutlineInputBorder(),
                                            ),
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        width: 100,
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: TextField(
                                            controller: TextEditingController(
                                                text: nullHandler(_patient.maritalStatus)),
                                            decoration: InputDecoration(
                                              labelText: 'Marital Status',
                                              border: OutlineInputBorder(),
                                            ),
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        width: 100,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,

                                  children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: TextField(
                                            controller: TextEditingController(
                                  text: nullHandler(_patient.educationLevel)),
                                            decoration: InputDecoration(
                                              labelText: 'Education',
                                              border: OutlineInputBorder(),
                                            ),
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        width: 100,
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: TextField(
                                            controller: TextEditingController(
                                                text:  nullHandler(_patient.occupation)),

                                            decoration: InputDecoration(
                                              labelText: 'Occupation',
                                              border: OutlineInputBorder(),
                                            ),
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        width: 100,
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: TextField(
                                            controller: TextEditingController(
                                                text: nullHandler(_patient.nationality)),

                                            decoration: InputDecoration(
                                              labelText: 'Nationality',
                                              border: OutlineInputBorder(),
                                            ),
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        width: 100,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                Text(
                                  "Address And Contact Details",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,

                                  children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: TextFormField(
                                            controller: TextEditingController(

                                                text: "address"),
                                            decoration: InputDecoration(
                                              labelText: 'Address',
                                              border: OutlineInputBorder(),
                                            ),
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        width: 100,
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: TextField(
                                            controller: TextEditingController(
                                                text: '0774536627'),

                                            decoration: InputDecoration(
                                              labelText: 'Phone Number',
                                              border: OutlineInputBorder(),
                                            ),
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
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
      ),
    );
  }


}
