import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cbs_app/view/hiv_screening.dart';

class Overview extends StatefulWidget {
  String patient;

  Overview(this.patient);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OverviewState();
  }
}

class OverviewState extends State<Overview> {
  String patient,
      fullName,
      occupation,
      education,
      age,
      sex,
      address,
      district,
      maritalStatus;

  Map<String, dynamic> details;

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
                                                  text: 'Taurai Mandebvu'),
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
                                                  text: 'Male'),
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
                                                  text: '63-1324567 18 VIT M'),
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
                                                  text: 'Married'),
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
                                                  text: 'Tertiary'),
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
                                                  text: 'Employed'),
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
                                                  text: 'Zimbabwean'),
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

  @override
  void initState() {
    patient = widget.patient;
    details = jsonDecode(patient);
    fullName = details['firstName'] + "    " + details['lastName'];
    sex = details['sex'];
    education = details['educationLevel'];
    maritalStatus = details['maritalStatus'];
    occupation = details['occupation'];

    print('/////////////////////////$patient');
  }
}
