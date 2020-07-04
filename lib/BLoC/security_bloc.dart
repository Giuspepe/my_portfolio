import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';

import '../DataLayer/repository.dart';

import 'events.dart';
import 'states.dart';

class SecurityListBloc extends Bloc<SecurityListEvent, SecurityListState> {
  final Repository repository;
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
    print('mapeventtostate $event');
    try {
      if (event is SecurityListFetchEvent) {
        yield SecurityListFetchingState();
      }
      yield SecurityListFetchedState(
          securities: await repository.fetchSecuritiesList());
    } catch (error) {
      yield SecurityListErrorState();
      throw error;
    }
  }
}
