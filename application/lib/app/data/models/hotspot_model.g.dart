// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotspot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HotspotModel _$_$_HotspotModelFromJson(Map<String, dynamic> json) {
  return _$_HotspotModel(
    coronaHotspot: (json['coronaHotspot'] as List<dynamic>)
        .map((e) => CoronaHotspotModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    crowdHotspot: (json['crowdHotspot'] as List<dynamic>)
        .map((e) => CrowdHotspotModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_HotspotModelToJson(_$_HotspotModel instance) =>
    <String, dynamic>{
      'coronaHotspot': instance.coronaHotspot,
      'crowdHotspot': instance.crowdHotspot,
    };
