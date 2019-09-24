import 'dart:convert';

import 'package:ehr_mobile/model/artInitiation.dart';
import 'package:ehr_mobile/model/art_reason.dart';
import 'package:ehr_mobile/model/arv_combination_regimen.dart';
import 'package:ehr_mobile/model/entry_point.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';

import 'package:ehr_mobile/model/personInvestigation.dart';
import 'package:ehr_mobile/view/art_registration.dart';
import 'package:ehr_mobile/view/home_page.dart';
import 'rounded_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Art_Initiation extends StatefulWidget {

  @override
  State createState() {
    return _Art_Initiation();
  }
}

class _Art_Initiation extends State<Art_Initiation> {
  final _formKey = GlobalKey<FormState>();
  static const dataChannel =
  MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');

  static const artChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile.channel/art');

  int visitId;
  int patientId;

  var selectedDate;
  bool _showError = false;
  bool _arvCombinationRegimenIsValid = false;
  bool _artReasonIsValid = false;
  bool _formIsValid = false;
  String _arvCombinationRegimenError = "Select Arv Regimen";
  String _artReasonError = "Select Art Reason";
  DateTime date;
  int _selecType = 0;
  String clientType = "";



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






  @override
  void initState() {


    getArtReasons();
    getArvCombinationregimens();
    selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    date = DateTime.now();
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


        /*_dropDownMenuItemsEntryPoint =
            getDropDownMenuItemsIdentifiedEntryPoint();*/
      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }


  Future<void> getArvCombinationregimens() async {
    String response;
    try {
      response = await dataChannel.invokeMethod('getArvCombinationRegimenOptions');
      setState(() {

        _arvCombinationRegimen=response;
        arvCombinationRegimens = jsonDecode(_arvCombinationRegimen);
        _dropDownListArvCombinationRegimens = ArvCombinationRegimen.mapFromJson(arvCombinationRegimens);

        _dropDownListArvCombinationRegimens.forEach((e) {
          _arvCombinationRegimenList.add(e);

        });

        _dropDownMenuItemsArtReason = getDropDownMenuItemsIdentifiedArtReason();

        _dropDownMenuItemsArvCombinationRegimen = getDropDownMenuItemsIdentifiedArvCombinationRegimen();


        /*_dropDownMenuItemsEntryPoint =
            getDropDownMenuItemsIdentifiedEntryPoint();*/
      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }


  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = DateFormat("yyyy/MM/dd").format(picked);
        date = DateFormat("yyyy/MM/dd").parse(selectedDate);
      });
  }

  void _handleHtsTypeChange(int value) {
    print("hts value : $value");
    setState(() {
      _selecType = value;

      switch (_selecType) {
        case 1:
          clientType = "New Client";
          print("client value : $clientType");

          break;
        case 2:
          clientType = "Old Client";
          print("client value : $clientType");

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
          value: artReason.code, child: Text(artReason.name)));
    }
    return items;
  }


  List<DropdownMenuItem<String>> getDropDownMenuItemsIdentifiedArvCombinationRegimen() {
    List<DropdownMenuItem<String>> items = new List();
    for (ArvCombinationRegimen arvCombinationRegimen in _arvCombinationRegimenList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: arvCombinationRegimen.code, child: Text(arvCombinationRegimen.name)));
    }
    return items;
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
            title: new Text(
                "Art Initiation"
            ),
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
                                                                padding: EdgeInsets.symmetric(
                                                                    vertical: 0.0, horizontal: 30.0),
                                                                child: TextFormField(
                                                                  controller:
                                                                  TextEditingController(text: selectedDate),
                                                                  validator: (value) {
                                                                    return value.isEmpty ? 'Enter some text' : null;
                                                                  },
                                                                  decoration: InputDecoration(
                                                                      labelText: 'Date of Enrolment into Care',
                                                                      border: OutlineInputBorder()),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          IconButton(
                                                            icon: Icon(Icons.calendar_today),
                                                            color: Colors.blue,
                                                            onPressed: () {
                                                              _selectDate(context);
                                                            },
                                                          ),

                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(
                                                                    vertical: 0.0, horizontal: 30.0),
                                                                child: TextFormField(
                                                                  controller:
                                                                  TextEditingController(text: selectedDate),
                                                                  validator: (value) {
                                                                    return value.isEmpty ? 'Enter some text' : null;
                                                                  },
                                                                  decoration: InputDecoration(
                                                                      labelText: 'Date initiatiated on ART',
                                                                      border: OutlineInputBorder()),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          IconButton(
                                                            icon: Icon(Icons.calendar_today),
                                                            color: Colors.blue,
                                                            onPressed: () {
                                                              _selectDate(context);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                     /* Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(30.0),
                                                                child: Text('Client Type'),
                                                              ),
                                                              width: 250,
                                                            ),
                                                          ),
                                                          Text('New Client'),
                                                          Radio(
                                                              value: 1,
                                                              groupValue: _selecType,
                                                              onChanged: _handleHtsTypeChange),
                                                          Text('Old Client'),
                                                          Radio(
                                                              value: 2,
                                                              groupValue: _selecType,
                                                              onChanged: _handleHtsTypeChange)
                                                        ],
                                                      ),*/

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
                                                              groupValue: _selecType,
                                                              onChanged: _handleHtsTypeChange),
                                                          Text('2nd Line'),
                                                          Radio(
                                                              value: 2,
                                                              groupValue: _selecType,
                                                              onChanged: _handleHtsTypeChange),
                                                          Text('3rd Line'),
                                                          Radio(
                                                              value: 2,
                                                              groupValue: _selecType,
                                                              onChanged: _handleHtsTypeChange)
                                                        ],
                                                      ),

                                                      Container(
                                                        padding:
                                                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                                                        width: double.infinity,
                                                        child: OutlineButton(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(5.0)),
                                                          color: Colors.white,
                                                          padding: const EdgeInsets.all(0.0),
                                                          child: Container(
                                                            width: double.infinity,
                                                            padding: EdgeInsets.symmetric(
                                                                vertical: 8.0, horizontal: 30.0),
                                                            child: DropdownButton(
                                                              hint: Text('Select Art Combination Regimen'),
                                                              icon: Icon(Icons.keyboard_arrow_down),
                                                              iconEnabledColor: Colors.black,
                                                              value: _currentArvCombinationRegimen,
                                                              items: _dropDownMenuItemsArvCombinationRegimen,
                                                              onChanged: changedDropDownItemArvCombinationRegimen,
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
                                                      !_showError
                                                          ? SizedBox.shrink()
                                                          : Text( _arvCombinationRegimenError ?? "",
                                                        style: TextStyle(color: Colors.red),
                                                      ),

                                                      SizedBox(
                                                        height: 20.0,
                                                      ),

                                                      Container(
                                                        padding:
                                                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                                                        width: double.infinity,
                                                        child: OutlineButton(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(5.0)),
                                                          color: Colors.white,
                                                          padding: const EdgeInsets.all(0.0),
                                                          child: Container(
                                                            width: double.infinity,
                                                            padding: EdgeInsets.symmetric(
                                                                vertical: 8.0, horizontal: 30.0),
                                                            child: DropdownButton(
                                                              hint: Text('Reason'),
                                                              icon: Icon(Icons.keyboard_arrow_down),
                                                              iconEnabledColor: Colors.black,
                                                              value: _currentArtReason,
                                                              items: _dropDownMenuItemsArtReason,
                                                              onChanged: changedDropDownItemArtReason,


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
          new RoundedButton(text: "ART Initiation", onTap: () =>     Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Art_Initiation()),
          ),
          ),
          new RoundedButton(text: "Art Registration", onTap: () =>     Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomePage()),
          ),
          ),
          new RoundedButton(text: "CLOSE", onTap: () =>     Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomePage()),
          ),
          ),
        ],
      ),
    );
  }



  Future<void> registration(ArtInitiation artInitiation) async {
    int id;
    print('*************************art initiation ${artInitiation.toString()}');
    try {
      id = await artChannel.invokeMethod(
          'saveArtInitiation', jsonEncode(artInitiation));
      String patientid = patientId.toString();

     /* PersonInvestigation personInvestigation = new PersonInvestigation(
          patientid, "36069471-adee-11e7-b30f-3372a2d8551e", date, null);*/
      await artChannel.invokeMethod('saveArtInitiation',jsonEncode(artInitiation));

      print('---------------------saved file id  $id');
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



