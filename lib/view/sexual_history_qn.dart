import 'dart:convert';

import 'package:ehr_mobile/model/response.dart';
import 'package:ehr_mobile/model/sexualhistorydto.dart';
import 'package:ehr_mobile/model/sexualhistoryview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class SexualHistoryQuestionView extends StatefulWidget{
  SexualHistoryView sexualHistoryView;
  String sexualHistoryId;
  Response question;
  String personId;
  SexualHistoryQuestionView(this.sexualHistoryView, this.sexualHistoryId, this.personId);

  @override
  State createState() {
    return SexulahistoryState();

  }
}
class SexulahistoryState extends State<SexualHistoryQuestionView>{
  String _picked;
  static const htsChannel =
  MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  String sexualHistoryDtoId ;
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
                child: Text(widget.sexualHistoryView.question.name),
              ),
              width: 250,
            ),
          ),
          RadioButtonGroup(
            orientation: GroupedButtonsOrientation.HORIZONTAL,
            margin: const EdgeInsets.only(left: 12.0),
            onSelected: (String selected) => setState(() {
              _picked = selected;
              print(">>>>>>>" + _picked);
              widget.sexualHistoryView.question.responseType = _picked;
              Response _response = Response('', '', widget.sexualHistoryView.question.responseType);
              SexualHistoryDto sexualHistorydto = SexualHistoryDto(widget.personId, widget.sexualHistoryId, _response);
              saveSexualHistoryDto(sexualHistorydto);
            }),
            labels: <String>[
              "YES",
              "NO",
              "REFUSED"
            ],
            picked: _picked,
            itemBuilder: (Radio rb, Text txt, int i) {
              return Row(
                children: <Widget>[
                  rb,
                  txt,
                ],
              );
            },
          )
        ],
      ),
    );

  }

  Future<void>saveSexualHistoryDto(SexualHistoryDto sexualHistoryview)async{
    var response;
    try{
    response = htsChannel.invokeMethod('saveSexualHistoryDto', jsonEncode(sexualHistoryview));
    setState(() {
      sexualHistoryDtoId = response;
      print(">>>>>>>>>>>> sexual history id returned" + sexualHistoryDtoId);
    });
    }catch(e){
      print("Exception thrown in save sexualhistory dto method");

    }
  }
}