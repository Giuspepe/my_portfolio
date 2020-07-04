import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('My Portfolio'),
            automaticallyImplyLeading: false,
          ),
          Text(
            'Wertpapiere',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            textAlign: TextAlign.left,
          ),
          ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text('Alle Wertpapiere'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.keyboard_capslock),
            title: Text('Indizes'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
