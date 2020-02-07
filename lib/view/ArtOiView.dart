import 'dart:convert';

import 'package:ehr_mobile/model/artoi.dart';
import 'package:ehr_mobile/model/artsymptom.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/response.dart';
import 'package:ehr_mobile/model/sexualhistorydto.dart';
import 'package:ehr_mobile/model/sexualhistoryview.dart';
import 'package:ehr_mobile/view/art_newOS.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class ArtOiView extends StatefulWidget{
  ArtOi artOi;
  String personId;
  bool isQuestion;
  Person person;
  HtsRegistration htsRegistration;
  String htsId;
  String visitId;
  ArtOiView(this.artOi,  this.personId, this.isQuestion, this.person, this.htsId, this.htsRegistration, this.visitId );

  @override
  State createState() {
    return ArtOiViewState();

  }
}
class ArtOiViewState extends State<ArtOiView>{
  String _picked;
  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  static const artChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile.channel/art');

  String sexualHistoryDtoId ;
  bool _artsymptom = false;

  @override
  void initState() {
    print("############### thie is the artoi sent"+ widget.artOi.toString());
    if(widget.artOi.id == null){
      _artsymptom = false;
    }else{
      _artsymptom = true;

    }
  }

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
                child: Text(widget.artOi.oi.name),
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
      if(_artsymptom == true){
        saveArtNewOi(widget.artOi);
      }
         Navigator.push(context,MaterialPageRoute(builder: (context) =>    ArtNewOI(widget.personId, widget.htsId, widget.htsRegistration, widget.visitId,widget.person)
         ));

    });
  }


  Future<void>saveArtNewOi(ArtOi artOi)async{
    var response;
    try{
      response = await artChannel.invokeMethod('saveArtNewOi', jsonEncode(artOi));
      setState(() {
        sexualHistoryDtoId = response;
      });
    }catch(e){
      print("Exception thrown in save sexualhistory dto method"+e);

    }
  }
}

