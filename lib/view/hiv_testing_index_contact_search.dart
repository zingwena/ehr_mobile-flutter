import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ehr_mobile/view/rounded_button.dart';
import 'package:ehr_mobile/view/home_page.dart';
import 'package:ehr_mobile/view/register_index_patient.dart';
/*import 'package:cbs_app/view/registration.dart';
import 'package:cbs_app/view/registration.dart';*/
/*import 'package:cbs_app/view/link_bar.dart';*/
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/patient_pretest.dart';

class HivTestingIndexContactPage extends StatefulWidget {
  @override
  HivTestingIndexContactPageState createState() {
    return new HivTestingIndexContactPageState();
  }
}

class HivTestingIndexContactPageState extends State<HivTestingIndexContactPage>
    with TickerProviderStateMixin {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.blue],
              ),
            ),
            height: 230.0,
          ),
          new AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            title: new Text("Impilo Mobile",   style: TextStyle(
              fontWeight: FontWeight.w300, fontSize: 25.0, ), ),
            actions: <Widget>[
              Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.person_pin, size: 25.0, color: Colors.white,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text("admin", style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12.0,color: Colors.white ),),
                        ),
                      ])
              ),
            ],
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery
                      .of(context)
                      .padding
                      .top + 40.0),
              child: new Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text("HIV Testing Index Contact Search", style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16.0,color: Colors.white ),),
                  ),


                  // _buildButtonsRow(),
                  Expanded(
                    child: new Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.all(8.0),
                      child: DefaultTabController(

                        length: 4,

                        child: new LayoutBuilder(
                          builder:
                              (BuildContext context,
                              BoxConstraints viewportConstraints) {
                            return Column(
                              children: <Widget>[
                                // _buildLinkBar(),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: new ConstrainedBox(
                                      constraints: new BoxConstraints(
                                        minHeight: viewportConstraints
                                            .maxHeight - 48.0,
                                      ),
                                      child: new IntrinsicHeight(
                                          child: Column(
                                            children: <Widget>[
                                              Form(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(30.0),
                                                  child: Column(
                                                    children: <Widget>[

                                                      Padding(
                                                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                                        child: Material(
                                                          // elevation: 5.0,
                                                          borderRadius: BorderRadius.circular(5.0),
                                                          child: TextFormField(
                                                            // controller: _textController,
                                                            decoration: InputDecoration(
                                                                border: OutlineInputBorder(),
                                                                suffixIcon: Icon(Icons.search,
                                                                    color: Colors.blue,
                                                                    size: 30.0),
                                                                contentPadding:
                                                                EdgeInsets.only(left: 15.0, top: 15.0),
                                                                hintText: 'Search for patient ...',
                                                                hintStyle: TextStyle(
                                                                  color: Colors.grey,
                                                                )
                                                            ),
                                                            //onChanged: _onChanged,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 16.0, horizontal: 40.0),
                                                child: GestureDetector(
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      // three line description

                                                      Divider(
                                                        height: 10.0,
                                                        color: Colors.blue,
                                                      ),
                                                      Container(
                                                        height: 2.0,
                                                        color: Colors.blue,
                                                      ),

                                                      Row(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Container(
                                                              padding: EdgeInsets.all(3.0),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.center,
                                                                children: <Widget>[
                                                                  Text(
                                                                    'Full Name',
                                                                    style: TextStyle(
                                                                        fontSize: 13.0,
                                                                        color: Colors.black54),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(top: 3.0),
                                                                    child: Text(
                                                                      'Tom Wilson',
                                                                      style: TextStyle(
                                                                          fontSize: 15.0,
                                                                          color: Colors.black87),
                                                                    ),
                                                                  )
                                                                ],
                                                              )),
                                                          Container(
                                                              padding: EdgeInsets.all(3.0),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.center,
                                                                children: <Widget>[
                                                                  Text(
                                                                    'Sex',
                                                                    style: TextStyle(
                                                                        fontSize: 13.0,
                                                                        color: Colors.black54),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(top: 3.0),
                                                                    child: Text(
                                                                      'Male',
                                                                      style: TextStyle(
                                                                          fontSize: 15.0,
                                                                          color: Colors.black87),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )),
                                                          Container(
                                                              padding: EdgeInsets.all(3.0),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.center,
                                                                children: <Widget>[
                                                                  Text(
                                                                    'D.O.B.',
                                                                    style: TextStyle(
                                                                        fontSize: 13.0,
                                                                        color: Colors.black54),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(top: 3.0),
                                                                    child: Text(
                                                                      '26/01/1981',
                                                                      style: TextStyle(
                                                                          fontSize: 15.0,
                                                                          color: Colors.black87),
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                          ),


                                                          Padding(
                                                            padding: const EdgeInsets.only(right: 0),
                                                            child: RaisedButton(
                                                              //onPressed: () {},
                                                              color: Colors.blue,
                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(left: 15, right: 15, top: 1, bottom: 1),
                                                                child: Text('Open',
                                                                  style: TextStyle(
                                                                      fontSize: 13.0,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.white),
                                                                ),
                                                              ),
                                                              onPressed: () => Navigator.push(
                                                                context,
                                                                MaterialPageRoute(builder: (context) => RegisterIndexPatient()),),
                                                            ),
                                                          )

                                                        ],
                                                      ),
                                                      Divider(
                                                        height: 10.0,
                                                        color: Colors.blue,
                                                      ),
                                                      Container(
                                                        height: 2.0,
                                                        color: Colors.blue,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              /*     SizedBox(
                                                height: 20.0,
                                              ),

                                              Container(
                                                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 60.0),
                                                width: double.infinity,
                                                child: RaisedButton(
                                                  elevation: 4.0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(5.0)),
                                                  color: Colors.blue,
                                                  padding: const EdgeInsets.all(20.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Text('Proceed to HTS Module', style: TextStyle(color: Colors.white),),
                                                      Icon(Icons.navigate_next, color: Colors.white, ),
                                                    ],
                                                  ),
                                                  onPressed: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => Registration()),
                                                  ),
                                                ),
                                              ),

                                              SizedBox(
                                                height: 25.0,
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 16.0, top: 8.0),
                                                child: FloatingActionButton(
                                                  onPressed: () =>
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                HomePage()),
                                                      ),
                                                  child: Icon(
                                                      Icons.home, size: 30.0),
                                                ),
                                              ),

                                              */
                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameBar({bool showFirstOption}) {
    return Stack(
      children: <Widget>[
        new Positioned.fill(
          top: null,
          child: new Container(
            height: 2.0,
            color: Colors.blue,
          ),
        ),

        ListTile(
          contentPadding: EdgeInsets.symmetric( vertical: 20.0, horizontal: 30.0),
          leading: CircleAvatar(
            backgroundImage: AssetImage('images/avatar.png'),
            backgroundColor: Colors.grey[300],
          ),
          title: Text(
            'Tom Wilson',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              // fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'ID Number : 35463782V18',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    // fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  'DOB : 21/01/1981',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),

        Container(
          height: 2.0,
          color: Colors.blue,
        ),

      ],
    );
  }

/*
  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(text: "Patient Overview",  onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PatientOverViewPage()),
          ),
          ),
          new RoundedButton(text: "Reception Vitals", selected: true,
          ),
          new RoundedButton(text: "HTS Registration", onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Registration()),
          ),
          ),
          new RoundedButton(text: "HTS Pre-Test", onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PatientPretest()),
          ),
          ),
        ],
      ),
    );
  }
*/

/*  Widget _buildLinkBar({bool showFirstOption}) {
    return
      Row(
        children: <Widget>[
          new LinkBarItems(
            text: "Patient Overview />", onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PatientOverViewPage()),
          ),
          ),
          new LinkBarItems(
            text: "Reception Vitals />", selected: true,
          ),
          new LinkBarItems(
            text: "HTS Registration />",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Registration()),
            ),
          ),
          new LinkBarItems(
            text: "HTS Pre-Test />",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PatientPretest()),
            ),
          ),
        ],
      );
  }*/

}
