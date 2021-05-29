import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:getx_ecosystem_trial/app/data/models/corona_hotspot_model.dart';
import 'package:getx_ecosystem_trial/app/data/models/crowd_hotspot_model.dart';
part 'hotspot_model.freezed.dart';
part 'hotspot_model.g.dart';

@freezed
class HotspotModel with _$HotspotModel {
  const factory HotspotModel({
    required List<CoronaHotspotModel> coronaHotspot,
    required List<CrowdHotspotModel> crowdHotspot,
  }) = _HotspotModel;

  factory HotspotModel.fromJson(Map<String, dynamic> json) =>
      _$HotspotModelFromJson(json);
}
