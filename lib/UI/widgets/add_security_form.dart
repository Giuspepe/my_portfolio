import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../DataLayer/currencies.dart';
import '../../BLoC/security_bloc.dart';
import '../../BLoC/events.dart';

class AddSecurityForm extends StatefulWidget {
  @override
  _AddSecurityFormState createState() => _AddSecurityFormState();
}

class _AddSecurityFormState extends State<AddSecurityForm> {
  final _formKey = GlobalKey<FormState>();

  // Security parameters begin
  // String _onlineId;
  String _name;
  String _currencyCode = 'EUR';
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

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      context.bloc<SecurityListBloc>().add(SecurityListAddEvent(
            name: _name,
            currencyCode: _currencyCode,
            isin: _isin,
            tickerSymbol: _tickerSymbol,
            wkn: _wkn,
          ));
      Navigator.of(context).pop();
      return;
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Data is incomplete or not valid.'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
                onChanged: (value) {
                  _name = value;
                },
                onSaved: (value) {
                  _name = value;
                },
              ),
              DropdownButtonFormField(
                isExpanded: true,
                key: ValueKey('currencyCode'),
                value: _currencyCode,
                decoration: InputDecoration(labelText: 'Currency'),
                onChanged: (value) {
                  _currencyCode = value;
                },
                onSaved: (value) {
                  _currencyCode = value;
                },
                items: availableCurrencyUnits.entries
                    .map((e) => DropdownMenuItem<String>(
                          child: Text(
                            '${e.value.currencyCode} - ${e.value.displayName}',
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: e.value.currencyCode,
                        ))
                    .toList(),
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
                onChanged: (value) {
                  _isin = value;
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
                onChanged: (value) {
                  _tickerSymbol = value;
                },
                onSaved: (value) {
                  _tickerSymbol = value;
                },
              ),
              TextFormField(
                key: ValueKey('wkn'),
                decoration: InputDecoration(labelText: 'WKN'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a valid WKN.';
                  }
                  return null;
                },
                onChanged: (value) {
                  _wkn = value;
                },
                onSaved: (value) {
                  _wkn = value;
                },
              ),
              SizedBox(
                height: 36,
              ),
              RaisedButton(
                child: Text(
                  'Add security',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _trySubmit,
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(),
              )
              // TODO: implement check box form field for _isRetired
            ],
          ),
        ),
      ),
    );
  }
}
