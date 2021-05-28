// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'corona_hotspot_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CoronaHotspotModel _$CoronaHotspotModelFromJson(Map<String, dynamic> json) {
  return _CoronaHotspotModel.fromJson(json);
}

/// @nodoc
class _$CoronaHotspotModelTearOff {
  const _$CoronaHotspotModelTearOff();

  _CoronaHotspotModel call(
      {required double lat,
      required double long,
      required int death,
      required int active,
      required int recovered}) {
    return _CoronaHotspotModel(
      lat: lat,
      long: long,
      death: death,
      active: active,
      recovered: recovered,
    );
  }

  CoronaHotspotModel fromJson(Map<String, Object> json) {
    return CoronaHotspotModel.fromJson(json);
  }
}

/// @nodoc
const $CoronaHotspotModel = _$CoronaHotspotModelTearOff();

/// @nodoc
mixin _$CoronaHotspotModel {
  double get lat => throw _privateConstructorUsedError;
  double get long => throw _privateConstructorUsedError;
  int get death => throw _privateConstructorUsedError;
  int get active => throw _privateConstructorUsedError;
  int get recovered => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CoronaHotspotModelCopyWith<CoronaHotspotModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoronaHotspotModelCopyWith<$Res> {
  factory $CoronaHotspotModelCopyWith(
          CoronaHotspotModel value, $Res Function(CoronaHotspotModel) then) =
      _$CoronaHotspotModelCopyWithImpl<$Res>;
  $Res call({double lat, double long, int death, int active, int recovered});
}

/// @nodoc
class _$CoronaHotspotModelCopyWithImpl<$Res>
    implements $CoronaHotspotModelCopyWith<$Res> {
  _$CoronaHotspotModelCopyWithImpl(this._value, this._then);

  final CoronaHotspotModel _value;
  // ignore: unused_field
  final $Res Function(CoronaHotspotModel) _then;

  @override
  $Res call({
    Object? lat = freezed,
    Object? long = freezed,
    Object? death = freezed,
    Object? active = freezed,
    Object? recovered = freezed,
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
      death: death == freezed
          ? _value.death
          : death // ignore: cast_nullable_to_non_nullable
              as int,
      active: active == freezed
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as int,
      recovered: recovered == freezed
          ? _value.recovered
          : recovered // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$CoronaHotspotModelCopyWith<$Res>
    implements $CoronaHotspotModelCopyWith<$Res> {
  factory _$CoronaHotspotModelCopyWith(
          _CoronaHotspotModel value, $Res Function(_CoronaHotspotModel) then) =
      __$CoronaHotspotModelCopyWithImpl<$Res>;
  @override
  $Res call({double lat, double long, int death, int active, int recovered});
}

/// @nodoc
class __$CoronaHotspotModelCopyWithImpl<$Res>
    extends _$CoronaHotspotModelCopyWithImpl<$Res>
    implements _$CoronaHotspotModelCopyWith<$Res> {
  __$CoronaHotspotModelCopyWithImpl(
      _CoronaHotspotModel _value, $Res Function(_CoronaHotspotModel) _then)
      : super(_value, (v) => _then(v as _CoronaHotspotModel));

  @override
  _CoronaHotspotModel get _value => super._value as _CoronaHotspotModel;

  @override
  $Res call({
    Object? lat = freezed,
    Object? long = freezed,
    Object? death = freezed,
    Object? active = freezed,
    Object? recovered = freezed,
  }) {
    return _then(_CoronaHotspotModel(
      lat: lat == freezed
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      long: long == freezed
          ? _value.long
          : long // ignore: cast_nullable_to_non_nullable
              as double,
      death: death == freezed
          ? _value.death
          : death // ignore: cast_nullable_to_non_nullable
              as int,
      active: active == freezed
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as int,
      recovered: recovered == freezed
          ? _value.recovered
          : recovered // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CoronaHotspotModel implements _CoronaHotspotModel {
  const _$_CoronaHotspotModel(
      {required this.lat,
      required this.long,
      required this.death,
      required this.active,
      required this.recovered});

  factory _$_CoronaHotspotModel.fromJson(Map<String, dynamic> json) =>
      _$_$_CoronaHotspotModelFromJson(json);

  @override
  final double lat;
  @override
  final double long;
  @override
  final int death;
  @override
  final int active;
  @override
  final int recovered;

  @override
  String toString() {
    return 'CoronaHotspotModel(lat: $lat, long: $long, death: $death, active: $active, recovered: $recovered)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CoronaHotspotModel &&
            (identical(other.lat, lat) ||
                const DeepCollectionEquality().equals(other.lat, lat)) &&
            (identical(other.long, long) ||
                const DeepCollectionEquality().equals(other.long, long)) &&
            (identical(other.death, death) ||
                const DeepCollectionEquality().equals(other.death, death)) &&
            (identical(other.active, active) ||
                const DeepCollectionEquality().equals(other.active, active)) &&
            (identical(other.recovered, recovered) ||
                const DeepCollectionEquality()
                    .equals(other.recovered, recovered)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(lat) ^
      const DeepCollectionEquality().hash(long) ^
      const DeepCollectionEquality().hash(death) ^
      const DeepCollectionEquality().hash(active) ^
      const DeepCollectionEquality().hash(recovered);

  @JsonKey(ignore: true)
  @override
  _$CoronaHotspotModelCopyWith<_CoronaHotspotModel> get copyWith =>
      __$CoronaHotspotModelCopyWithImpl<_CoronaHotspotModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CoronaHotspotModelToJson(this);
  }
}

abstract class _CoronaHotspotModel implements CoronaHotspotModel {
  const factory _CoronaHotspotModel(
      {required double lat,
      required double long,
      required int death,
      required int active,
      required int recovered}) = _$_CoronaHotspotModel;

  factory _CoronaHotspotModel.fromJson(Map<String, dynamic> json) =
      _$_CoronaHotspotModel.fromJson;

  @override
  double get lat => throw _privateConstructorUsedError;
  @override
  double get long => throw _privateConstructorUsedError;
  @override
  int get death => throw _privateConstructorUsedError;
  @override
  int get active => throw _privateConstructorUsedError;
  @override
  int get recovered => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CoronaHotspotModelCopyWith<_CoronaHotspotModel> get copyWith =>
      throw _privateConstructorUsedError;
}
