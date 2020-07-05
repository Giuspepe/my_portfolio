import '../security.dart';

import 'xml_parser.dart';

class Repository {
  XmlProvider _provider = XmlProvider();

  Future<List<Security>> fetchSecuritiesList() =>
      _provider.fetchSecuritiesList();

  Future<void> addSecurity(Security security) =>
      _provider.addSecurity(security);
}
