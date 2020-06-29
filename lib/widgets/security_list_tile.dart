import 'package:flutter/material.dart';

class SecurityListTile extends StatelessWidget {
  final IconData icon;
  final String name;
  final String info;

  SecurityListTile({
    @required this.icon,
    @required this.name,
    @required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      subtitle: Text(info),
      trailing: Icon(Icons.more_vert),
    );
  }
}
