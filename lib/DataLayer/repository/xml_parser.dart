import 'package:xml/xml.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../security.dart';

class XmlProvider {
  List<Security> _loadedSecurities = [];
  bool _isInit = false;
  XmlDocument _xmlDocument;
  XmlElement _securityNodes;

  Future<List<Security>> fetchSecuritiesList() async {
    if (!_isInit) {
      _isInit = true;
      _xmlDocument = XmlDocument.parse(
          await rootBundle.loadString('assets/PortfolioPerformanceFile.xml'));
      _securityNodes =
          _xmlDocument.getElement('client').getElement('securities');
      _securityNodes.findElements('security').forEach((security) {
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
    print('before adding to xml');
    print(_securityNodes.findElements('security').length);
    _securityNodes.children.add(securityToXml(security));
    print('after adding to xml');
    print(_securityNodes.findElements('security').length);
    print(_xmlDocument
        .getElement('client')
        .getElement('securities')
        .findElements('security')
        .length);
    return;
  }

  XmlElement securityToXml(Security security) {
    final builder = XmlBuilder();
    builder.element('security', nest: () {
      builder.element('uuid', nest: () => builder.text(security.uuid));
      builder.element('name', nest: () => builder.text(security.name));
      builder.element('currencyCode',
          nest: () => builder.text(security.currencyCode));
      builder.element('note', nest: () => builder.text(security.note));
      builder.element('isin', nest: () => builder.text(security.isin));
      builder.element('tickerSymbol',
          nest: () => builder.text(security.tickerSymbol));
      builder.element('wkn', nest: () => builder.text(security.wkn));
      builder.element('feed', nest: () => builder.text(security.feed));
      builder.element('prices', nest: () {
        var placeHolderPriceList = [
          SecurityPrice(date: DateTime.now(), value: 123),
          SecurityPrice(date: DateTime.now(), value: 456),
        ];
        placeHolderPriceList
            .forEach((element) => builder.element('price', attributes: {
                  't': element.date.toString(),
                  'v': element.value.toString(),
                }));
      });
      builder.element('latestFeed',
          nest: () => builder.text(security.latestFeed));
      var placeHolderLatestPrice = LatestSecurityPrice(
        date: DateTime.now(),
        high: 100,
        low: 20,
        previousClose: 50,
        value: 80,
        volume: 123,
      );
      builder.element('latest', attributes: {
        't': placeHolderLatestPrice.date.toString(),
        'v': placeHolderLatestPrice.value.toString()
      }, nest: () {
        builder.element('high',
            nest: () => builder.text(placeHolderLatestPrice.high));
        builder.element('low',
            nest: () => builder.text(placeHolderLatestPrice.low));
        builder.element('volume',
            nest: () => builder.text(placeHolderLatestPrice.previousClose));
        builder.element('previousClose',
            nest: () =>
                builder.text(placeHolderLatestPrice.previousClose.toString()));
      });
      builder.element('attributes', nest: () => builder.element('map'));
      builder.element('events');
      builder.element('isRetired', nest: () => builder.text(false));
    });

    var securityNode = builder.build().firstElementChild.copy();
    print(securityNode.toXmlString(pretty: true));
    print(securityNode.runtimeType.toString());
    print('type');
    print(securityNode.nodeType);
    return securityNode;
  }

  XmlElement securityToXml2(Security security) {
    var securityXmlElement = XmlElement(XmlName('security'), const [], [
      XmlElement(XmlName('uuid'), const [], [XmlText('hi')]),
      XmlElement(XmlName('name'), const [], [XmlText('hu')]),
    ]);
    print('huhu');
    print(securityXmlElement.toXmlString());
    print(securityXmlElement.toString());
    return securityXmlElement;
  }
}
