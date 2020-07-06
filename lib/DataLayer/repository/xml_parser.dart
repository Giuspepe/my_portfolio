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
        var currentSecurity = xmlToSecurity(security);
        _loadedSecurities.add(currentSecurity);
      });
    }

    return [..._loadedSecurities];
  }

  Future<void> addSecurity(Security security) async {
    // add security to state
    _loadedSecurities.add(security);
    // add security to xml
    _securityNodes.children.add(securityToXml(security));
    // TODO: save xml persistently
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
            nest: () => builder.text(placeHolderLatestPrice.previousClose));
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

  // TODO: move this function to security.dart -> Security.fromXmlElement ?
  Security xmlToSecurity(XmlElement xmlSecurity) {
    // TODO: throw error
    assert(xmlSecurity.name.qualified == 'security');

    String textFromXmlChild(String childElementName) {
      XmlElement child = xmlSecurity.getElement(childElementName);
      return child != null ? child.text : null;
    }

    String uuid = textFromXmlChild('uuid');
    String name = textFromXmlChild('name');
    String currencyCode = textFromXmlChild('currencyCode');
    String note = textFromXmlChild('note');
    String isin = textFromXmlChild('isin');
    String tickerSymbol = textFromXmlChild('tickerSymbol');
    String wkn = textFromXmlChild('wkn');
    String feed = textFromXmlChild('feed');

    List<SecurityPrice> prices = xmlSecurity
        .getElement('prices')
        .findElements('price')
        .map(
          (xmlPrice) => SecurityPrice(
            date: SecurityPrice.dateFormatter.parse(xmlPrice.getAttribute('t')),
            value: int.parse(xmlPrice.getAttribute('v')),
          ),
        )
        .toList();

    String latestFeed = textFromXmlChild('latestFeed');

    XmlElement xmlLatestPrice = xmlSecurity.getElement('latest');
    LatestSecurityPrice latest = xmlLatestPrice != null
        ? LatestSecurityPrice(
            date: SecurityPrice.dateFormatter
                .parse(xmlLatestPrice.getAttribute('t')),
            value: int.parse(xmlLatestPrice.getAttribute('v')),
            high: int.parse(xmlLatestPrice.getElement('high').text),
            low: int.parse(xmlLatestPrice.getElement('low').text),
            volume: int.parse(xmlLatestPrice.getElement('volume').text),
            previousClose:
                int.parse(xmlLatestPrice.getElement('previousClose').text),
          )
        : null;

    // TODO: attributes and events
    Map<String, Object> attributes =
        {}; //xmlSecurity.getElement('attributes').text;
    List<SecurityEvent> events = []; //xmlSecurity.getElement('events').text;
    List<SecurityProperty> properties;
    bool isRetired = 'true' == textFromXmlChild('isRetired');

    return Security(
      uuid: uuid,
      onlineId: null, // TODO: onlineId,
      name: name,
      currencyCode: currencyCode,
      note: note,
      isin: isin,
      tickerSymbol: tickerSymbol,
      wkn: wkn,
      calendar: null, // TODO: calendar,
      feed: feed,
      feedURL: null, // TODO: feedURL,
      prices: prices,
      latestFeed: latestFeed,
      latestFeedUrl: null, // TODO: latestFeedUrl,
      latestPrice: null, // TODO:latestPrice,
      attributes: attributes,
      events: events,
      properties: properties,
      isRetired: isRetired,
    );
  }
}
