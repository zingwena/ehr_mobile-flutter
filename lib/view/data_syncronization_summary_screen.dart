import 'package:ehr_mobile/view/rounded_button.dart';
import 'package:ehr_mobile/view/data_syncronization_summary_bar.dart';
import 'package:ehr_mobile/view/data_syncronization_summary_card.dart';
import 'package:flutter/material.dart';

class DataSyncScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          DataSyncBar(height: 210.0),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 40.0),
              child: new Column(
                children: <Widget>[
                 // _buildButtonsRow(),
                  Expanded(child: DataSyncSummaryContentCard()),
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
          new RoundedButton(text: "VITALS"),
          new RoundedButton(text: "HTS"),
          new RoundedButton(text: "ART", onTap: () {}, ),
        ],
      ),
    );
  } */
}
