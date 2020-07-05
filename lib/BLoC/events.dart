import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import '../DataLayer/security.dart';

abstract class SecurityListEvent extends Equatable {}

class SecurityListAddEvent extends SecurityListEvent {
  final String name;
  final String currencyCode;
  final String isin;
  final String tickerSymbol;
  final String wkn;

  SecurityListAddEvent({
    @required this.name,
    @required this.currencyCode,
    @required this.isin,
    @required this.tickerSymbol,
    @required this.wkn,
  })  : assert(name != null),
        assert(currencyCode != null),
        assert(isin != null),
        assert(tickerSymbol != null),
        assert(wkn != null);

  @override
  List<Object> get props => [name, currencyCode, isin, tickerSymbol, wkn];
}

class SecurityListFetchEvent extends SecurityListEvent {
  @override
  List<Object> get props => const [];
}
