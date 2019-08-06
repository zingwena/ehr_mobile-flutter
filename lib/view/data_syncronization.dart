
import 'package:flutter/material.dart';

class DataSyncronization extends StatefulWidget {
  @override
  _DataSyncronizationState createState() => new _DataSyncronizationState();
}

class _DataSyncronizationState extends State<DataSyncronization> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: dataSyncBody(),
      ),
    );
  }

  dataSyncBody() =>
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[dataSyncHeader(), loginFields()],
        ),
      );

  dataSyncHeader() =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image(image: AssetImage('images/mhc.png'),width: 150, height: 150,),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "EHR Mobile App",
            style: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey.shade600, fontSize: 30),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "Data Synchronization Page",
            style: TextStyle(color: Colors.teal, fontSize: 16),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      );

  loginFields() =>
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
              child: TextFormField(
                maxLines: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "XXX.XXX.X.XX",
                  labelText: "Facility Server IP",
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              child: TextFormField(
                maxLines: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Username",
                  labelText: "Username",
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
              child: TextFormField(
                maxLines: 1,
                obscureText: true,
                decoration: InputDecoration(
                 border: OutlineInputBorder(),
                  hintText: "Enter your Password",
                  labelText: "Password",
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              width: double.infinity,
              child: RaisedButton(
                elevation: 4.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                color: Colors.teal,
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "LOGIN",
                  style: TextStyle(color: Colors.white),
                ),

                onPressed: null,
//                    () => Navigator.push(
//                                        context,
//                       MaterialPageRoute(
//                         builder: (context) => DataSyncronizationSummary()),),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),

          ],
        ),
      );

}











