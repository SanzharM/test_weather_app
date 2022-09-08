import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:test_weather_app/Library/utilities/utils.dart';

class Weather {
  final double? lat;
  final double? lng;
  final List<DateTime>? hours;
  final List<double>? temperatures;
  final String? units;

  const Weather({
    this.lat,
    this.lng,
    this.hours,
    this.temperatures,
    this.units,
  });

  Weather copyWith({
    double? lat,
    double? lng,
    List<DateTime>? hours,
    List<double>? temperatures,
    String? units,
  }) {
    return Weather(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      hours: hours ?? this.hours,
      temperatures: temperatures ?? this.temperatures,
      units: units ?? this.units,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (lat != null) {
      result.addAll({'lat': lat});
    }
    if (lng != null) {
      result.addAll({'lng': lng});
    }
    if (hours != null) {
      result.addAll({'hours': hours!.map((x) => x.millisecondsSinceEpoch).toList()});
    }
    if (temperatures != null) {
      result.addAll({'temperatures': temperatures});
    }
    if (units != null) {
      result.addAll({'units': units});
    }

    return result;
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    List<DateTime>? hours;
    if (map['hourly']?['time'] != null) {
      final rawHours = map['hourly']['time'] as List;
      hours = rawHours.map((e) => Utils.parseDate(e, format: 'yyyy-MM-ddTHH:mm') ?? DateTime.now()).toList();
    }

    return Weather(
      lat: map['latitude']?.toDouble(),
      lng: map['longitude']?.toDouble(),
      hours: hours,
      temperatures: map['temperature_2m'] != null ? List<double>.from(map['temperature_2m']) : null,
      units: map['hourly_units']?['temperature_2m'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Weather.fromJson(String source) => Weather.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Weather(lat: $lat, lng: $lng, hours: $hours, temperatures: $temperatures, units: $units)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Weather &&
        other.lat == lat &&
        other.lng == lng &&
        listEquals(other.hours, hours) &&
        listEquals(other.temperatures, temperatures) &&
        other.units == units;
  }

  @override
  int get hashCode {
    return lat.hashCode ^ lng.hashCode ^ hours.hashCode ^ temperatures.hashCode ^ units.hashCode;
  }
}
