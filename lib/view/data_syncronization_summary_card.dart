import 'package:ehr_mobile/view/data_syncronization_summary_page.dart';
import 'package:ehr_mobile/view/add_patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class DataSyncSummaryContentCard extends StatefulWidget {
  @override
  _DataSyncSummaryContentCardState createState() => _DataSyncSummaryContentCardState();
}

class _DataSyncSummaryContentCardState extends State<DataSyncSummaryContentCard> {
  bool showInput = true;
  bool showInputTabOptions = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (!showInput) {
          setState(() {
            showInput = true;
            showInputTabOptions = true;
          });
          return Future(() => false);
        } else {
          return Future(() => true);
        }
      },
      child: new Card(
        elevation: 4.0,
        margin: const EdgeInsets.all(8.0),
        child: DefaultTabController(
          child: new LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return Column(
                children: <Widget>[
               //   _buildTabBar(),
                  _buildContentContainer(viewportConstraints),
                ],
              );
            },
          ),
          length: 3,
        ),
      ),
    );
  }

  Widget _buildTabBar({bool showFirstOption}) {
    return Stack(
      children: <Widget>[
        new Positioned.fill(
          top: null,
          child: new Container(
            height: 2.0,
            color: new Color(0xFFEEEEEE),
          ),
        ),
        new TabBar(
          tabs: [
            Tab(text: showInputTabOptions ? "" : "Price"),
            Tab(text: showInputTabOptions ? "" : "Duration"),
            Tab(text: showInputTabOptions ? "" : "Stops"),
          ],
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildContentContainer(BoxConstraints viewportConstraints) {
    return Expanded(
      child: SingleChildScrollView(
        child: new ConstrainedBox(
          constraints: new BoxConstraints(
            minHeight: viewportConstraints.maxHeight - 48.0,
          ),
          child: new IntrinsicHeight(
            //  child: showInput
            // ? _buildMulticityTab()
          ),
        ),
      ),
    );
  }

  Widget _buildMulticityTab() {
    return Column(
      children: <Widget>[
        DataSyncronizationSummary(),
        Expanded(child: Container()),
       /* Padding(
          padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
          child: FloatingActionButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddPatient()),
            ),
            child: Icon(Icons.add, size: 36.0),
          ),
        ), */
      ],
    );
  }
}
