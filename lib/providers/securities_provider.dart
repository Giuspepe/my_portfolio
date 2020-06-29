import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

import '../models/security.dart';
import '../data/dummy_xml_file.dart';

class SecuritiesProvider with ChangeNotifier {
  List<Security> _securities = [];

  List<Security> get items {
    return [..._securities];
  }

  Future<void> fetchAndSetSecuritiesList() async {
    List<Security> loadedSecurities = [];

    var xml_document = XmlDocument.parse(DUMMY_XML_FILE);
    var security_nodes =
        xml_document.getElement('client').getElement('securities');
    security_nodes.findElements('security').forEach((security) {
      var currentSecurity = Security(name: security.getElement('name').text);
      loadedSecurities.add(currentSecurity);
    });

    _securities = loadedSecurities;
    notifyListeners();
  }
}
