import 'dart:convert';
import 'package:ehr_mobile/model/artInitiation.dart';
import 'package:ehr_mobile/model/art_reason.dart';
import 'package:ehr_mobile/model/artregmendto.dart';
import 'package:ehr_mobile/model/arv_combination_regimen.dart';
import 'package:ehr_mobile/model/entry_point.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/personInvestigation.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/view/home_page.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/art_initiationoverview.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/view/reception_vitals.dart';
import 'package:ehr_mobile/view/hts_registration.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import '../sidebar.dart';
import 'rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Art_Initiation extends StatefulWidget {

  final String patientId ;
  final String visitId;
  final Person person;
  final HtsRegistration htsRegistration;
  final String htsId;
  Art_Initiation(this.person, this.patientId, this.visitId, this.htsRegistration, this.htsId);

  @override
  State createState() {
    return _Art_Initiation();
  }
}

class _Art_Initiation extends State<Art_Initiation> {
  final _formKey = GlobalKey<FormState>();
  static const dataChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');


  static const artChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile.channel/art');
  String personId;
 // var selectedDate;
  bool _showError = false;
  bool _arvCombinationRegimenIsValid = false;
  bool _artReasonIsValid = false;
  bool _formIsValid = false;
  String _arvCombinationRegimenError = "Select Arv Regimen";
  String _artReasonError = "Select Art Reason";
  String artRegimenId;
  ArtInitiation initiation;
  ArtRegimenDto artRegimenDto;
  bool regimen_selected;

  int _line = 0;
  String line="";
 // DateTime date;
 // int _selecType = 0;
 // String clientType = "";



  String _arvCombinationRegimen;
  List arvCombinationRegimens = List();
  List _dropDownListArvCombinationRegimens = List();
  List<DropdownMenuItem<String>> _dropDownMenuItemsArvCombinationRegimen;
  List<ArvCombinationRegimen> _arvCombinationRegimenList = List();
  String _currentArvCombinationRegimen;
  String _artReason;
  List artReasons = List();
  List _dropDownListArtReasons = List();
  List<DropdownMenuItem<String>> _dropDownMenuItemsArtReason;
  List<ArtReason> _artReasonList = List();
  String _currentArtReason;
  ArtRegimenDto _artRegimenDto;

  @override
  void initState() {


    getArtReasons();
    getArvCombinationregimens(widget.patientId, "FIRST_LINE");

  //  patientId = patient.id;
    /*selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    date = DateTime.now();*/
    super.initState();
  }


  Future<void> getArtReasons() async {
    String response;
    try {
      response = await dataChannel.invokeMethod('getArtReasonOptions');
      setState(() {
        _artReason = response;
        artReasons = jsonDecode(_artReason);
        _dropDownListArtReasons = ArtReason.mapFromJson(artReasons);
        _dropDownListArtReasons.forEach((e) {
          _artReasonList.add(e);

        });

        _dropDownMenuItemsArtReason = getDropDownMenuItemsIdentifiedArtReason();

      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }


  Future<void> getArvCombinationregimens(String personId, String regimenType) async {
    String response;
    ArtRegimenDto artRegimenDto = ArtRegimenDto(personId, regimenType);
    try {
      response = await htsChannel.invokeMethod('getPersonArvCombinationRegimens',jsonEncode(artRegimenDto) );
      setState(() {
      debugPrint("@@@@@@@@@@@@@@@@@@@@@@@ list of ARV regimens returned in flutter"+ response);
        _arvCombinationRegimen=response;
        arvCombinationRegimens = jsonDecode(_arvCombinationRegimen);
        _dropDownListArvCombinationRegimens = ArvCombinationRegimen.mapFromJson(arvCombinationRegimens);
        _dropDownListArvCombinationRegimens.forEach((e) {
          _arvCombinationRegimenList.add(e);

        });
        _currentArvCombinationRegimen = _arvCombinationRegimenList[0].name;

        _dropDownMenuItemsArtReason = getDropDownMenuItemsIdentifiedArtReason();

        _dropDownMenuItemsArvCombinationRegimen = getDropDownMenuItemsIdentifiedArvCombinationRegimen();

      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }



  void _handleLineChange(int value) {
    print("Line : $value");
    setState(() {
      _line = value;

      switch (_line) {
        case 1:
          setState(() {
            line = "FIRST_LINE";
            _arvCombinationRegimenList.clear();
            getArvCombinationregimens(widget.patientId,"FIRST_LINE" );
              print("line value : $line");
          });
          break;
        case 2:
          setState(() {
            line = "SECOND_LINE";
            _arvCombinationRegimenList.clear();
            getArvCombinationregimens(widget.patientId,"SECOND_LINE" );
            print("line value : $line");

          });
          break;

        case 3:
          setState(() {
            line = "THIRD_LINE";
            _arvCombinationRegimenList.clear();
            getArvCombinationregimens(widget.patientId,"THIRD_LINE" );
            print("line value : $line");

          });
          break;
      }
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsIdentifiedArtReason() {
    List<DropdownMenuItem<String>> items = new List();
    for (ArtReason artReason in _artReasonList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: artReason.name, child: Text(artReason.name)));
    }
    return items;
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
      drawer:  Sidebar(widget.person, widget.patientId, widget.visitId, widget.htsRegistration, widget.htsId),
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
                    child: Text("Art Initiation", style: TextStyle(
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
                              child: Text(widget.person.firstName + " " + widget.person.lastName, style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14.0,color: Colors.white ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.date_range, size: 25.0, color: Colors.white,),
                            ),
                            /*  Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text("Age - 25", style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14.0,color: Colors.white ),),
                            ),*/
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

                                                      SizedBox(
                                                        height: 20.0,
                                                      ),

                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(30.0),
                                                                child: Text('Please Select'),
                                                              ),
                                                              width: 250,
                                                            ),
                                                          ),
                                                          Text('First Line'),
                                                          Radio(
                                                              value: 1,
                                                              groupValue: _line,
                                                              onChanged: _handleLineChange),
                                                          Text('2nd Line'),
                                                          Radio(
                                                              value: 2,
                                                              groupValue: _line,
                                                              onChanged: _handleLineChange),
                                                          Text('3rd Line'),
                                                          Radio(
                                                              value: 3,
                                                              groupValue: _line,
                                                              onChanged: _handleLineChange)
                                                        ],
                                                      ),

                                                      Container(
                                                        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
                                                        width: double.infinity,
                                                        child: OutlineButton(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(5.0)),
                                                          color: Colors.white,
                                                          padding: const EdgeInsets.all(0.0),
                                                          child: Container(
                                                              width: double.infinity,
                                                              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                                              child: SearchableDropdown(
                                                                icon: Icon(Icons.keyboard_arrow_down),
                                                                isExpanded:true,
                                                                items: _dropDownMenuItemsArvCombinationRegimen,
                                                                value: _currentArvCombinationRegimen,
                                                                hint: new Text(
                                                                    'Art Combination Regimen'
                                                                ),
                                                                searchHint: new Text(
                                                                  'Select Art Combination Regimen',
                                                                  style: new TextStyle(
                                                                      fontSize: 20
                                                                  ),
                                                                ),
                                                                onChanged: changedDropDownItemArvCombinationRegimen,
                                                              )
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
                                                      !_showError
                                                          ? SizedBox.shrink()
                                                          : Text( _arvCombinationRegimenError ?? "",
                                                        style: TextStyle(color: Colors.red),
                                                      ),

                                                      SizedBox(
                                                        height: 20.0,
                                                      ),
                                                     Container(
                                                        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
                                                        width: double.infinity,
                                                        child: OutlineButton(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(5.0)),
                                                          color: Colors.white,
                                                          padding: const EdgeInsets.all(0.0),
                                                          child: Container(

                                                              width: double.infinity,
                                                              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                                              child: SearchableDropdown(
                                                                icon: Icon(Icons.keyboard_arrow_down),
                                                                isExpanded:true,
                                                                items: _dropDownMenuItemsArtReason,
                                                                value: _currentArtReason,
                                                                hint: new Text(
                                                                    'Reason'
                                                                ),
                                                                searchHint: new Text(
                                                                  'Select Reason',
                                                                  style: new TextStyle(
                                                                      fontSize: 20
                                                                  ),
                                                                ),
                                                                onChanged: changedDropDownItemArtReason,
                                                              )
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
                                                      !_showError
                                                          ? SizedBox.shrink()
                                                          : Text( _artReasonError ?? "",
                                                        style: TextStyle(color: Colors.red),
                                                      ),

                                                      SizedBox(
                                                        height: 20.0,
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
                                                          child: Text("Initiate",
                                                            style: TextStyle( fontSize: 15,
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w500),
                                                          ),

                                                          onPressed: () {
                                                            ArtInitiation artInitiationDetails = ArtInitiation(widget.patientId, line, _currentArvCombinationRegimen, _currentArtReason);
                                                            print('*************************artReg number ${artInitiationDetails.line}');
                                                            artInitiation(artInitiationDetails);

                                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ArtInitiationOverview(artInitiationDetails, widget.person, widget.patientId, widget.visitId, widget.htsRegistration, widget.htsId)));

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
                    ArtReg(widget.patientId, widget.visitId, widget.person, widget.htsRegistration, widget.htsId)),
          ),
          ),
          new RoundedButton(text: "Art Initiation", selected: true),
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



  Future<void> artInitiation(ArtInitiation artInitiation) async {
    String response;
    print('*************************art initiation ${artInitiation.toString()}');
    try {
      response = await artChannel.invokeMethod(
          'saveArtInitiation', jsonEncode(artInitiation));
      setState(() {
        initiation = ArtInitiation.fromJson(jsonDecode(response));
      });
    } catch (e) {
      print('--------------something went wrong  $e');
    }

  }


  void changedDropDownItemArtReason(String selectedArtReason) {
    setState(() {

      _currentArtReason = selectedArtReason;
     _artReasonError = null;
      _artReasonIsValid=! _artReasonIsValid;

    });
  }

  void changedDropDownItemArvCombinationRegimen(String selectedArvCombinationRegimen) {

    setState(() {
      _currentArvCombinationRegimen = selectedArvCombinationRegimen;
      _arvCombinationRegimenError = null;

      _arvCombinationRegimenIsValid=! _arvCombinationRegimenIsValid;

    });
  }
}



