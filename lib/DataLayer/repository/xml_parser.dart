import 'package:xml/xml.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../security.dart';

class XmlProvider {
  Future<List<Security>> fetchSecuritiesList() async {
    List<Security> loadedSecurities = [];
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
      loadedSecurities.add(currentSecurity);
    });

    return loadedSecurities;
  }
}
