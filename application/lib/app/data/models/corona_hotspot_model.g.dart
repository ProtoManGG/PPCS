// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corona_hotspot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CoronaHotspotModel _$_$_CoronaHotspotModelFromJson(
    Map<String, dynamic> json) {
  return _$_CoronaHotspotModel(
    lat: (json['lat'] as num).toDouble(),
    long: (json['long'] as num).toDouble(),
    death: json['death'] as int,
    active: json['active'] as int,
    recovered: json['recovered'] as int,
  );
}

Map<String, dynamic> _$_$_CoronaHotspotModelToJson(
        _$_CoronaHotspotModel instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'long': instance.long,
      'death': instance.death,
      'active': instance.active,
      'recovered': instance.recovered,
    };
