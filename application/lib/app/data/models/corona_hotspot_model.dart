import 'package:freezed_annotation/freezed_annotation.dart';
part 'corona_hotspot_model.freezed.dart';
part 'corona_hotspot_model.g.dart';

@freezed
class CoronaHotspotModel with _$CoronaHotspotModel {
  const factory CoronaHotspotModel({
    required double lat,
    required double long,
    required int death,
    required int active,
    required int recovered,
  }) = _CoronaHotspotModel;

  factory CoronaHotspotModel.fromJson(Map<String, dynamic> json) =>
      _$CoronaHotspotModelFromJson(json);
}
