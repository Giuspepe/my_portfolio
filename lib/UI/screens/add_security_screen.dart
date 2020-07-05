import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../BLoC/security_bloc.dart';
import '../../BLoC/states.dart';

import '../widgets/add_security_form.dart';

class AddSecurityScreen extends StatefulWidget {
  static const routeName = '/securities/add';

  @override
  _AddSecurityScreenState createState() => _AddSecurityScreenState();
}

class _AddSecurityScreenState extends State<AddSecurityScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecurityListBloc, SecurityListState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Add Security'),
          ),
          body: AddSecurityForm(),
        );
      },
    );
  }
}
