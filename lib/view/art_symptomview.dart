import 'dart:convert';

import 'package:ehr_mobile/model/artsymptom.dart';
import 'package:ehr_mobile/model/response.dart';
import 'package:ehr_mobile/model/sexualhistorydto.dart';
import 'package:ehr_mobile/model/sexualhistoryview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class ArtSymptomView extends StatefulWidget{
  ArtSymptom artSymptom;
  String personId;
  bool isQuestion;
  ArtSymptomView(this.artSymptom,  this.personId, this.isQuestion);

  @override
  State createState() {
    return ArtSymptomState();

  }
}
class ArtSymptomState extends State<ArtSymptomView>{
  String _picked;
  static const htsChannel =
  MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  String sexualHistoryDtoId ;
  bool _artsymptom = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 60.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.artSymptom.symptom.name),
              ),
              width: 250,
            ),
          ),
              Checkbox(
                value: _artsymptom,
                onChanged: _onArtSymptomChanged
              )
        ],
      ),
    );

  }

  void _onArtSymptomChanged(bool value) {
    setState(() {
      _artsymptom = value;

    });
  }


  Future<void>saveSexualHistoryDto(SexualHistoryDto sexualHistoryview)async{
    var response;
    try{
      response = htsChannel.invokeMethod('saveSexualHistoryDto', jsonEncode(sexualHistoryview));
      setState(() {
        sexualHistoryDtoId = response;
      });
    }catch(e){
      print("Exception thrown in save sexualhistory dto method");

    }
  }
}