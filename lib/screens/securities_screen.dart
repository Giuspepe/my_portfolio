import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/side_drawer.dart';
import '../widgets/security_list_tile.dart';
import '../providers/securities_provider.dart';

class SecuritiesScreen extends StatefulWidget {
  static const routeName = '/securities';

  @override
  _SecuritiesScreenState createState() => _SecuritiesScreenState();
}

class _SecuritiesScreenState extends State<SecuritiesScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      Provider.of<SecuritiesProvider>(context, listen: false)
          .fetchAndSetSecuritiesList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var securitiesList = Provider.of<SecuritiesProvider>(context).items;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Portfolio'),
      ),
      drawer: SideDrawer(),
      body: ListView.builder(
        itemCount: securitiesList.length,
        itemBuilder: (ctx, i) {
          return SecurityListTile(securitiesList[i]);
        },
      ),
    );
  }
}
