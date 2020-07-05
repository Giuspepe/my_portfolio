import 'package:xml/xml.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../security.dart';

class XmlProvider {
  List<Security> _loadedSecurities = [];
  bool _isInit = false;

  Future<List<Security>> fetchSecuritiesList() async {
    if (!_isInit) {
      _isInit = true;
      var xmlDocument = XmlDocument.parse(
          await rootBundle.loadString('assets/PortfolioPerformanceFile.xml'));
      var securityNodes =
          xmlDocument.getElement('client').getElement('securities');
      securityNodes.findElements('security').forEach((security) {
        var currentSecurity = Security(
          name: security.getElement('name').text,
          latestPrice:
              LatestSecurityPrice.fromXmlNode(security.getElement('latest')),
        );
        _loadedSecurities.add(currentSecurity);
      });
    }

    return [..._loadedSecurities];
  }

  Future<void> addSecurity(Security security) async {
    // add security to state
    _loadedSecurities.add(security);
    // TODO: add security to xml
    return;
  }
}
