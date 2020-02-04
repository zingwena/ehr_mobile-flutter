import 'dart:convert';
import 'package:ehr_mobile/model/artInitiation.dart';

import 'package:ehr_mobile/model/artregmendto.dart';
import 'package:ehr_mobile/model/arv_combination_regimen.dart';

import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/age.dart';

import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/landing_screen.dart';

import 'package:ehr_mobile/view/art_initiationoverview.dart';

import 'package:ehr_mobile/sidebar.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/view/rounded_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ArtIptStatus extends StatefulWidget {



  ArtIptStatus();


  @override
  State createState() {
    return _ArtIptStatus();
  }
}

class _ArtIptStatus extends State<ArtIptStatus> {
  final _formKey = GlobalKey<FormState>();
  static const dataChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  static const artChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile.channel/art');
  String personId;

  String artRegimenId;
  String  _currentReason;
  ArtInitiation initiation;
  ArtRegimenDto artRegimenDto;
  bool regimen_selected;

  String line="";
  bool selfIdentifiedReferringIsValid=false;
  String _reasonError="Select Referring Program";

  int _reason = 0;
  bool reasonOption = false;

  List<ArvCombinationRegimen> _arvCombinationRegimenList = List();
  String _currentArvCombinationRegimen;

  List _reasonListIdentified = ["Reason 1", "Reason 2", "Reason 3", "Reason 4", "Reason 5" ];

  String _currentArtReason;

  Age age;

  String facility_name;


  List<DropdownMenuItem<String>> _dropDownMenuItemsReasonIdentified;

  @override
  void initState() {

    //getAge(widget.person);
    getFacilityName();

    _dropDownMenuItemsReasonIdentified = getDropDownMenuItemsReasonList();

    super.initState();
  }

  void _handleReasonOption (int value) {
    setState(() {
      _reason = value;

      switch (_reason) {
        case 1:
          reasonOption = true;
          break;
        case 2:
          reasonOption = true;
          break;
      }
    });
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

  List<DropdownMenuItem<String>> getDropDownMenuItemsIdentifiedArvCombinationRegimen() {
    List<DropdownMenuItem<String>> items = new List();
    for (ArvCombinationRegimen arvCombinationRegimen in _arvCombinationRegimenList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: arvCombinationRegimen.name, child: Text(arvCombinationRegimen.name)));
    }
    return items;
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
                                                        width: double.infinity,
                                                        padding:
                                                        EdgeInsets.symmetric( vertical: 16.0, horizontal: 100.0 ),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: SizedBox(
                                                                child: Padding(
                                                                  padding:
                                                                  const EdgeInsets.all(8.0),
                                                                  child: Text('IPT Status'),
                                                                ),
                                                                width: 250,
                                                              ),
                                                            ),
                                                            Text('Yes'),
                                                            Radio(
                                                                value: 1,
                                                                groupValue: _reason,
                                                                activeColor:
                                                                Colors.blue,
                                                                onChanged:
                                                                _handleReasonOption),
                                                            Text('No'),
                                                            Radio(
                                                                value: 2,
                                                                groupValue: _reason,
                                                                activeColor: Colors.blue,
                                                                onChanged: _handleReasonOption),

                                                          ],
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
                                                              items: _dropDownMenuItemsReasonIdentified,
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
                                                        padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
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
    for (String reasonListIdentified in _reasonListIdentified) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: reasonListIdentified, child: Text(reasonListIdentified)));
    }
    return items;
  }


  void changedDropDownItemReason(String selectedReferringProgramIdentified) {
    setState(() {
      _currentReason = selectedReferringProgramIdentified;
      selfIdentifiedReferringIsValid=!selfIdentifiedReferringIsValid;
      _reasonError=null;
    });
  }


}



