import 'security.dart';

import 'xml_parser.dart';

class Repository {
  XmlProvider _provider = XmlProvider();

  Future<List<Security>> fetchSecuritiesList() =>
      _provider.fetchSecuritiesList();

  // TODO: Future<void> addSecurity() => _provider.addSecurity();
}
