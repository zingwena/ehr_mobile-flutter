import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class VisitInitiation extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    // TODO: implement createState
    return VisitInitiationState();
  }
}

class VisitInitiationState extends State<VisitInitiation>
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
            height: 210.0,
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
              child: Text("Visit Initiation", style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 16.0,color: Colors.white ),),
            ),
                 // _buildButtonsRow(),
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
                                 //  _buildNameBar(),
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
                                              width: double.infinity,
                                              padding:
                                              EdgeInsets.symmetric(
                                                  vertical: 16.0,
                                                  horizontal: 60.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: SizedBox(
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(
                                                            8.0),
                                                        child:
                                                        Text('Select Queue'),
                                                      ),
                                                      width: 250,
                                                    ),
                                                  ),
                                                  Text('General'),
                                                  Radio(
                                                      value: 1,
                                                      groupValue: _queue,
                                                      activeColor: Colors.blue,
                                                      onChanged: _handleQueueChange),
                                                  Text('HTS'),
                                                  Radio(
                                                      value: 2,
                                                      groupValue: _queue,
                                                      activeColor: Colors.blue,
                                                      onChanged: _handleQueueChange),
                                                  Text('OI Clinic'),
                                                  Radio(
                                                      value: 2,
                                                      groupValue: _queue,
                                                      activeColor: Colors.blue,
                                                      onChanged: _handleQueueChange),
                                                  Text('FCH'),
                                                  Radio(
                                                      value: 2,
                                                      groupValue: _queue,
                                                      activeColor: Colors.blue,
                                                      onChanged: _handleQueueChange)
                                                ],
                                              ),
                                            ),

                                            SizedBox(
                                              height: 20.0,
                                            ),

                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 30.0 ),
                                              child: RaisedButton(
                                                elevation: 4.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(5.0)),
                                                color: Colors.blue,
                                                padding: const EdgeInsets.all(20.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text('Sent to Queue', style: TextStyle(color: Colors.white),),
                                                    Spacer(),
                                                    Icon(Icons.navigate_next, color: Colors.white, ),

                                                  ],
                                                ),

                                                  onPressed: () {}

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

}
