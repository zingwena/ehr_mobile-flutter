import 'dart:convert';

import 'package:ehr_mobile/model/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'patient_overview.dart';

class ListPatients extends StatefulWidget {
  final List<Person> patientList;

  ListPatients(this.patientList);

  @override
  State createState() {
    return _ListPatients();
  }
}

class _ListPatients extends State<ListPatients> {
  List<Person> _patients = [];

  @override
  void initState() {
    _patients = widget.patientList;
    super.initState();
  }

  String nullValidator(var cell) {
    return cell == null ? "" : cell;
  }

  DataTable tableContents() {
    return DataTable(
        sortColumnIndex: 0,
        columns: [
          DataColumn(
            label: Text('First Name'),
            tooltip: "First Name of  patient ",
          ),
          DataColumn(
            label: Text('Last Name'),
            tooltip: "Last Name of  patient ",
          ),
          DataColumn(
            label: Text('Sex'),
            tooltip: "patient's gender ",
          ),
          DataColumn(
            label: Text('BirthDate'),
            tooltip: "patient's birthday ",
          ),
          DataColumn(
            label: Text('National ID'),
            tooltip: "patient's birthday ",
          ),
          DataColumn(
            label: Text('Action'),
            tooltip: "Open Patient File ",
          ),
        ],
        rows: _patients
            .map(
              (patient) => DataRow(cells: [
                DataCell(
                  Text(nullValidator(patient.lastName)),
                ),
                DataCell(Text(nullValidator(patient.firstName))),
                DataCell(
                  Text(nullValidator("sex")),
                ),
                DataCell(
                  Text(nullValidator("dob")),
                ),
                DataCell(
                  Text(nullValidator("nationalid")),
                ),
                DataCell(
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Overview(patient)));
                    },
                    child: Text('View',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ),
              ]),
            )
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                  tableContents(),


          ],
        ),
      ),
    );
  }
}
