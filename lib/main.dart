import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'DataLayer/repository/repository.dart';

import 'BLoC/security_bloc.dart';

import 'UI/screens/securities_screen.dart';
import 'UI/screens/add_security_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SecurityListBloc(repository: Repository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Portfolio',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SecuritiesScreen(),
        routes: {AddSecurityScreen.routeName: (ctx) => AddSecurityScreen()},
      ),
    );
  }
}
