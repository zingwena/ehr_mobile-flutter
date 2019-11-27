import 'package:ehr_mobile/view/search_patient.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ehr_mobile/view/rounded_button.dart';
import 'package:ehr_mobile/view/add_patient.dart';


class SummaryOverview extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    // TODO: implement createState
    return SummaryOverviewState();
  }
}

class SummaryOverviewState extends State<SummaryOverview>
    with TickerProviderStateMixin {

  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);

  }

  int _queue = 0;
  String queue = "";

  void _handleQueueChange(int value) {
    setState(() {
      _queue = value;

      switch (_queue) {
        case 1:
          queue = "General";
          break;
        case 2:
          queue = "HTS";
          break;
        case 3:
          queue = "OI Clinic";
          break;
        case 4:
          queue = "FCH";
          break;
      }
    });
  }

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
            height: 220.0,
          ),
          new AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            title: new Text("Impilo Mobile",   style: TextStyle(
              fontWeight: FontWeight.w300, fontSize: 25.0, ),

            ),
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
              child: Text("Summary", style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 16.0,color: Colors.white ),),
            ),

                  Container(
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.person_outline, size: 25.0, color: Colors.white,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text("Tom Wilson", style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14.0,color: Colors.white ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.date_range, size: 25.0, color: Colors.white,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text("Age - 25", style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14.0,color: Colors.white ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.person, size: 25.0, color: Colors.white,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text("Sex : Male", style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14.0,color: Colors.white ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.verified_user, size: 25.0, color: Colors.white,),
                            ),
                          ])
                  ),

                  SizedBox(
                    height: 3.0,
                  ),
                //  _buildButtonsRow(),
                  Expanded(
                    child: new Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.all(8.0),
                      child: DefaultTabController(
                        child: new LayoutBuilder(
                          builder:
                              (BuildContext context,
                              BoxConstraints viewportConstraints) {
                            return Column(
                              children: <Widget>[

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
                                            padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          children: <Widget>[

                                            SizedBox(
                                              height: 10.0,
                                            ),

                                            Container(
                                              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                                              width: double.infinity,
                                              child: OutlineButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5.0)),
                                                color: Colors.white,
                                                padding: const EdgeInsets.all(0.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      // three line description
                                                      Container(
                                                        alignment: Alignment.topLeft,
                                                        child: Text(
                                                          'Reception Vitals Overview',
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontStyle: FontStyle.normal,
                                                            color: Colors.black87,
                                                          ),
                                                        ),
                                                      ),

                                                      Container(
                                                        margin: EdgeInsets.only(top: 3.0),
                                                      ),
                                                      Container(
                                                        alignment: Alignment.topLeft,
                                                        child: Text(
                                                          'Recorded :' +
                                                              '15/10/2019',
                                                          style: TextStyle(
                                                              fontSize: 13.0, color: Colors.black54),
                                                        ),
                                                      ),
                                                      Divider(
                                                        height: 10.0,
                                                        color: Colors.blue.shade500,
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
                                                                    'BP',
                                                                    style: TextStyle(
                                                                        fontSize: 13.0,
                                                                        color: Colors.black54),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(top: 3.0),
                                                                    child: Text(
                                                                      '43-38',
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
                                                                    'Temp',
                                                                    style: TextStyle(
                                                                        fontSize: 13.0,
                                                                        color: Colors.black54),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(top: 3.0),
                                                                    child: Text(
                                                                      '44',
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
                                                                    'Pulse',
                                                                    style: TextStyle(
                                                                        fontSize: 13.0,
                                                                        color: Colors.black54),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(top: 3.0),
                                                                    child: Text(
                                                                      '22',
                                                                      style: TextStyle(
                                                                          fontSize: 15.0,
                                                                          color: Colors.black87),
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                          ),
                                                          Container(
                                                              padding: EdgeInsets.all(3.0),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.center,
                                                                children: <Widget>[
                                                                  Text(
                                                                    'Resp',
                                                                    style: TextStyle(
                                                                        fontSize: 13.0,
                                                                        color: Colors.black54),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(top: 3.0),
                                                                    child: Text(
                                                                      '22',
                                                                      style: TextStyle(
                                                                          fontSize: 15.0,
                                                                          color: Colors.black87),
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                          ),
                                                          Container(
                                                              padding: EdgeInsets.all(3.0),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.center,
                                                                children: <Widget>[
                                                                  Text(
                                                                    'Height',
                                                                    style: TextStyle(
                                                                        fontSize: 13.0,
                                                                        color: Colors.black54),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(top: 3.0),
                                                                    child: Text(
                                                                      '32',
                                                                      style: TextStyle(
                                                                          fontSize: 15.0,
                                                                          color: Colors.black87),
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                          ),

                                                         /* Padding(
                                                            padding: const EdgeInsets.only(right: 0),
                                                            child: RaisedButton(
                                                              onPressed: () => Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => AddPatient()), ),
                                                              color: Colors.blue,
                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(left: 15, right: 15, top: 1, bottom: 1),
                                                                child: Text('View',
                                                                  style: TextStyle(
                                                                      fontSize: 13.0,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.white),
                                                                ),
                                                              ),
                                                            ),
                                                          ) */
                                                        ],
                                                      ),
                                                      Divider(
                                                        height: 10.0,
                                                        color: Colors.blue.shade500,
                                                      ),
                                                      Container(
                                                        height: 2.0,
                                                        color: Colors.blue,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                borderSide: BorderSide(
                                                  color: Colors.blue, //Color of the border
                                                  style: BorderStyle.solid, //Style of the border
                                                  width: 2.0, //width of the border
                                                ),
                                                onPressed: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => SearchPatient()), ),
                                              ),
                                            ),


                                            SizedBox(
                                              height: 10.0,
                                            ),

                                            Container(
                                              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                                              width: double.infinity,
                                              child: OutlineButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5.0)),
                                                color: Colors.white,
                                                padding: const EdgeInsets.all(0.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      // three line description
                                                      Container(
                                                        alignment: Alignment.topLeft,
                                                        child: Text(
                                                          'HIV Testing Overview',
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontStyle: FontStyle.normal,
                                                            color: Colors.black87,
                                                          ),
                                                        ),
                                                      ),

                                                      Container(
                                                        margin: EdgeInsets.only(top: 3.0),
                                                      ),
                                                      Container(
                                                        alignment: Alignment.topLeft,
                                                        child: Text(
                                                          'Recorded :' +
                                                              '',
                                                          style: TextStyle(
                                                              fontSize: 13.0, color: Colors.black54),
                                                        ),
                                                      ),
                                                      Divider(
                                                        height: 10.0,
                                                        color: Colors.blue.shade500,
                                                      ),
                                                      Container(
                                                        height: 2.0,
                                                        color: Colors.blue,
                                                      ),

                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric( vertical: 16.0, horizontal:5.0),
                                                              child: Text("Last HIV Result"),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                              child: Text("Positive"),
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                       Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Padding(
                                                            padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 10.0),
                                                            child: RaisedButton(
                                                              //onPressed: () {},
                                                              color: Colors.blue,
                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets.only(left: 10, right: 10, top: 1, bottom: 1),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: <Widget>[
                                                                    Icon(Icons.edit_attributes, color: Colors.white,),
                                                                    Spacer(),
                                                                    Text('Offer HIV Testing', style: TextStyle(color: Colors.white,),),
                                                                  ],
                                                                ),

                                                              ),
                                                              onPressed: (){}
                                                            ),
                                                          ),
                                                        ),

                                                        Expanded(
                                                          child: Padding(
                                                            padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 10.0),
                                                            child: RaisedButton(
                                                              // onPressed: () {},
                                                              color: Colors.blue,
                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(left: 2, right: 2, top: 1, bottom: 1),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: <Widget>[
                                                                    Icon(Icons.format_list_numbered, color: Colors.white, ),
                                                                    Spacer(),
                                                                    Text('HIV Contact List 4', style: TextStyle(color: Colors.white),),
                                                                  ],
                                                                ),
                                                              ),
                                                              onPressed: () {}
                                                            ),
                                                          ),
                                                        ),

                                                      ],
                                                    ),

                                                      Divider(
                                                        height: 10.0,
                                                        color: Colors.blue.shade500,
                                                      ),
                                                      Container(
                                                        height: 2.0,
                                                        color: Colors.blue,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                borderSide: BorderSide(
                                                  color: Colors.blue, //Color of the border
                                                  style: BorderStyle.solid, //Style of the border
                                                  width: 2.0, //width of the border
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),


                                          ],
                                        ),
                                      ),
                                    ),


                                          ],
                                        )

                                      ),
                                    ),
                                  ),
                                )
                              ]
                              ,
                            );
                          },
                        ),
                        length: 3,
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

  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(text: "General",
          ),
          new RoundedButton(text: "HTS", selected: true,
          ),
          new RoundedButton(text: "OI Clinic",
          ),
          new RoundedButton(text: "FCH",
          ),

        ],
      ),
    );
  }



}
