import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

import '../DataLayer/security.dart';

abstract class SecurityListState extends Equatable {}

class SecurityListUninitializedState extends SecurityListState {
  @override
  List<Object> get props => const [];
}

class SecurityListFetchingState extends SecurityListState {
  @override
  List<Object> get props => const [];
}

class SecurityListFetchedState extends SecurityListState {
  final List<Security> securities;
  SecurityListFetchedState({@required this.securities});

  @override
  List<Object> get props => [securities];
}

class SecurityListErrorState extends SecurityListState {
  @override
  List<Object> get props => const [];
}
