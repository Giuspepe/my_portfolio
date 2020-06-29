import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

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

  LatestSecurityPrice({
    this.high,
    this.low,
    this.volume,
    DateTime date,
    int value,
  }) : super(date: date, value: value);
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
