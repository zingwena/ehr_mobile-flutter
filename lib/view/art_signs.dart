import 'dart:convert';

import 'package:ehr_mobile/model/htsRegistration.dart';

import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/age.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/view/search_patient.dart';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import '../landing_screen.dart';
import '../login_screen.dart';


class ArtSigns extends StatefulWidget {


  ArtSigns();

  @override
  State createState() {
    return _ArtSigns();
  }
}

class _ArtSigns extends State<ArtSigns> {
  static const platform = MethodChannel('example.channel.dev/people');
  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  static const dataChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');

  final _formKey = GlobalKey<FormState>();

  String _htsApproach="" ;
  HtsRegistration htsRegistration;

  int _newTestInPreg = 0;
  bool newTestInPreg = false;

  int _mentalStatus = 0;
  bool mentalStatus = false;

  int _centralNervousSystem=0 ;
  bool centralNervousSystem = false;

  int _pallor= 0 ;
  bool pallor = false;

  int _enlargedLymphNodes= 0;
  bool enlargedLymphNodes=false;

  int _cyanosis= 0;
  bool cyanosis=false;

  int _jaundice= 0;
  bool jaundice=false;

  int _pregnant = 0;
  bool pregnantOption = false;


  String purposeOfTestId;

  String facility_name;
  Age age;
  @override
  void initState() {
  getFacilityName();

    super.initState();
  }

  Future<void>getAge(Person person)async{
    String response;
    try{
      response = await dataChannel.invokeMethod('getage', person.id);
      setState(() {
        age = Age.fromJson(jsonDecode(response));
        print("THIS IS THE AGE RETRIEVED"+ age.toString());
      });

    }catch(e){
      debugPrint("Exception thrown in get facility name method"+e);

    }
  }

  Future<void>getFacilityName()async{
    String response;
    try{
      response = await retrieveString(FACILITY_NAME);
      setState(() {
        facility_name = response;
      });

    }catch(e){
      debugPrint("Exception thrown in get facility name method"+e);

    }
  }

  void _handlePregnantOption (int value) {
    setState(() {
      _pregnant = value;

      switch (_pregnant) {
        case 1:
          pregnantOption = true;
          break;
        case 2:
          pregnantOption = true;
          break;
      }
    });
  }

  bool showInput = true;
  bool showInputTabOptions = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     // drawer:  Sidebar(widget.person, widget.personId, widget.visitId, htsRegistration, widget.htsid),
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
            title: new Text(
              facility_name!=null?facility_name: 'Impilo Mobile',   style: TextStyle(
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
              Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: IconButton(
                              icon: Icon(Icons.home), color: Colors.white,
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SearchPatient()),),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: IconButton(
                            icon: Icon(Icons.exit_to_app), color: Colors.white,
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LandingScreen()),),
                          ),
                        ),])
              ),
            ],
          ),

          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 40.0),
              child: new Column(
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text("Art Signs", style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16.0,color: Colors.white ),),
                  ),

                 /* Container(
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
                              child: Text(widget.person.firstName + " " + widget.person.lastName, style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14.0,color: Colors.white ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.date_range, size: 25.0, color: Colors.white,),
                            ),
                              Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text("Age -"+age.years.toString()+"years", style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14.0,color: Colors.white ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.person, size: 25.0, color: Colors.white,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text("Sex :"+ widget.person.sex, style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14.0,color: Colors.white ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.verified_user, size: 25.0, color: Colors.white,),
                            ),
                          ])
                  ), */


                 // _buildButtonsRow(),
                  Expanded(
                      child: new Card(
                        elevation: 4.0,
                        margin: const EdgeInsets.all(8.0),
                        child: DefaultTabController(
                          child: new LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints viewportConstraints) {
                              return Column(
                                children: <Widget>[
                                  //  _buildTabBar(),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: new ConstrainedBox(
                                        constraints: new BoxConstraints(
                                          minHeight:
                                          viewportConstraints.maxHeight -
                                              48.0,
                                        ),
                                        child: new IntrinsicHeight(
                                          child: Column(
                                            children: <Widget>[
                                              Form(
                                                key: _formKey,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: <Widget>[

                                                    SizedBox(
                                                      height: 30.0,
                                                    ),

                                                    Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(vertical: 16.0,
                                                                  horizontal: 60.0),
                                                              child: TextFormField(
                                                                controller: TextEditingController(
                                                                    text: 'No Signs'),
                                                                decoration: InputDecoration(
                                                                    labelText:
                                                                    'TB Status ',
                                                                    border: OutlineInputBorder()),
                                                              ),
                                                            ),
                                                            width: 100,
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    SizedBox(
                                                      height: 10.0,
                                                    ),

                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                      child:        Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text('Mental Status'),
                                                              ),
                                                              width: 250,
                                                            ),
                                                          ),
                                                          Text('Normal'),
                                                          Radio(
                                                              value: 1,
                                                              groupValue: _mentalStatus,
                                                              onChanged: _handleNewMentalStatusOption),
                                                          Text('Abnormal'),
                                                          Radio(
                                                              value: 2,
                                                              groupValue: _mentalStatus,
                                                              onChanged: _handleNewMentalStatusOption)

                                                        ],
                                                      ),
                                                    ),

                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                      child:        Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child:  Text("Enlarged Lymph Nodes"),
                                                              ),
                                                              width: 250,
                                                            ),
                                                          ),
                                                          Text('YES'),
                                                          Radio(
                                                              value: 1,
                                                              groupValue: _enlargedLymphNodes,
                                                              onChanged: _handleNewEnlargedLymphNodesOption),
                                                          Text('NO'),
                                                          Radio(
                                                              value: 2,
                                                              groupValue: _enlargedLymphNodes,
                                                              onChanged: _handleNewEnlargedLymphNodesOption)
                                                        ],
                                                      ),
                                                    ),

                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                      child:        Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child:  Text("Central Nervous System"),
                                                              ),
                                                              width: 250,
                                                            ),
                                                          ),
                                                          Text('YES'),
                                                          Radio(
                                                              value: 1,
                                                              groupValue: _centralNervousSystem,
                                                              onChanged: _handleNewCentralNervousSystemOption),
                                                          Text('NO'),
                                                          Radio(
                                                              value: 2,
                                                              groupValue: _centralNervousSystem,
                                                              onChanged: _handleNewCentralNervousSystemOption)

                                                        ],
                                                      ),
                                                    ),

                                                     Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                      child:            Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text("Pallor"),
                                                              ),
                                                              width: 250,
                                                            ),
                                                          ),
                                                          Text('YES'),
                                                          Radio(
                                                              value: 1,
                                                              groupValue: _pallor,
                                                              onChanged: _handleNewPallorOption),
                                                          Text('NO'),
                                                          Radio(
                                                              value: 2,
                                                              groupValue: _pallor,
                                                              onChanged: _handleNewPallorOption,),

                                                        ],
                                                      ),
                                                    ),

                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                      child:        Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child:  Text("Cyanosis"),
                                                              ),
                                                              width: 250,
                                                            ),
                                                          ),
                                                          Text('YES'),
                                                          Radio(
                                                              value: 1,
                                                              groupValue: _cyanosis,
                                                              onChanged: _handleNewCyanosisOption),
                                                          Text('NO'),
                                                          Radio(
                                                              value: 2,
                                                              groupValue: _cyanosis,
                                                              onChanged: _handleNewCyanosisOption)

                                                        ],
                                                      ),
                                                    ),

                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                      child:            Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text("Jaundice"),
                                                              ),
                                                              width: 250,
                                                            ),
                                                          ),
                                                          Text('YES'),
                                                          Radio(
                                                              value: 1,
                                                              groupValue: _jaundice,
                                                              onChanged: _handleNewJaundiceOption),
                                                          Text('NO'),
                                                          Radio(
                                                              value: 2,
                                                              groupValue: _jaundice,
                                                              onChanged: _handleNewJaundiceOption)

                                                        ],
                                                      ),
                                                    ),

                                                    Container(
                                                      width: double.infinity,
                                                      padding:
                                                      EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0 ),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets.all(8.0),
                                                                child: Text('Pregnant '),
                                                              ),
                                                              width: 250,
                                                            ),
                                                          ),
                                                          Text('Yes'),
                                                          Radio(
                                                              value: 1,
                                                              groupValue: _pregnant,
                                                              activeColor:
                                                              Colors.blue,
                                                              onChanged:
                                                              _handlePregnantOption),
                                                          Text('No'),
                                                          Radio(
                                                              value: 2,
                                                              groupValue: _pregnant,
                                                              activeColor: Colors.blue,
                                                              onChanged: _handlePregnantOption),

                                                        ],
                                                      ),
                                                    ),


                                                    SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                                                      child: RaisedButton(
                                                        elevation: 4.0,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(5.0)),
                                                        color: Colors.blue,
                                                        padding: const EdgeInsets.all(20.0),
                                                        child: Text(
                                                          "Save",
                                                          style: TextStyle(color: Colors.white),
                                                        ),
                                                        onPressed: () {},

                                                      ),
                                                    ),

                                              SizedBox(
                                                      height: 30.0,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
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

 /* Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(
            text: "HTS Registration", onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HtsRegOverview(widget.htsRegistration, widget.personId, widget.htsid, widget.visitId, widget.person
                        )),
          ),
          ),
      //HtsRegOverview(this.htsRegistration, this.personId, this.htsid);

      new RoundedButton(
            text: "HTS Pre-Testing", selected: true,

          ),
          new RoundedButton(text: "Testing",
          ),
        ],
      ),
    );
  } */



  void _handleNewJaundiceOption(int value) {
    setState(() {
      _pallor = value;

      switch (_pallor) {
        case 1:
          pallor = true;
          break;
        case 2:
          pallor = false;
          break;
      }
    });
  }

  void _handleNewPallorOption(int value) {
    setState(() {
      _pallor = value;

      switch (_pallor) {
        case 1:
          pallor = true;
          break;
        case 2:
          pallor = false;
          break;
      }
    });
  }

  void _handleNewCyanosisOption(int value) {
    setState(() {
      _cyanosis = value;

      switch (_cyanosis) {
        case 1:
          cyanosis = true;
          break;
        case 2:
          cyanosis = false;
          break;
      }
    });
  }

  void _handleNewEnlargedLymphNodesOption(int value) {
    setState(() {
      _enlargedLymphNodes = value;

      switch (_enlargedLymphNodes) {
        case 1:
          enlargedLymphNodes = true;
          break;
        case 2:
          enlargedLymphNodes = false;
          break;
      }
    });
  }

  void _handleNewMentalStatusOption(int value) {
    setState(() {
      _mentalStatus = value;

      switch (_mentalStatus) {
        case 1:
          mentalStatus = true;
          break;
        case 2:
          mentalStatus = false;
          break;
      }
    });
  }

  void _handleNewCentralNervousSystemOption(int value) {
    setState(() {
      _centralNervousSystem = value;

      switch (_centralNervousSystem) {
        case 1:
          centralNervousSystem = true;
          break;
        case 2:
          centralNervousSystem = false;
          break;
      }
    });
  }

}


