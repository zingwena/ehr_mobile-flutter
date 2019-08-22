import 'dart:convert';

import 'package:ehr_mobile/model/address.dart';
import 'package:flutter/material.dart';


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
      district,
      maritalStatus,
  nationalId;

  Address address;

  Map<String, dynamic> details;

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
                                                borderRadius:
                                                BorderRadius.circular(5.0)),
                                            color: Colors.blue,
                                            padding: const EdgeInsets.all(20.0),
                                            child: Text(
                                              "Vitals",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
//                                            onPressed: () => Navigator.push(
//                                              context,
//                                              MaterialPageRoute(
//                                                  builder: (context) =>
//                                                      ReceptionVitals()),
//                                            ),
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
                                                borderRadius:
                                                BorderRadius.circular(5.0)),
                                            color: Colors.blue,
                                            padding: const EdgeInsets.all(20.0),
                                            child: Text(
                                              "HTS",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
//                                            onPressed: () => Navigator.push(
//                                              context,
//                                              MaterialPageRoute(
//                                                  builder: (context) =>
//                                                      HivScreening()),
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
                                              "Close Patient Record",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
//                                            onPressed: () => Navigator.push(
//                                              context,
//                                              MaterialPageRoute(
//                                                  builder: (context) =>
//                                                      HomePage()),
//                                            ),
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
                                                text: fullName),
                                            decoration: InputDecoration(
                                              labelText: 'Fullname',
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
                                                text: sex),
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
                                                text: nationalId),
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
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
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
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
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
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
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
                                                text: address.street+" "+address.town+" "+address.city),
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

  @override
  void initState() {
    patient = widget.patient;
    details = jsonDecode(patient);
    fullName = details['firstName'] + "    " + details['lastName'];
    sex = details['sex'];
    education = details['educationLevel'];
    maritalStatus = details['maritalStatus'];
    occupation = details['occupation'];
   nationalId = details['nationalId'];
   address=Address.fromJson(details['address']);

    print('///////////////////////// in oveiview    ${address.city}');
  }
}
