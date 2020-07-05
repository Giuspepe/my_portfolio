import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

import '../DataLayer/security.dart';

abstract class SecurityListEvent extends Equatable {}

class SecurityListAddedEvent extends SecurityListEvent {
  final Security addedSecurity;
  SecurityListAddedEvent({@required this.addedSecurity})
      : assert(addedSecurity != null);

  @override
  List<Object> get props => [addedSecurity];
}

class SecurityListFetchEvent extends SecurityListEvent {
  @override
  List<Object> get props => const [];
}
