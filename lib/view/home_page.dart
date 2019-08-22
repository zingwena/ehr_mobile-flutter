import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textController = TextEditingController();

  final List<String> _listViewData = [
    "Thomas Moyo  |   Male  |  01/10/1991  |  63453693 V16  |"  ,
    "Natasha Mokina  |  Female  |  27/03/1994  |  7584932 V34  |",

  ];

  List<String> _newData = [];

  _onChanged(String value) {
    setState(() {
      _newData = _listViewData
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* appBar: AppBar(
        title: Text('Welcome : Search Patient'),
      ),*/
      body: Column(
        children: <Widget>[
          SizedBox(height: 15.0),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Search Patient',
                labelText: "Search Patient",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _onChanged,
            ),
          ),
          SizedBox(height: 20.0),
          _newData != null && _newData.length != 0
              ? Expanded(
            child: ListView(
              padding: EdgeInsets.all(10.0),
              children: _newData.map((data) {
                return ListTile(title: Text(data));
              }).toList(),
            ),
          )
              : SizedBox(),
        ],
      ),
    );
  }
}