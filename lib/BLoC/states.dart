import 'package:flutter/foundation.dart';

import '../DataLayer/security.dart';

abstract class SecurityListState {}

class SecurityListUninitializedState extends SecurityListState {}

class SecurityListFetchingState extends SecurityListState {}

class SecurityListFetchedState extends SecurityListState {
  final List<Security> securities;
  SecurityListFetchedState({@required this.securities});
}

class SecurityListErrorState extends SecurityListState {}
