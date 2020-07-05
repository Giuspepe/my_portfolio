import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';

import '../DataLayer/repository/repository.dart';
import '../DataLayer/security.dart';

import 'events.dart';
import 'states.dart';

class SecurityListBloc extends Bloc<SecurityListEvent, SecurityListState> {
  Repository repository;
  SecurityListBloc({@required this.repository})
      : assert(repository != null),
        super(initialState);

  @override
  void onTransition(
      Transition<SecurityListEvent, SecurityListState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  static SecurityListState get initialState => SecurityListUninitializedState();

  @override
  Stream<SecurityListState> mapEventToState(SecurityListEvent event) async* {
    try {
      if (event is SecurityListFetchEvent) {
        yield SecurityListFetchingState();
        yield SecurityListFetchedState(
            securities: await repository.fetchSecuritiesList());
      } else if (event is SecurityListAddEvent) {
        yield SecurityListAddingState();
        repository.addSecurity(
          Security(
            name: event.name,
            currencyCode: event.currencyCode,
            isin: event.isin,
            tickerSymbol: event.tickerSymbol,
            wkn: event.wkn,
          ),
        );
        yield SecurityListAddedState();
      }
    } catch (error) {
      yield SecurityListErrorState();
      throw error;
    }
  }
}
