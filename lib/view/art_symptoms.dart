import 'dart:convert';


import 'package:ehr_mobile/landing_screen.dart';
import 'package:ehr_mobile/model/country.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/view/rounded_button.dart';
import 'package:ehr_mobile/login_screen.dart';

import 'package:ehr_mobile/view/patient_address.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'patient_address.dart';
//import 'rounded_button.dart';
//import 'package:ehr_mobile/login_screen.dart';

class ArtSymptoms extends StatefulWidget {


  ArtSymptoms();

  @override
  State createState() {
    return _ArtSymptoms();
  }
}

class _ArtSymptoms extends State<ArtSymptoms> {
  static const platform = MethodChannel('example.channel.dev/people');
  static final MethodChannel addPatient= MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/addPatient');

  static const dataChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  final _formKey = GlobalKey<FormState>();

  List<String> _list;
  DateTime birthDate;
  Person registeredPatient;
  String lastName,  firstName,nationalId, religion, country,occupation,educationLevel,nationality,maritalStatus;


  bool _formValid=false;
  bool showError=false;

  String clinicalStage = "";
  int _gender = 0;
  String gender = "";

  int _diarrhoea = 0;
  bool diarrhoeaOption = false;

  int _currentCoughProductive = 0;
  bool currentCoughProductiveOption = false;

  int _otherCurrentSypmtoms = 0;
  bool otherCurrentSypmtomsOption = false;

  int _currentCough = 0;
  bool currentCoughOption = false;

  int _fluLikeURTI = 0;
  bool fluLikeURTIOption = false;

  int _fever = 0;
  bool feverOption = false;

  int _difficultSwallowing = 0;
  bool difficultSwallowingOption = false;

  int _abdominalPain = 0;
  bool abdominalPainOption = false;

  int _chronicFatigue = 0;
  bool chronicFatigueOption = false;

  int _numbnessTingling = 0;
  bool numbnessTinglingOption = false;

  int _headAche = 0;
  bool headAcheOption = false;

  int _difficultRespiration = 0;
  bool difficultRespirationOption = false;

  int _nightSweats = 0;
  bool nightSweatsOption = false;

  int _nauseaVomiting = 0;
  bool nauseaVomitingOption = false;

  int _chronicPain = 0;
  bool chronicPainOption = false;

  int _burningHandsFeet = 0;
  bool burningHandsFeetOption = false;


  @override
  void initState() {

    super.initState();
  }

  void _handleDiarrhoeaOption (int value) {
    setState(() {
      _diarrhoea = value;

      switch (_diarrhoea) {
        case 1:
          diarrhoeaOption = true;
          break;
        case 2:
          diarrhoeaOption = true;
          break;
      }
    });
  }

  void _handleCurrentCoughProductiveOption (int value) {
    setState(() {
      _currentCoughProductive = value;

      switch (_currentCoughProductive) {
        case 1:
          currentCoughProductiveOption = true;
          break;
        case 2:
          currentCoughProductiveOption = true;
          break;
      }
    });
  }

  void _handleOtherCurrentSymptomsOption (int value) {
    setState(() {
      _otherCurrentSypmtoms = value;

      switch (_otherCurrentSypmtoms) {
        case 1:
          otherCurrentSypmtomsOption = true;
          break;
        case 2:
          otherCurrentSypmtomsOption = true;
          break;
      }
    });
  }

  void _handleCurrentCoughOption (int value) {
    setState(() {
      _currentCough = value;

      switch (_currentCough) {
        case 1:
          currentCoughOption = true;
          break;
        case 2:
          currentCoughOption = true;
          break;
      }
    });
  }

  void _handleFluLikeOption (int value) {
    setState(() {
      _fluLikeURTI = value;

      switch (_fluLikeURTI) {
        case 1:
          fluLikeURTIOption = true;
          break;
        case 2:
          fluLikeURTIOption = true;
          break;
      }
    });
  }

  void _handleFeverOption (int value) {
    setState(() {
      _fever = value;

      switch (_fever) {
        case 1:
          feverOption = true;
          break;
        case 2:
          feverOption = true;
          break;
      }
    });
  }

  void _handleDifficultSwallowingOption (int value) {
    setState(() {
      _difficultSwallowing = value;

      switch (_difficultSwallowing) {
        case 1:
          difficultSwallowingOption = true;
          break;
        case 2:
          difficultSwallowingOption = true;
          break;
      }
    });
  }

  void _handleAbdominalPainOption (int value) {
    setState(() {
      _abdominalPain = value;

      switch (_abdominalPain) {
        case 1:
          abdominalPainOption = true;
          break;
        case 2:
          abdominalPainOption = true;
          break;
      }
    });
  }

  void _handleChronicFatigueOption (int value) {
    setState(() {
      _chronicFatigue = value;

      switch (_chronicFatigue) {
        case 1:
          chronicFatigueOption = true;
          break;
        case 2:
          chronicFatigueOption = true;
          break;
      }
    });
  }

  void _handleNumbnessTinglingOption (int value) {
    setState(() {
      _numbnessTingling = value;

      switch (_numbnessTingling) {
        case 1:
          numbnessTinglingOption = true;
          break;
        case 2:
          numbnessTinglingOption = true;
          break;
      }
    });
  }

  void _handleHeadacheOption (int value) {
    setState(() {
      _headAche = value;

      switch (_headAche) {
        case 1:
          headAcheOption = true;
          break;
        case 2:
          headAcheOption = true;
          break;
      }
    });
  }

  void _handleDifficultRespirationOption (int value) {
    setState(() {
      _difficultRespiration = value;

      switch (_difficultRespiration) {
        case 1:
          difficultRespirationOption = true;
          break;
        case 2:
          difficultRespirationOption = true;
          break;
      }
    });
  }


  void _handleNightSweatsOption (int value) {
    setState(() {
      _nightSweats = value;

      switch (_nightSweats) {
        case 1:
          nightSweatsOption = true;
          break;
        case 2:
          nightSweatsOption = true;
          break;
      }
    });
  }


  void _handleNauseaVomitingOption (int value) {
    setState(() {
      _nauseaVomiting = value;

      switch (_nauseaVomiting) {
        case 1:
          nauseaVomitingOption = true;
          break;
        case 2:
          nauseaVomitingOption = true;
          break;
      }
    });
  }


  void _handleChronicPainOption (int value) {
    setState(() {
      _chronicPain = value;

      switch (_chronicPain) {
        case 1:
          chronicPainOption = true;
          break;
        case 2:
          chronicPainOption = true;
          break;
      }
    });
  }


  void _handleBurningHandsFeetOption (int value) {
    setState(() {
      _burningHandsFeet = value;

      switch (_burningHandsFeet) {
        case 1:
          burningHandsFeetOption = true;
          break;
        case 2:
          burningHandsFeetOption = true;
          break;
      }
    });
  }






  String nullValidator(var cell) {
    return cell == null ? "" : cell;
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
                  top: MediaQuery.of(context).padding.top + 40.0),
              child: new Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text("Art Symptoms", style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16.0,color: Colors.white ),),
                  ),
                 _buildButtonsRow(),
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
                                //_buildLinkBar(),
                                Container(
                                  height: 2.0,
                                  color: Colors.blue,
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: new ConstrainedBox(
                                      constraints: new BoxConstraints(
                                        minHeight: viewportConstraints.maxHeight - 48.0,
                                      ),
                                      child: new IntrinsicHeight(
                                          child: Column(
                                            children: <Widget>[
                                              Form(key: _formKey,

                                                child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: <Widget>[
                                                        SizedBox(
                                                          height: 35.0,
                                                        ),

                                                        Container(
                                                          width: double.infinity,
                                                          padding:
                                                          EdgeInsets.symmetric( vertical: 16.0, horizontal: 130.0 ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: SizedBox(
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(8.0),
                                                                    child: Text('Diarrhoea > 1 Month'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _diarrhoea,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleDiarrhoeaOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _diarrhoea,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleDiarrhoeaOption),

                                                            ],
                                                          ),
                                                        ),

                                                        Container(
                                                          width: double.infinity,
                                                          padding:
                                                          EdgeInsets.symmetric( vertical: 16.0, horizontal: 130.0 ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: SizedBox(
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(8.0),
                                                                    child: Text('Current Cough - productive'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _currentCoughProductive,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleCurrentCoughProductiveOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _currentCoughProductive,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleCurrentCoughProductiveOption),

                                                            ],
                                                          ),
                                                        ),


                                                        Container(
                                                          width: double.infinity,
                                                          padding:
                                                          EdgeInsets.symmetric( vertical: 16.0, horizontal: 130.0 ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: SizedBox(
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(8.0),
                                                                    child: Text('Other Current Symptoms'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _otherCurrentSypmtoms,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleOtherCurrentSymptomsOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _otherCurrentSypmtoms,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleOtherCurrentSymptomsOption),

                                                            ],
                                                          ),
                                                        ),

                                                        Container(
                                                          width: double.infinity,
                                                          padding:
                                                          EdgeInsets.symmetric( vertical: 16.0, horizontal: 130.0 ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: SizedBox(
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(8.0),
                                                                    child: Text('Current Cough'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _currentCough,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleCurrentCoughOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _currentCough,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleCurrentCoughOption),

                                                            ],
                                                          ),
                                                        ),

                                                        Container(
                                                          width: double.infinity,
                                                          padding:
                                                          EdgeInsets.symmetric( vertical: 16.0, horizontal: 130.0 ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: SizedBox(
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(8.0),
                                                                    child: Text('Flu-Like ( URTI )'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _fluLikeURTI,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleFluLikeOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _fluLikeURTI,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleFluLikeOption),

                                                            ],
                                                          ),
                                                        ),

                                                        Container(
                                                          width: double.infinity,
                                                          padding:
                                                          EdgeInsets.symmetric( vertical: 16.0, horizontal: 130.0 ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: SizedBox(
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(8.0),
                                                                    child: Text('Fever ( >1 Month )'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _fever,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleFeverOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _fever,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleFeverOption),

                                                            ],
                                                          ),
                                                        ),

                                                        Container(
                                                          width: double.infinity,
                                                          padding:
                                                          EdgeInsets.symmetric( vertical: 16.0, horizontal: 130.0 ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: SizedBox(
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(8.0),
                                                                    child: Text('Difficult in swallowing ( Dysphagia ) and or ( Odynophagia )'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _difficultSwallowing,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleDifficultSwallowingOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _difficultSwallowing,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleDifficultSwallowingOption),

                                                            ],
                                                          ),
                                                        ),

                                                        Container(
                                                          width: double.infinity,
                                                          padding:
                                                          EdgeInsets.symmetric( vertical: 16.0, horizontal: 130.0 ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: SizedBox(
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(8.0),
                                                                    child: Text('Abdominal Pain'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _abdominalPain,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleAbdominalPainOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _abdominalPain,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleAbdominalPainOption),

                                                            ],
                                                          ),
                                                        ),

                                                        Container(
                                                          width: double.infinity,
                                                          padding:
                                                          EdgeInsets.symmetric( vertical: 16.0, horizontal: 130.0 ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: SizedBox(
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(8.0),
                                                                    child: Text('Chronic Fatigue'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _chronicFatigue,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleChronicFatigueOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _chronicFatigue,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleChronicFatigueOption),

                                                            ],
                                                          ),
                                                        ),

                                                        Container(
                                                          width: double.infinity,
                                                          padding:
                                                          EdgeInsets.symmetric( vertical: 16.0, horizontal: 130.0 ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: SizedBox(
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(8.0),
                                                                    child: Text('Numbness / Tingling'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _numbnessTingling,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleNumbnessTinglingOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _numbnessTingling,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleNumbnessTinglingOption),

                                                            ],
                                                          ),
                                                        ),


                                                        Container(
                                                          width: double.infinity,
                                                          padding:
                                                          EdgeInsets.symmetric( vertical: 16.0, horizontal: 130.0 ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: SizedBox(
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(8.0),
                                                                    child: Text('Difficult / Respiration ( Dyspnea )'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _difficultRespiration,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleDifficultRespirationOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _difficultRespiration,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleDifficultRespirationOption),

                                                            ],
                                                          ),
                                                        ),

                                                        Container(
                                                          width: double.infinity,
                                                          padding:
                                                          EdgeInsets.symmetric( vertical: 16.0, horizontal: 130.0 ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: SizedBox(
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(8.0),
                                                                    child: Text('Night Sweats'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _nightSweats,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleNightSweatsOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _nightSweats,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleNightSweatsOption),

                                                            ],
                                                          ),
                                                        ),

                                                        Container(
                                                          width: double.infinity,
                                                          padding:
                                                          EdgeInsets.symmetric( vertical: 16.0, horizontal: 130.0 ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: SizedBox(
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(8.0),
                                                                    child: Text('Nausea And Or Vomiting'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _nauseaVomiting,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleNauseaVomitingOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _nauseaVomiting,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleNauseaVomitingOption),

                                                            ],
                                                          ),
                                                        ),

                                                        Container(
                                                          width: double.infinity,
                                                          padding:
                                                          EdgeInsets.symmetric( vertical: 16.0, horizontal: 130.0 ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: SizedBox(
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(8.0),
                                                                    child: Text('Chronic Pain'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _chronicPain,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleChronicPainOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _chronicPain,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleChronicPainOption),

                                                            ],
                                                          ),
                                                        ),

                                                        Container(
                                                          width: double.infinity,
                                                          padding:
                                                          EdgeInsets.symmetric( vertical: 16.0, horizontal: 130.0 ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: SizedBox(
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(8.0),
                                                                    child: Text('Burning Hands Or Feet'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _burningHandsFeet,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleBurningHandsFeetOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _burningHandsFeet,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleBurningHandsFeetOption),

                                                            ],
                                                          ),
                                                        ),

                                                        Container(
                                                          width: double.infinity,
                                                          padding:
                                                          EdgeInsets.symmetric( vertical: 16.0, horizontal: 130.0 ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: SizedBox(
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(8.0),
                                                                    child: Text('Difficult / Laboured Respiration ( Dyspnea )'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _difficultRespiration,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleDifficultRespirationOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _difficultRespiration,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleDifficultRespirationOption),

                                                            ],
                                                          ),
                                                        ),


                                                        Container(
                                                          width: double.infinity,
                                                          padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 30.0) ,
                                                          child: RaisedButton(
                                                            elevation: 8.0,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(5.0)),
                                                            color: Colors.blue,
                                                            padding: const EdgeInsets.all(20.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Text('Save', style: TextStyle(color: Colors.white),),
                                                               // Icon(Icons.navigate_next, color: Colors.white, ),
                                                              ],
                                                            ),
                                                            onPressed: () {
                                                              setState(() {
                                                                _formValid = true;
                                                              });


                                                              if (_formValid) {
                                                                _formKey.currentState.save();

                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            LandingScreen()));
                                                              }

                                                            },
                                                          ),
                                                        ),

                                                        SizedBox(
                                                          height: 20.0,
                                                        ),

                                                      ],
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
          new RoundedButton(
            text: "Art NewOIs",

          ),

          new RoundedButton(
            text: "Art Symptoms",
            selected: true,
          ),

          new RoundedButton(
            text: "Close",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            ),
          ),
        ],
      ),
    );
  }

}

