import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/securities_screen.dart';
import 'providers/securities_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: SecuritiesProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Portfolio',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SecuritiesScreen(),
        routes: {},
      ),
    );
  }
}
