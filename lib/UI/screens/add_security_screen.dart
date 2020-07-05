import 'package:flutter/material.dart';

import '../widgets/add_security_form.dart';
import '../widgets/side_drawer.dart';
import '../widgets/add_security_form.dart';

class AddSecurityScreen extends StatefulWidget {
  static const routeName = '/securities/add';

  @override
  _AddSecurityScreenState createState() => _AddSecurityScreenState();
}

class _AddSecurityScreenState extends State<AddSecurityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Security'),
      ),
      drawer: SideDrawer(),
      body: AddSecurityForm(),
    );
  }
}
