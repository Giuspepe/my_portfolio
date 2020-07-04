import 'package:flutter/foundation.dart';

import '../DataLayer/security.dart';

abstract class SecurityListEvent {}

class SecurityListAddedEvent extends SecurityListEvent {
  final Security addedSecurity;
  SecurityListAddedEvent({@required this.addedSecurity})
      : assert(addedSecurity != null);
}

class SecurityListFetchEvent extends SecurityListEvent {}
