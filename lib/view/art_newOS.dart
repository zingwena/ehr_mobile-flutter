import 'dart:convert';

import 'package:ehr_mobile/landing_screen.dart';
import 'package:ehr_mobile/model/country.dart';
import 'package:ehr_mobile/view/rounded_button.dart';
import 'package:ehr_mobile/view/art_symptoms.dart';
import 'package:ehr_mobile/login_screen.dart';

import 'package:ehr_mobile/view/patient_address.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'patient_address.dart';
//import 'rounded_button.dart';
//import 'package:ehr_mobile/login_screen.dart';

class ArtNewOI extends StatefulWidget {

  ArtNewOI();

  @override
  State createState() {
    return _ArtNewOI();
  }
}

class _ArtNewOI extends State<ArtNewOI> {
  static const platform = MethodChannel('example.channel.dev/people');
  static final MethodChannel addPatient= MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/addPatient');

  static const dataChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  final _formKey = GlobalKey<FormState>();


  bool _formValid=false;
  bool showError=false;

  int _zoster = 0;
  bool zosterOption = false;

  int _thrushVaginal = 0;
  bool thrushVaginalOption = false;

  int _dementia = 0;
  bool dementiaOption = false;

  int _pneumonia = 0;
  bool pneumoniaOption = false;

  int _cough = 0;
  bool coughOption = false;

  int _fever = 0;
  bool feverOption = false;

  int _hypertension = 0;
  bool hypertensionOption = false;

  int _diabetes = 0;
  bool diabetesOption = false;

  int _mentalDisorders = 0;
  bool mentalDisordersOption = false;

  int _thrushOral = 0;
  bool thrushOralOption = false;

  int _ulcersGenital = 0;
  bool ulcersGenitalOption = false;

  int _iris = 0;
  bool irisOption = false;

  int _ulcersOral = 0;
  bool ulcersOralOption = false;

  int _difficultBreathing = 0;
  bool difficultBreathingOption = false;

  int _tb = 0;
  bool tbOption = false;

  int _cancer = 0;
  bool cancerOption = false;

  int _hepatitis = 0;
  bool hepatitisOption = false;

  int _weightLoss = 0;
  bool weightLossOption = false;

  @override
  void initState() {

    super.initState();
  }

  void _handleZosterOption (int value) {
    setState(() {
      _zoster = value;

      switch (_zoster) {
        case 1:
          zosterOption = true;
          break;
        case 2:
          zosterOption = true;
          break;
      }
    });
  }

  void _handleThrushVaginalOption (int value) {
    setState(() {
      _thrushVaginal = value;

      switch (_thrushVaginal) {
        case 1:
          thrushVaginalOption = true;
          break;
        case 2:
          thrushVaginalOption = true;
          break;
      }
    });
  }

  void _handleDementiaOption (int value) {
    setState(() {
      _dementia = value;

      switch (_dementia) {
        case 1:
          dementiaOption = true;
          break;
        case 2:
          dementiaOption = true;
          break;
      }
    });
  }

  void _handlePneumoniaOption (int value) {
    setState(() {
      _pneumonia = value;

      switch (_pneumonia) {
        case 1:
          pneumoniaOption = true;
          break;
        case 2:
          pneumoniaOption = true;
          break;
      }
    });
  }

  void _handleCoughOption (int value) {
    setState(() {
      _cough = value;

      switch (_cough) {
        case 1:
          coughOption = true;
          break;
        case 2:
          coughOption = true;
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

  void _handleHypertensionOption (int value) {
    setState(() {
      _hypertension = value;

      switch (_hypertension) {
        case 1:
          hypertensionOption = true;
          break;
        case 2:
          hypertensionOption = true;
          break;
      }
    });
  }



  void _handleDiabetesOption (int value) {
    setState(() {
      _diabetes = value;

      switch (_diabetes) {
        case 1:
          diabetesOption = true;
          break;
        case 2:
          diabetesOption = true;
          break;
      }
    });
  }

  void _handleMentalDisordersOption (int value) {
    setState(() {
      _mentalDisorders = value;

      switch (_mentalDisorders) {
        case 1:
          mentalDisordersOption = true;
          break;
        case 2:
          mentalDisordersOption = true;
          break;
      }
    });
  }

  void _handleThrushOralOption (int value) {
    setState(() {
      _thrushOral = value;

      switch (_thrushOral) {
        case 1:
          thrushOralOption = true;
          break;
        case 2:
          thrushOralOption = true;
          break;
      }
    });
  }

  void _handleUlcersGenitalOption (int value) {
    setState(() {
      _ulcersGenital = value;

      switch (_ulcersGenital) {
        case 1:
          ulcersGenitalOption = true;
          break;
        case 2:
          ulcersGenitalOption = true;
          break;
      }
    });
  }

  void _handleIrisOption (int value) {
    setState(() {
      _iris = value;

      switch (_iris) {
        case 1:
          irisOption = true;
          break;
        case 2:
          irisOption = true;
          break;
      }
    });
  }

  void _handleUlcersOralOption (int value) {
    setState(() {
      _ulcersOral = value;

      switch (_ulcersOral) {
        case 1:
          ulcersOralOption = true;
          break;
        case 2:
          ulcersOralOption = true;
          break;
      }
    });
  }

  void _handleDifficultBreathingOption (int value) {
    setState(() {
      _difficultBreathing = value;

      switch (_difficultBreathing) {
        case 1:
          difficultBreathingOption = true;
          break;
        case 2:
          difficultBreathingOption = true;
          break;
      }
    });
  }

  void _handleTbOption (int value) {
    setState(() {
      _tb = value;

      switch (_tb) {
        case 1:
          tbOption = true;
          break;
        case 2:
          tbOption = true;
          break;
      }
    });
  }

  void _handleCancerOption (int value) {
    setState(() {
      _cancer = value;

      switch (_cancer) {
        case 1:
          cancerOption = true;
          break;
        case 2:
          cancerOption = true;
          break;
      }
    });
  }

  void _handleHepatitisOption (int value) {
    setState(() {
      _hepatitis = value;

      switch (_hepatitis) {
        case 1:
          hepatitisOption = true;
          break;
        case 2:
          hepatitisOption = true;
          break;
      }
    });
  }

  void _handleWeightLossOption (int value) {
    setState(() {
      _weightLoss = value;

      switch (_weightLoss) {
        case 1:
          weightLossOption = true;
          break;
        case 2:
          weightLossOption = true;
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
                    child: Text("Art New OIs", style: TextStyle(
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
                                                                    child: Text('Zoster '),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _zoster,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleZosterOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _zoster,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleZosterOption),

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
                                                                    child: Text('Thrush / Vaginal '),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _thrushVaginal,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleThrushVaginalOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _thrushVaginal,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleThrushVaginalOption),

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
                                                                    child: Text('Dementia'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _dementia,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleDementiaOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _dementia,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleDementiaOption),

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
                                                                    child: Text('Pneumonia'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _pneumonia,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handlePneumoniaOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _pneumonia,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handlePneumoniaOption),

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
                                                                    child: Text('Cough'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _cough,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleCoughOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _cough,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleCoughOption),

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
                                                                    child: Text('Fever'),
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
                                                                    child: Text('Hypertension'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _hypertension,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleHypertensionOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _hypertension,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleHypertensionOption),

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
                                                                    child: Text('Diabetes Mellitus'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _diabetes,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleDiabetesOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _diabetes,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleDiabetesOption),

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
                                                                    child: Text('Mental Disorders'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _mentalDisorders,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleMentalDisordersOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _mentalDisorders,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleMentalDisordersOption),

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
                                                                    child: Text('Thrush - Oral'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _thrushOral,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleThrushOralOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _thrushOral,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleThrushOralOption),

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
                                                                    child: Text('Ulcers - Genital'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _ulcersGenital,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleUlcersGenitalOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _ulcersGenital,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleUlcersGenitalOption),

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
                                                                    child: Text('IRIS'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _iris,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleIrisOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _iris,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleIrisOption),

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
                                                                    child: Text('Ulcers - Oral'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _ulcersOral,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleUlcersOralOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _ulcersOral,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleUlcersOralOption),

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
                                                                    child: Text('Difficult Breathing'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _difficultBreathing,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleDifficultBreathingOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _difficultBreathing,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleDifficultBreathingOption),

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
                                                                    child: Text('TB'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _tb,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleTbOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _tb,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleTbOption),

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
                                                                    child: Text('Cancer'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _cancer,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleCancerOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _cancer,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleCancerOption),

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
                                                                    child: Text('Hepatitis'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _hepatitis,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleHepatitisOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _hepatitis,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleHepatitisOption),

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
                                                                    child: Text('Weight Loss'),
                                                                  ),
                                                                  width: 250,
                                                                ),
                                                              ),
                                                              Text('Yes'),
                                                              Radio(
                                                                  value: 1,
                                                                  groupValue: _weightLoss,
                                                                  activeColor:
                                                                  Colors.blue,
                                                                  onChanged:
                                                                  _handleWeightLossOption),
                                                              Text('No'),
                                                              Radio(
                                                                  value: 2,
                                                                  groupValue: _weightLoss,
                                                                  activeColor: Colors.blue,
                                                                  onChanged: _handleWeightLossOption),

                                                            ],
                                                          ),
                                                        ),


                                                        SizedBox(
                                                          height: 30.0,
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
                                                                //Icon(Icons.navigate_next, color: Colors.white, ),
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
            selected: true,
          ),

          new RoundedButton(
            text: "Art Symptoms",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ArtSymptoms()),
            ),

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

