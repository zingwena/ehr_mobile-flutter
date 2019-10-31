import 'package:ehr_mobile/view/typable_text.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DataSyncronizationSummary extends StatefulWidget {
  @override
  DataSyncronizationSummaryState createState() {
    return new DataSyncronizationSummaryState();
  }
}

class DataSyncronizationSummaryState extends State<DataSyncronizationSummary>
    with TickerProviderStateMixin {
  AnimationController textInputAnimationController;

  @override
  void initState() {
    super.initState();
    textInputAnimationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 800));
  }

  @override
  void dispose() {
    textInputAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
              child: TypeableTextFormField(
                animation: _buildInputAnimation(begin: 0.0, end: 0.2),
                decoration: InputDecoration(
                    icon: Icon(Icons.person, color: Colors.blue),
                    labelText: "Facility Name",
                    hintText: "Seke Health Clinic"),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
              child: TypeableTextFormField(
                animation: _buildInputAnimation(begin: 0.0, end: 0.2),
                decoration: InputDecoration(
                    icon: Icon(Icons.perm_identity, color: Colors.blue),
                    labelText: "Catchment Area Villages",
                    hintText: "Seke Health Clinic"),
              ),
            ),

            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: TypeableTextFormField(
                      animation: _buildInputAnimation(begin: 0.0, end: 0.2),
                      decoration: InputDecoration(
                          icon: Icon(Icons.perm_identity, color: Colors.blue),
                          labelText: "Last Successful Sync",
                          hintText: "04/08/2019"),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: TypeableTextFormField(
                      animation: _buildInputAnimation(begin: 0.0, end: 0.2),
                      decoration: InputDecoration(
                          icon: new Icon(MdiIcons.humanMaleFemale,
                              color: Colors.blue),
                          labelText: "Device Mac Address",
                          hintText: "00-14-22-01-23-45"),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: TypeableTextFormField(
                      animation: _buildInputAnimation(begin: 0.0, end: 0.2),
                      decoration: InputDecoration(
                          icon: Icon(Icons.date_range, color: Colors.blue),
                          labelText: "Serial Number",
                          hintText: "JJ-2H345"),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: TypeableTextFormField(
                      animation: _buildInputAnimation(begin: 0.0, end: 0.2),
                      decoration: InputDecoration(
                          icon: new Icon(MdiIcons.humanMaleGirl,
                              color: Colors.blue),
                          labelText: "Lenovo",
                          hintText: "Device Name"),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: TypeableTextFormField(
                      animation: _buildInputAnimation(begin: 0.0, end: 0.2),
                      decoration: InputDecoration(
                          icon: Icon(Icons.book, color: Colors.blue),
                          labelText: "Admin, HIV Tester",
                          hintText: "User Roles"),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: TypeableTextFormField(
                      animation: _buildInputAnimation(begin: 0.0, end: 0.2),
                      decoration: InputDecoration(
                          icon: Icon(Icons.work, color: Colors.blue),
                          labelText: "Total Number Of Users",
                          hintText: "16"),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: TypeableTextFormField(
                      animation: _buildInputAnimation(begin: 0.0, end: 0.2),
                      decoration: InputDecoration(
                          icon: Icon(Icons.map, color: Colors.blue),
                          labelText: "Patient Data",
                          hintText: "17684 Records"),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: TypeableTextFormField(
                      animation: _buildInputAnimation(begin: 0.0, end: 0.2),
                      decoration: InputDecoration(
                          icon: Icon(Icons.phone_android, color: Colors.blue),
                          labelText: "Server Identifier",
                          hintText: "192.253.23.45"),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  CurvedAnimation _buildInputAnimation({double begin, double end}) {
    return new CurvedAnimation(
        parent: textInputAnimationController,
        curve: Interval(begin, end, curve: Curves.linear));
  }
}
