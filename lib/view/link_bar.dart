import 'package:flutter/material.dart';

class LinkBarItems extends StatelessWidget {
  final String text;
  final bool selected;
  final GestureTapCallback onTap;

  const LinkBarItems({Key key, this.text, this.selected = false, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = selected ? Colors.white : Colors.transparent;
    Color textColor = selected ? Colors.blue : Colors.black;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: new InkWell(
          onTap: onTap,
          child: new Container(
            height: 36.0,
            child: new Center(
              child: new Text(
                text, style: new TextStyle(color: textColor, ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
