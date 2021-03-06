import '../../DataLayer/security.dart';
import 'package:flutter/material.dart';

class SecurityListTile extends StatelessWidget {
  final Security security;
  final String info;

  SecurityListTile(this.security)
      : info = security.latestPrice == null
            ? 'no latest price info'
            : security.latestPrice.value == null
                ? 'latest price info, but no value field'
                : '${(security.latestPrice.value / 10000.0).toStringAsFixed(2)} €';

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.business),
      title: Text(security.name),
      subtitle: Text(info),
      trailing: Icon(Icons.more_vert),
    );
  }
}
