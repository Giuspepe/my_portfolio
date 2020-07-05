import 'dart:io';

import 'package:flutter/material.dart';

class AddSecurityForm extends StatefulWidget {
  @override
  _AddSecurityFormState createState() => _AddSecurityFormState();
}

class _AddSecurityFormState extends State<AddSecurityForm> {
  final _formKey = GlobalKey<FormState>();

  // Security parameters begin
  // String _onlineId;
  String _name;
  String _currencyCode;
  String _note;
  String _isin;
  String _tickerSymbol;
  String _wkn;
  // String _calendar;
  String _feed;
  // String _feedURL;
  // List<SecurityPrice> _prices;
  // String _latestFeed;
  // String _latestFeedUrl;
  // LatestSecurityPrice _latestPrice;
  // Map<String, Object> _attributes;
  // List<SecurityEvent> _events;
  // List<SecurityProperty> _properties;

  bool isRetired = false;
  // Security parameters end

  // void _trySubmit() {
  //   final isValid = _formKey.currentState.validate();
  //   FocusScope.of(context).unfocus();

  //   if (!_isLogin && _userImageFile == null) {
  //     Scaffold.of(context).showSnackBar(SnackBar(
  //       content: Text('Please pick an image.'),
  //       backgroundColor: Theme.of(context).errorColor,
  //     ));
  //     return;
  //   }

  // if (isValid) {
  //   return null;
  // _formKey.currentState.save();
  // widget.onSubmit(
  //   _userEmail.trim(),
  //   _userPassword,
  //   _userName.trim(),
  //   _userImageFile,
  //   _isLogin,
  //   context,
  // );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              key: ValueKey('name'),
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              enableSuggestions: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Security Name'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a valid security name.';
                }
                return null;
              },
              onSaved: (value) {
                _name = value;
              },
            ),
            DropdownButton<String>(
              key: ValueKey('currencyCode'),
              value: _currencyCode ?? 'EUR',
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  _currencyCode = newValue;
                });
              },
              items: <String>['EUR', 'USD', '...', 'usw']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextFormField(
              key: ValueKey('isin'),
              autocorrect: false,
              textCapitalization: TextCapitalization.characters,
              enableSuggestions: false,
              decoration: InputDecoration(labelText: 'ISIN'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a valid ISIN.';
                }
                return null;
              },
              onSaved: (value) {
                _isin = value;
              },
            ),
            TextFormField(
              key: ValueKey('tickerSymbol'),
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(labelText: 'Ticker Symbol'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a valid ticker symbol.';
                }
                return null;
              },
              onSaved: (value) {
                _tickerSymbol = value;
              },
            ),
            TextFormField(
              key: ValueKey('wkn'),
              obscureText: true,
              decoration: InputDecoration(labelText: 'WKN'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a valid WKN.';
                }
                return null;
              },
              onSaved: (value) {
                _wkn = value;
              },
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
