// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'crowd_hotspot_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CrowdHotspotModel _$CrowdHotspotModelFromJson(Map<String, dynamic> json) {
  return _CrowdHostpotModel.fromJson(json);
}

/// @nodoc
class _$CrowdHotspotModelTearOff {
  const _$CrowdHotspotModelTearOff();

  _CrowdHostpotModel call({required double lat, required double long}) {
    return _CrowdHostpotModel(
      lat: lat,
      long: long,
    );
  }

  CrowdHotspotModel fromJson(Map<String, Object> json) {
    return CrowdHotspotModel.fromJson(json);
  }
}

/// @nodoc
const $CrowdHotspotModel = _$CrowdHotspotModelTearOff();

/// @nodoc
mixin _$CrowdHotspotModel {
  double get lat => throw _privateConstructorUsedError;
  double get long => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CrowdHotspotModelCopyWith<CrowdHotspotModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CrowdHotspotModelCopyWith<$Res> {
  factory $CrowdHotspotModelCopyWith(
          CrowdHotspotModel value, $Res Function(CrowdHotspotModel) then) =
      _$CrowdHotspotModelCopyWithImpl<$Res>;
  $Res call({double lat, double long});
}

/// @nodoc
class _$CrowdHotspotModelCopyWithImpl<$Res>
    implements $CrowdHotspotModelCopyWith<$Res> {
  _$CrowdHotspotModelCopyWithImpl(this._value, this._then);

  final CrowdHotspotModel _value;
  // ignore: unused_field
  final $Res Function(CrowdHotspotModel) _then;

  @override
  $Res call({
    Object? lat = freezed,
    Object? long = freezed,
  }) {
    return _then(_value.copyWith(
      lat: lat == freezed
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      long: long == freezed
          ? _value.long
          : long // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$CrowdHostpotModelCopyWith<$Res>
    implements $CrowdHotspotModelCopyWith<$Res> {
  factory _$CrowdHostpotModelCopyWith(
          _CrowdHostpotModel value, $Res Function(_CrowdHostpotModel) then) =
      __$CrowdHostpotModelCopyWithImpl<$Res>;
  @override
  $Res call({double lat, double long});
}

/// @nodoc
class __$CrowdHostpotModelCopyWithImpl<$Res>
    extends _$CrowdHotspotModelCopyWithImpl<$Res>
    implements _$CrowdHostpotModelCopyWith<$Res> {
  __$CrowdHostpotModelCopyWithImpl(
      _CrowdHostpotModel _value, $Res Function(_CrowdHostpotModel) _then)
      : super(_value, (v) => _then(v as _CrowdHostpotModel));

  @override
  _CrowdHostpotModel get _value => super._value as _CrowdHostpotModel;

  @override
  $Res call({
    Object? lat = freezed,
    Object? long = freezed,
  }) {
    return _then(_CrowdHostpotModel(
      lat: lat == freezed
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      long: long == freezed
          ? _value.long
          : long // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CrowdHostpotModel implements _CrowdHostpotModel {
  const _$_CrowdHostpotModel({required this.lat, required this.long});

  factory _$_CrowdHostpotModel.fromJson(Map<String, dynamic> json) =>
      _$_$_CrowdHostpotModelFromJson(json);

  @override
  final double lat;
  @override
  final double long;

  @override
  String toString() {
    return 'CrowdHotspotModel(lat: $lat, long: $long)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CrowdHostpotModel &&
            (identical(other.lat, lat) ||
                const DeepCollectionEquality().equals(other.lat, lat)) &&
            (identical(other.long, long) ||
                const DeepCollectionEquality().equals(other.long, long)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(lat) ^
      const DeepCollectionEquality().hash(long);

  @JsonKey(ignore: true)
  @override
  _$CrowdHostpotModelCopyWith<_CrowdHostpotModel> get copyWith =>
      __$CrowdHostpotModelCopyWithImpl<_CrowdHostpotModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CrowdHostpotModelToJson(this);
  }
}

abstract class _CrowdHostpotModel implements CrowdHotspotModel {
  const factory _CrowdHostpotModel(
      {required double lat, required double long}) = _$_CrowdHostpotModel;

  factory _CrowdHostpotModel.fromJson(Map<String, dynamic> json) =
      _$_CrowdHostpotModel.fromJson;

  @override
  double get lat => throw _privateConstructorUsedError;
  @override
  double get long => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CrowdHostpotModelCopyWith<_CrowdHostpotModel> get copyWith =>
      throw _privateConstructorUsedError;
}
