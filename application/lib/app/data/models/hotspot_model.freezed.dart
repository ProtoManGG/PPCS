// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'hotspot_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

HotspotModel _$HotspotModelFromJson(Map<String, dynamic> json) {
  return _HotspotModel.fromJson(json);
}

/// @nodoc
class _$HotspotModelTearOff {
  const _$HotspotModelTearOff();

  _HotspotModel call(
      {required List<CoronaHotspotModel> coronaHotspot,
      required List<CrowdHotspotModel> crowdHotspot}) {
    return _HotspotModel(
      coronaHotspot: coronaHotspot,
      crowdHotspot: crowdHotspot,
    );
  }

  HotspotModel fromJson(Map<String, Object> json) {
    return HotspotModel.fromJson(json);
  }
}

/// @nodoc
const $HotspotModel = _$HotspotModelTearOff();

/// @nodoc
mixin _$HotspotModel {
  List<CoronaHotspotModel> get coronaHotspot =>
      throw _privateConstructorUsedError;
  List<CrowdHotspotModel> get crowdHotspot =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HotspotModelCopyWith<HotspotModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HotspotModelCopyWith<$Res> {
  factory $HotspotModelCopyWith(
          HotspotModel value, $Res Function(HotspotModel) then) =
      _$HotspotModelCopyWithImpl<$Res>;
  $Res call(
      {List<CoronaHotspotModel> coronaHotspot,
      List<CrowdHotspotModel> crowdHotspot});
}

/// @nodoc
class _$HotspotModelCopyWithImpl<$Res> implements $HotspotModelCopyWith<$Res> {
  _$HotspotModelCopyWithImpl(this._value, this._then);

  final HotspotModel _value;
  // ignore: unused_field
  final $Res Function(HotspotModel) _then;

  @override
  $Res call({
    Object? coronaHotspot = freezed,
    Object? crowdHotspot = freezed,
  }) {
    return _then(_value.copyWith(
      coronaHotspot: coronaHotspot == freezed
          ? _value.coronaHotspot
          : coronaHotspot // ignore: cast_nullable_to_non_nullable
              as List<CoronaHotspotModel>,
      crowdHotspot: crowdHotspot == freezed
          ? _value.crowdHotspot
          : crowdHotspot // ignore: cast_nullable_to_non_nullable
              as List<CrowdHotspotModel>,
    ));
  }
}

/// @nodoc
abstract class _$HotspotModelCopyWith<$Res>
    implements $HotspotModelCopyWith<$Res> {
  factory _$HotspotModelCopyWith(
          _HotspotModel value, $Res Function(_HotspotModel) then) =
      __$HotspotModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<CoronaHotspotModel> coronaHotspot,
      List<CrowdHotspotModel> crowdHotspot});
}

/// @nodoc
class __$HotspotModelCopyWithImpl<$Res> extends _$HotspotModelCopyWithImpl<$Res>
    implements _$HotspotModelCopyWith<$Res> {
  __$HotspotModelCopyWithImpl(
      _HotspotModel _value, $Res Function(_HotspotModel) _then)
      : super(_value, (v) => _then(v as _HotspotModel));

  @override
  _HotspotModel get _value => super._value as _HotspotModel;

  @override
  $Res call({
    Object? coronaHotspot = freezed,
    Object? crowdHotspot = freezed,
  }) {
    return _then(_HotspotModel(
      coronaHotspot: coronaHotspot == freezed
          ? _value.coronaHotspot
          : coronaHotspot // ignore: cast_nullable_to_non_nullable
              as List<CoronaHotspotModel>,
      crowdHotspot: crowdHotspot == freezed
          ? _value.crowdHotspot
          : crowdHotspot // ignore: cast_nullable_to_non_nullable
              as List<CrowdHotspotModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HotspotModel implements _HotspotModel {
  const _$_HotspotModel(
      {required this.coronaHotspot, required this.crowdHotspot});

  factory _$_HotspotModel.fromJson(Map<String, dynamic> json) =>
      _$_$_HotspotModelFromJson(json);

  @override
  final List<CoronaHotspotModel> coronaHotspot;
  @override
  final List<CrowdHotspotModel> crowdHotspot;

  @override
  String toString() {
    return 'HotspotModel(coronaHotspot: $coronaHotspot, crowdHotspot: $crowdHotspot)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HotspotModel &&
            (identical(other.coronaHotspot, coronaHotspot) ||
                const DeepCollectionEquality()
                    .equals(other.coronaHotspot, coronaHotspot)) &&
            (identical(other.crowdHotspot, crowdHotspot) ||
                const DeepCollectionEquality()
                    .equals(other.crowdHotspot, crowdHotspot)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(coronaHotspot) ^
      const DeepCollectionEquality().hash(crowdHotspot);

  @JsonKey(ignore: true)
  @override
  _$HotspotModelCopyWith<_HotspotModel> get copyWith =>
      __$HotspotModelCopyWithImpl<_HotspotModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_HotspotModelToJson(this);
  }
}

abstract class _HotspotModel implements HotspotModel {
  const factory _HotspotModel(
      {required List<CoronaHotspotModel> coronaHotspot,
      required List<CrowdHotspotModel> crowdHotspot}) = _$_HotspotModel;

  factory _HotspotModel.fromJson(Map<String, dynamic> json) =
      _$_HotspotModel.fromJson;

  @override
  List<CoronaHotspotModel> get coronaHotspot =>
      throw _privateConstructorUsedError;
  @override
  List<CrowdHotspotModel> get crowdHotspot =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$HotspotModelCopyWith<_HotspotModel> get copyWith =>
      throw _privateConstructorUsedError;
}
