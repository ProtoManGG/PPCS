import 'package:freezed_annotation/freezed_annotation.dart';
part 'crowd_hotspot_model.freezed.dart';
part 'crowd_hotspot_model.g.dart';

@freezed
class CrowdHotspotModel with _$CrowdHotspotModel {
  const factory CrowdHotspotModel({
    required double lat,
    required double long,
  }) = _CrowdHostpotModel;

  factory CrowdHotspotModel.fromJson(Map<String, dynamic> json) =>
      _$CrowdHotspotModelFromJson(json);
}
