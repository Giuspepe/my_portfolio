import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';
import 'package:xml/xml.dart';
import 'package:intl/intl.dart';

class Security {
  String uuid = Uuid().v4();
  String onlineId;

  String name;
  String currencyCode;

  String note;

  String isin;
  String tickerSymbol;
  String wkn;
  String calendar;

  String feed;
  String feedURL;
  List<SecurityPrice> prices;

  String latestFeed;
  String latestFeedUrl;
  LatestSecurityPrice latestPrice;

  Map<String, Object> attributes;

  List<SecurityEvent> events;
  List<SecurityProperty> properties;

  bool isRetired = false;

  Security({
    this.uuid,
    this.onlineId,
    @required this.name,
    this.currencyCode,
    this.note,
    this.isin,
    this.tickerSymbol,
    this.wkn,
    this.calendar,
    this.feed,
    this.feedURL,
    this.prices,
    this.latestFeed,
    this.latestFeedUrl,
    this.latestPrice,
    this.attributes,
    this.events,
    this.properties,
  });
}

class SecurityPrice {
  DateTime date;
  int value;

  SecurityPrice({this.date, this.value});
}

class LatestSecurityPrice extends SecurityPrice {
  int high;
  int low;
  int volume;

  int previousClose;

  var _dateFormatter = DateFormat('yyyy-MM-dd');

  LatestSecurityPrice({
    this.high,
    this.low,
    this.volume,
    this.previousClose,
    DateTime date,
    int value,
  }) : super(date: date, value: value);

  LatestSecurityPrice.fromXmlNode(XmlElement latestSecurityPriceNode) {
    if (latestSecurityPriceNode != null) {
      try {
        high = int.parse(latestSecurityPriceNode.getElement('high').text);
        low = int.parse(latestSecurityPriceNode.getElement('low').text);
        volume = int.parse(latestSecurityPriceNode.getElement('volume').text);
        previousClose =
            int.parse(latestSecurityPriceNode.getElement('previousClose').text);

        date = _dateFormatter.parse(latestSecurityPriceNode.getAttribute('t'));
        value = int.parse(latestSecurityPriceNode.getAttribute('v'));
      } catch (error) {
        throw (error);
      }
    }
  }
}

enum SecurityEventType { STOCK_SPLIT, NOTE }

class SecurityEvent {
  DateTime date;
  SecurityEventType type;
  String details;

  SecurityEvent({this.date, this.type, this.details});
}

enum SecurityPropertyType { MARKET, FEED }

class SecurityProperty {
  SecurityPropertyType type;
  String name;
  String value;

  SecurityProperty({this.type, this.name, this.value});
}
