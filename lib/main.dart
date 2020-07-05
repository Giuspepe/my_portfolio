import 'package:flutter/material.dart';

import 'UI/screens/securities_screen.dart';
import 'UI/screens/add_security_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Portfolio',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SecuritiesScreen(),
      routes: {AddSecurityScreen.routeName: (ctx) => AddSecurityScreen()},
    );
  }
}
