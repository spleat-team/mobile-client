import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './screens/Home.dart';
import './screens/Login.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //making list of pages needed to pass in IntroViewsFlutter constructor.
  final pages = [
    PageViewModel(
        pageColor: const Color.fromRGBO(22, 168, 181, 0.5),
        bubble: Image.asset('assets/intro/scan.png'),
        body: Text(
          'Scan the receipt',
        ),
        title: Text(''),
        textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        mainImage: Image.asset(
          'assets/intro/scan.png',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
    PageViewModel(
      pageColor: const Color.fromRGBO(251, 183, 19, 0.5),
      iconImageAssetPath: 'assets/intro/select.png',
      body: Text(
        "Select what you've eaten",
      ),
      title: Text(''),
      mainImage: Image.asset(
        'assets/intro/select.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
    PageViewModel(
      pageColor: const Color.fromRGBO(149, 193, 61, 0.5),
      iconImageAssetPath: 'assets/intro/done.png',
      body: Text(
        'Enjoy your stay!',
      ),
      title: Text(''),
      mainImage: Image.asset(
        'assets/intro/done.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Spleat',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home: _handleCurrentScreen());
        home: Builder(
          builder: (context) =>
              IntroViewsFlutter(
                pages,
                showNextButton: true,
                showBackButton: true,
                fullTransition: 250,
                onTapDoneButton: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => _handleCurrentScreen()
                    ),
                  );
                },
                pageButtonTextStyles: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ), //IntroViewsFlutter
        ) //Builder
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

Widget _handleCurrentScreen() {
  return Scaffold(
      body: new StreamBuilder<FirebaseUser>(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return new Center(child: new CircularProgressIndicator());
            } else {
              if (snapshot.hasData) {
                return new HomePage();
              }

              // return login
              return new LoginPage();
            }
          }));
}
