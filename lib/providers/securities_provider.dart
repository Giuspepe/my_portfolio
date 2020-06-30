import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

import '../models/security.dart';
import '../data/dummy_xml_file.dart';

class SecuritiesProvider with ChangeNotifier {
  List<Security> _securities = [];

  List<Security> get items {
    return [..._securities];
  }

  void fetchAndSetSecuritiesList() {
    List<Security> loadedSecurities = [];

    var xmlDocument = XmlDocument.parse(DUMMY_XML_FILE);
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

    _securities = loadedSecurities;
    notifyListeners();
  }
}
