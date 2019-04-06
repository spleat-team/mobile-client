import 'package:flutter/material.dart';

class Template extends StatelessWidget {
  final String imageAsset;
  final List<Widget> children;
  final marginTop;

  Template({@required this.imageAsset, this.children, this.marginTop});

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = getItems(context);
    return Scaffold(
        body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: children,
            )));
  }

  List<Widget> getItems(context) {
    return List.from(this.children)
      ..insert(
          0,
          Container(
              margin: marginTop != null
                  ? EdgeInsets.only(top: marginTop)
                  : EdgeInsets.all(0),
              height: 200.0,
              width: MediaQuery.of(context).size.width,
              constraints: BoxConstraints(maxWidth: 350.0),
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                image: AssetImage('assets/images/logo.png'),
              )))));
  }
}
