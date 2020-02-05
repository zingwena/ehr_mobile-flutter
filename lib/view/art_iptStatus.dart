import 'dart:convert';
import 'package:ehr_mobile/model/artipt.dart';
import 'package:ehr_mobile/model/functionalstatus.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/namecode.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/age.dart';
import 'package:ehr_mobile/model/reason.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/landing_screen.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/view/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ArtIptStatusView extends StatefulWidget {

  final Person person;
  final String personId;
  final String visitId;
  final String htsId;
  final HtsRegistration htsRegistration;

  ArtIptStatusView(this.person, this.personId, this.visitId, this.htsId, this.htsRegistration);

  @override
  State createState() {
    return _ArtIptStatus();
  }
}

class _ArtIptStatus extends State<ArtIptStatusView> {
  final _formKey = GlobalKey<FormState>();
  static const dataChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  static const artChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile.channel/art');
  String personId;

  String  _currentIptStatus;
  String  _currentReason;

  String _iptreason;
  List  iptreasons= List();
  List _dropDownReasons = List();
  List<DropdownMenuItem<String>> _dropDownMenuItemsReasons;
  List<Reason> _iptReasonsList = List();

  String _entryPoint;
  List entryPoints = List();
  List _dropDownListEntryPoints = List();
  List<DropdownMenuItem<String>> _dropDownMenuItemsEntryPoint;
  List<NameCode> _entryPointList = List();

  String _iptStatus;
  List  iptStatuses = List();
  List _dropDownStatuses = List();
  List<DropdownMenuItem<String>> _dropDownMenuItemsStatuses;
  List<NameCode> _iptStatusesList = List();

  String line="";
  bool iptStatusOptionIsValid=false;
  bool reasonOptionIsValid=false;
  String _reasonError="Select Reason";
  String _iptStatusError="Select IPT Status";

  String _functionalStatus;
  List functionalStatuses = List();
  List _dropDownFunctionalStatuses = List();
  List<DropdownMenuItem<String>> _dropDownMenuItemsFunctionalStatuses;
  List<FunctionalStatus> _functionalStatusList = List();



  int _reason = 0;
  bool reasonOption = false;

  List _iptStatusListIdentified = ["Status 1", "Status 2", "Status 3", "Status 4", "Status 5" ];
  List _reasonListIdentified = ["Reason 1", "Reason 2", "Reason 3", "Reason 4", "Reason 5" ];

  Age age;
  ArtIpt _artIpt;
  ArtIpt artIptResponse;

  String facility_name;



  @override
  void initState() {

    //getAge(widget.person);
    getFacilityName();
    getArtIpt(widget.personId);
    getIptReason();
    getIptStatus();
    getFunctionalStatus();
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

  Future<void> getFunctionalStatus() async {
    String response;
    try {
      response = await artChannel.invokeMethod('getFunctionalStatus');
      setState(() {
        _functionalStatus = response;
        print("Here is the FUNCTIONAL STATUS STRING RETURNED"+ _iptreason);

        functionalStatuses = jsonDecode(_functionalStatus);
        print("Here is the IPT FUNCTIONAL STATUS dynamic list RETURNED"+ iptreasons.toString());

        _dropDownFunctionalStatuses = FunctionalStatus.mapFromJson(functionalStatuses);
        _dropDownFunctionalStatuses.forEach((e) {
          _functionalStatusList.add(e);
        });

      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }


  Future<void> getIptReason() async {
    var response;
    try {
      response = await artChannel.invokeMethod('getIptReason');
      setState(() {
        _iptreason = response;
        print("Here is the IPT REASON STRING RETURNED"+ _iptreason);
        iptreasons = jsonDecode(_iptreason);
        print("Here is the IPT REASON dynamic list RETURNED"+ iptreasons.toString());

        _dropDownReasons = Reason.mapFromJson(iptreasons);
        print("Here is the IPT REASON list of name code RETURNED"+ _iptreason);

        _dropDownReasons.forEach((e) {
          _iptReasonsList.add(e);
        });
        _dropDownMenuItemsReasons = getDropDownMenuItemsReasonList();
      });
    } catch (e) {
      print('--------------------Something went wrong in getIptReason $e');
    }
  }

  Future<void> getIptStatus() async {
    var response;
    try {
      response = await artChannel.invokeMethod('getIptStatus');
      setState(() {
        _iptStatus = response;
        iptStatuses = jsonDecode(_iptStatus);
        _dropDownStatuses = NameCode.mapFromJson(iptStatuses);
        _dropDownStatuses.forEach((e) {
          _iptStatusesList.add(e);
        });
        _dropDownMenuItemsStatuses =
            getDropDownMenuItemsIptStatusList();
      });
    } catch (e) {
      print('--------------------Something went wrong  in getIptStatus $e');
    }
  }


  Future<void> getArtIpt(String  personId) async {
    var art_visit_response;
    try {
      art_visit_response = await artChannel.invokeMethod('getArtIpt', personId);
      print('pppppppppppppppppppppppppppppppppppp IPT response'+ art_visit_response);
      setState(() {
        _artIpt = ArtIpt.fromJson(jsonDecode(art_visit_response));
        print('FFFFFFFFFFFFFFFFFFFFFFF art IPT  at first'+ _artIpt.toString());
      });

    } catch (e) {
      print('--------------something went wrong in art visit get  method  $e');
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // drawer:  Sidebar(widget.person, widget.patientId, widget.visitId, widget.htsRegistration, widget.htsId),
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
            title:new Text(
              facility_name!=null?facility_name: 'Impilo Mobile',   style: TextStyle(
              fontWeight: FontWeight.w300, fontSize: 25.0, ), ),
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
                    child: Text("Art IPT Status", style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16.0,color: Colors.white ),),
                  ),
                  _buildButtonsRow(),
                  Expanded(child: WillPopScope(
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
                                //   _buildTabBar(),
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

                                                      Container(
                                                        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 60.0),
                                                        width: double.infinity,
                                                        child: OutlineButton(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(5.0)),
                                                          color: Colors.white,
                                                          padding: const EdgeInsets.all(0.0),
                                                          child: Container(
                                                            width: double.infinity,
                                                            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                                            child: DropdownButton(
                                                              isExpanded:true,
                                                              icon: Icon(Icons.keyboard_arrow_down),
                                                              hint:Text("IPT Status"),
                                                              iconEnabledColor: Colors.black,
                                                              value: _currentIptStatus,
                                                              items: _dropDownMenuItemsStatuses,
                                                              onChanged: changedDropDownItemIptStatus,
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

                                                      SizedBox(
                                                        height: 10.0,
                                                      ),

                                                      Container(
                                                        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 60.0),
                                                        width: double.infinity,
                                                        child: OutlineButton(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(5.0)),
                                                          color: Colors.white,
                                                          padding: const EdgeInsets.all(0.0),
                                                          child: Container(
                                                            width: double.infinity,
                                                            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                                            child: DropdownButton(
                                                              isExpanded:true,
                                                              icon: Icon(Icons.keyboard_arrow_down),
                                                              hint:Text("Reason"),
                                                              iconEnabledColor: Colors.black,
                                                              value: _currentReason,
                                                              items: _dropDownMenuItemsEntryPoint,
                                                              onChanged: changedDropDownItemReason,
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



                                                      Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 30.0),
                                                        child: RaisedButton(
                                                          elevation: 4.0,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(5.0)),
                                                          color: Colors.blue,
                                                          padding: const EdgeInsets.all(20.0),
                                                          child: Text("Save",
                                                            style: TextStyle( fontSize: 15,
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w500),
                                                          ),

                                                          onPressed: () {


                                                          },

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
                              ],
                            );
                          },
                        ),
                        length: 3,
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

  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(text: "ART Registration", onTap: () =>     Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LandingScreen()),
          ),
          ),
          new RoundedButton(text: "Art IPT status", selected: true),
          new RoundedButton(text: "Close", onTap: () =>     Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SearchPatient()),
          ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsReasonList() {
    List<DropdownMenuItem<String>> items = new List();
    for (NameCode reasonListIdentified in _reasonListIdentified) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: reasonListIdentified.code, child: Text(reasonListIdentified.name)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsIptStatusList() {
    List<DropdownMenuItem<String>> items = new List();
    for (NameCode iptStatusListIdentified in _iptStatusListIdentified) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: iptStatusListIdentified.code, child: Text(iptStatusListIdentified.name)));
    }
    return items;
  }



  void changedDropDownItemReason (String selectedReferringProgramIdentified) {
    setState(() {
      _currentReason = selectedReferringProgramIdentified;
     reasonOptionIsValid=!reasonOptionIsValid;
      _reasonError=null;
    });
  }

  void changedDropDownItemIptStatus (String selectedReferringProgramIdentified) {
    setState(() {
      _currentIptStatus = selectedReferringProgramIdentified;
      iptStatusOptionIsValid=!iptStatusOptionIsValid;
      _iptStatusError=null;
    });
  }


}



