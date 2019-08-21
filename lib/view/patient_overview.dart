import 'dart:convert';

import 'package:ehr_mobile/model/patient.dart';
import 'package:flutter/material.dart';


class Overview extends StatefulWidget {
  Patient patient;

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


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Patient Record'),
      ),
      backgroundColor: Colors.blue.shade50,
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
                          height: 760,
                          width: 320,
                          child: Card(
                            margin: new EdgeInsets.only(
                                left: 30.0,
                                right: 30.0,
                                top: 50.0,
                                bottom: 5.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            elevation: 2.0,
                            child: new Padding(
                              padding: new EdgeInsets.all(25.0),
                              child: new Column(
                                children: <Widget>[
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
                                            padding: const EdgeInsets.all(0.0),
                                            child: TextField(
                                              controller: TextEditingController(
                                                  text: _patient.firstName + " " + _patient.lastName),
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
                                    children: <Widget>[
                                      Expanded(
                                        child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: TextField(
                                              controller: TextEditingController(
                                                  text: _patient.sex),
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
                                    ],
                                  ),

                                  SizedBox(
                                    height: 15,
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: TextField(
                                              controller: TextEditingController(
                                                  text: _patient.nationalId),
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
                                    children: <Widget>[
                                      Expanded(
                                        child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: TextField(
                                              controller: TextEditingController(
                                                  text: _patient.birthDate.toString()),
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
                                    ],
                                  ),

                                  SizedBox(
                                    height: 15,
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: TextField(
                                              controller: TextEditingController(
                                                  text: _patient.maritalStatus.name),
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
                                    children: <Widget>[
                                      Expanded(
                                        child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: TextField(
                                              controller: TextEditingController(
                                                  text: _patient.educationLevel.name),
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
                                    ],
                                  ),

                                  SizedBox(
                                    height: 15,
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: TextField(
                                              controller: TextEditingController(
                                                  text: _patient.occupation.name),
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
                                    ],
                                  ),

                                  SizedBox(
                                    height: 15,
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: TextField(
                                              controller: TextEditingController(
                                                  text: _patient.nationality.name),
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
                                ],
                              ),
                            ),
                          )),
                      Container(
                        height: 300,
                        width: 320,
                        child: Card(
                          margin: new EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 50.0, bottom: 5.0),
                          borderOnForeground: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 2.0,
                          child: new Padding(
                            padding: new EdgeInsets.all(20.0),
                            child: new Column(
                              children: <Widget>[
                                new Container(
                                  child: new Text(
                                    "Address And Contact Details",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 18,
                                ),

                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: TextFormField(
                                            controller: TextEditingController(
                                                text: '24 Gamu Drive Seke 2'),
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
                                  ],
                                ),

                                SizedBox(
                                  height: 15,
                                ),

                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: TextFormField(
                                            controller: TextEditingController(
                                                text: '24 Gamu Drive Seke 2'),
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
                                  ],
                                ),

                                SizedBox(
                                  height: 15,
                                ),

                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: TextField(
                                            controller: TextEditingController(
                                                text: _patient.phoneNumber),
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
