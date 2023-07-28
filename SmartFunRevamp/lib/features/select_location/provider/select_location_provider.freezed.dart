// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_location_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SelectLocationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() inProgress,
    required TResult Function(List<SiteViewDTO> sites) success,
    required TResult Function(SiteViewDTO selectedSite) newContextSuccess,
    required TResult Function(String message) error,
    required TResult Function() siteSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? inProgress,
    TResult? Function(List<SiteViewDTO> sites)? success,
    TResult? Function(SiteViewDTO selectedSite)? newContextSuccess,
    TResult? Function(String message)? error,
    TResult? Function()? siteSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? inProgress,
    TResult Function(List<SiteViewDTO> sites)? success,
    TResult Function(SiteViewDTO selectedSite)? newContextSuccess,
    TResult Function(String message)? error,
    TResult Function()? siteSelected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Success value) success,
    required TResult Function(_NewContextSuccess value) newContextSuccess,
    required TResult Function(_Error value) error,
    required TResult Function(_SiteSelected value) siteSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Success value)? success,
    TResult? Function(_NewContextSuccess value)? newContextSuccess,
    TResult? Function(_Error value)? error,
    TResult? Function(_SiteSelected value)? siteSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Success value)? success,
    TResult Function(_NewContextSuccess value)? newContextSuccess,
    TResult Function(_Error value)? error,
    TResult Function(_SiteSelected value)? siteSelected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectLocationStateCopyWith<$Res> {
  factory $SelectLocationStateCopyWith(
          SelectLocationState value, $Res Function(SelectLocationState) then) =
      _$SelectLocationStateCopyWithImpl<$Res, SelectLocationState>;
}

/// @nodoc
class _$SelectLocationStateCopyWithImpl<$Res, $Val extends SelectLocationState>
    implements $SelectLocationStateCopyWith<$Res> {
  _$SelectLocationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$SelectLocationStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'SelectLocationState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() inProgress,
    required TResult Function(List<SiteViewDTO> sites) success,
    required TResult Function(SiteViewDTO selectedSite) newContextSuccess,
    required TResult Function(String message) error,
    required TResult Function() siteSelected,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? inProgress,
    TResult? Function(List<SiteViewDTO> sites)? success,
    TResult? Function(SiteViewDTO selectedSite)? newContextSuccess,
    TResult? Function(String message)? error,
    TResult? Function()? siteSelected,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? inProgress,
    TResult Function(List<SiteViewDTO> sites)? success,
    TResult Function(SiteViewDTO selectedSite)? newContextSuccess,
    TResult Function(String message)? error,
    TResult Function()? siteSelected,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Success value) success,
    required TResult Function(_NewContextSuccess value) newContextSuccess,
    required TResult Function(_Error value) error,
    required TResult Function(_SiteSelected value) siteSelected,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Success value)? success,
    TResult? Function(_NewContextSuccess value)? newContextSuccess,
    TResult? Function(_Error value)? error,
    TResult? Function(_SiteSelected value)? siteSelected,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Success value)? success,
    TResult Function(_NewContextSuccess value)? newContextSuccess,
    TResult Function(_Error value)? error,
    TResult Function(_SiteSelected value)? siteSelected,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements SelectLocationState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$$_InProgressCopyWith<$Res> {
  factory _$$_InProgressCopyWith(
          _$_InProgress value, $Res Function(_$_InProgress) then) =
      __$$_InProgressCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InProgressCopyWithImpl<$Res>
    extends _$SelectLocationStateCopyWithImpl<$Res, _$_InProgress>
    implements _$$_InProgressCopyWith<$Res> {
  __$$_InProgressCopyWithImpl(
      _$_InProgress _value, $Res Function(_$_InProgress) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_InProgress implements _InProgress {
  const _$_InProgress();

  @override
  String toString() {
    return 'SelectLocationState.inProgress()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_InProgress);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() inProgress,
    required TResult Function(List<SiteViewDTO> sites) success,
    required TResult Function(SiteViewDTO selectedSite) newContextSuccess,
    required TResult Function(String message) error,
    required TResult Function() siteSelected,
  }) {
    return inProgress();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? inProgress,
    TResult? Function(List<SiteViewDTO> sites)? success,
    TResult? Function(SiteViewDTO selectedSite)? newContextSuccess,
    TResult? Function(String message)? error,
    TResult? Function()? siteSelected,
  }) {
    return inProgress?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? inProgress,
    TResult Function(List<SiteViewDTO> sites)? success,
    TResult Function(SiteViewDTO selectedSite)? newContextSuccess,
    TResult Function(String message)? error,
    TResult Function()? siteSelected,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Success value) success,
    required TResult Function(_NewContextSuccess value) newContextSuccess,
    required TResult Function(_Error value) error,
    required TResult Function(_SiteSelected value) siteSelected,
  }) {
    return inProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Success value)? success,
    TResult? Function(_NewContextSuccess value)? newContextSuccess,
    TResult? Function(_Error value)? error,
    TResult? Function(_SiteSelected value)? siteSelected,
  }) {
    return inProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Success value)? success,
    TResult Function(_NewContextSuccess value)? newContextSuccess,
    TResult Function(_Error value)? error,
    TResult Function(_SiteSelected value)? siteSelected,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress(this);
    }
    return orElse();
  }
}

abstract class _InProgress implements SelectLocationState {
  const factory _InProgress() = _$_InProgress;
}

/// @nodoc
abstract class _$$_SuccessCopyWith<$Res> {
  factory _$$_SuccessCopyWith(
          _$_Success value, $Res Function(_$_Success) then) =
      __$$_SuccessCopyWithImpl<$Res>;
  @useResult
  $Res call({List<SiteViewDTO> sites});
}

/// @nodoc
class __$$_SuccessCopyWithImpl<$Res>
    extends _$SelectLocationStateCopyWithImpl<$Res, _$_Success>
    implements _$$_SuccessCopyWith<$Res> {
  __$$_SuccessCopyWithImpl(_$_Success _value, $Res Function(_$_Success) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sites = null,
  }) {
    return _then(_$_Success(
      null == sites
          ? _value._sites
          : sites // ignore: cast_nullable_to_non_nullable
              as List<SiteViewDTO>,
    ));
  }
}

/// @nodoc

class _$_Success implements _Success {
  const _$_Success(final List<SiteViewDTO> sites) : _sites = sites;

  final List<SiteViewDTO> _sites;
  @override
  List<SiteViewDTO> get sites {
    if (_sites is EqualUnmodifiableListView) return _sites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sites);
  }

  @override
  String toString() {
    return 'SelectLocationState.success(sites: $sites)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Success &&
            const DeepCollectionEquality().equals(other._sites, _sites));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_sites));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SuccessCopyWith<_$_Success> get copyWith =>
      __$$_SuccessCopyWithImpl<_$_Success>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() inProgress,
    required TResult Function(List<SiteViewDTO> sites) success,
    required TResult Function(SiteViewDTO selectedSite) newContextSuccess,
    required TResult Function(String message) error,
    required TResult Function() siteSelected,
  }) {
    return success(sites);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? inProgress,
    TResult? Function(List<SiteViewDTO> sites)? success,
    TResult? Function(SiteViewDTO selectedSite)? newContextSuccess,
    TResult? Function(String message)? error,
    TResult? Function()? siteSelected,
  }) {
    return success?.call(sites);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? inProgress,
    TResult Function(List<SiteViewDTO> sites)? success,
    TResult Function(SiteViewDTO selectedSite)? newContextSuccess,
    TResult Function(String message)? error,
    TResult Function()? siteSelected,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(sites);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Success value) success,
    required TResult Function(_NewContextSuccess value) newContextSuccess,
    required TResult Function(_Error value) error,
    required TResult Function(_SiteSelected value) siteSelected,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Success value)? success,
    TResult? Function(_NewContextSuccess value)? newContextSuccess,
    TResult? Function(_Error value)? error,
    TResult? Function(_SiteSelected value)? siteSelected,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Success value)? success,
    TResult Function(_NewContextSuccess value)? newContextSuccess,
    TResult Function(_Error value)? error,
    TResult Function(_SiteSelected value)? siteSelected,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements SelectLocationState {
  const factory _Success(final List<SiteViewDTO> sites) = _$_Success;

  List<SiteViewDTO> get sites;
  @JsonKey(ignore: true)
  _$$_SuccessCopyWith<_$_Success> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_NewContextSuccessCopyWith<$Res> {
  factory _$$_NewContextSuccessCopyWith(_$_NewContextSuccess value,
          $Res Function(_$_NewContextSuccess) then) =
      __$$_NewContextSuccessCopyWithImpl<$Res>;
  @useResult
  $Res call({SiteViewDTO selectedSite});
}

/// @nodoc
class __$$_NewContextSuccessCopyWithImpl<$Res>
    extends _$SelectLocationStateCopyWithImpl<$Res, _$_NewContextSuccess>
    implements _$$_NewContextSuccessCopyWith<$Res> {
  __$$_NewContextSuccessCopyWithImpl(
      _$_NewContextSuccess _value, $Res Function(_$_NewContextSuccess) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedSite = null,
  }) {
    return _then(_$_NewContextSuccess(
      null == selectedSite
          ? _value.selectedSite
          : selectedSite // ignore: cast_nullable_to_non_nullable
              as SiteViewDTO,
    ));
  }
}

/// @nodoc

class _$_NewContextSuccess implements _NewContextSuccess {
  const _$_NewContextSuccess(this.selectedSite);

  @override
  final SiteViewDTO selectedSite;

  @override
  String toString() {
    return 'SelectLocationState.newContextSuccess(selectedSite: $selectedSite)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NewContextSuccess &&
            (identical(other.selectedSite, selectedSite) ||
                other.selectedSite == selectedSite));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedSite);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NewContextSuccessCopyWith<_$_NewContextSuccess> get copyWith =>
      __$$_NewContextSuccessCopyWithImpl<_$_NewContextSuccess>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() inProgress,
    required TResult Function(List<SiteViewDTO> sites) success,
    required TResult Function(SiteViewDTO selectedSite) newContextSuccess,
    required TResult Function(String message) error,
    required TResult Function() siteSelected,
  }) {
    return newContextSuccess(selectedSite);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? inProgress,
    TResult? Function(List<SiteViewDTO> sites)? success,
    TResult? Function(SiteViewDTO selectedSite)? newContextSuccess,
    TResult? Function(String message)? error,
    TResult? Function()? siteSelected,
  }) {
    return newContextSuccess?.call(selectedSite);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? inProgress,
    TResult Function(List<SiteViewDTO> sites)? success,
    TResult Function(SiteViewDTO selectedSite)? newContextSuccess,
    TResult Function(String message)? error,
    TResult Function()? siteSelected,
    required TResult orElse(),
  }) {
    if (newContextSuccess != null) {
      return newContextSuccess(selectedSite);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Success value) success,
    required TResult Function(_NewContextSuccess value) newContextSuccess,
    required TResult Function(_Error value) error,
    required TResult Function(_SiteSelected value) siteSelected,
  }) {
    return newContextSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Success value)? success,
    TResult? Function(_NewContextSuccess value)? newContextSuccess,
    TResult? Function(_Error value)? error,
    TResult? Function(_SiteSelected value)? siteSelected,
  }) {
    return newContextSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Success value)? success,
    TResult Function(_NewContextSuccess value)? newContextSuccess,
    TResult Function(_Error value)? error,
    TResult Function(_SiteSelected value)? siteSelected,
    required TResult orElse(),
  }) {
    if (newContextSuccess != null) {
      return newContextSuccess(this);
    }
    return orElse();
  }
}

abstract class _NewContextSuccess implements SelectLocationState {
  const factory _NewContextSuccess(final SiteViewDTO selectedSite) =
      _$_NewContextSuccess;

  SiteViewDTO get selectedSite;
  @JsonKey(ignore: true)
  _$$_NewContextSuccessCopyWith<_$_NewContextSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ErrorCopyWith<$Res> {
  factory _$$_ErrorCopyWith(_$_Error value, $Res Function(_$_Error) then) =
      __$$_ErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$_ErrorCopyWithImpl<$Res>
    extends _$SelectLocationStateCopyWithImpl<$Res, _$_Error>
    implements _$$_ErrorCopyWith<$Res> {
  __$$_ErrorCopyWithImpl(_$_Error _value, $Res Function(_$_Error) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$_Error(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Error implements _Error {
  const _$_Error(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'SelectLocationState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Error &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ErrorCopyWith<_$_Error> get copyWith =>
      __$$_ErrorCopyWithImpl<_$_Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() inProgress,
    required TResult Function(List<SiteViewDTO> sites) success,
    required TResult Function(SiteViewDTO selectedSite) newContextSuccess,
    required TResult Function(String message) error,
    required TResult Function() siteSelected,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? inProgress,
    TResult? Function(List<SiteViewDTO> sites)? success,
    TResult? Function(SiteViewDTO selectedSite)? newContextSuccess,
    TResult? Function(String message)? error,
    TResult? Function()? siteSelected,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? inProgress,
    TResult Function(List<SiteViewDTO> sites)? success,
    TResult Function(SiteViewDTO selectedSite)? newContextSuccess,
    TResult Function(String message)? error,
    TResult Function()? siteSelected,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Success value) success,
    required TResult Function(_NewContextSuccess value) newContextSuccess,
    required TResult Function(_Error value) error,
    required TResult Function(_SiteSelected value) siteSelected,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Success value)? success,
    TResult? Function(_NewContextSuccess value)? newContextSuccess,
    TResult? Function(_Error value)? error,
    TResult? Function(_SiteSelected value)? siteSelected,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Success value)? success,
    TResult Function(_NewContextSuccess value)? newContextSuccess,
    TResult Function(_Error value)? error,
    TResult Function(_SiteSelected value)? siteSelected,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements SelectLocationState {
  const factory _Error(final String message) = _$_Error;

  String get message;
  @JsonKey(ignore: true)
  _$$_ErrorCopyWith<_$_Error> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_SiteSelectedCopyWith<$Res> {
  factory _$$_SiteSelectedCopyWith(
          _$_SiteSelected value, $Res Function(_$_SiteSelected) then) =
      __$$_SiteSelectedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_SiteSelectedCopyWithImpl<$Res>
    extends _$SelectLocationStateCopyWithImpl<$Res, _$_SiteSelected>
    implements _$$_SiteSelectedCopyWith<$Res> {
  __$$_SiteSelectedCopyWithImpl(
      _$_SiteSelected _value, $Res Function(_$_SiteSelected) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_SiteSelected implements _SiteSelected {
  const _$_SiteSelected();

  @override
  String toString() {
    return 'SelectLocationState.siteSelected()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_SiteSelected);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() inProgress,
    required TResult Function(List<SiteViewDTO> sites) success,
    required TResult Function(SiteViewDTO selectedSite) newContextSuccess,
    required TResult Function(String message) error,
    required TResult Function() siteSelected,
  }) {
    return siteSelected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? inProgress,
    TResult? Function(List<SiteViewDTO> sites)? success,
    TResult? Function(SiteViewDTO selectedSite)? newContextSuccess,
    TResult? Function(String message)? error,
    TResult? Function()? siteSelected,
  }) {
    return siteSelected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? inProgress,
    TResult Function(List<SiteViewDTO> sites)? success,
    TResult Function(SiteViewDTO selectedSite)? newContextSuccess,
    TResult Function(String message)? error,
    TResult Function()? siteSelected,
    required TResult orElse(),
  }) {
    if (siteSelected != null) {
      return siteSelected();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Success value) success,
    required TResult Function(_NewContextSuccess value) newContextSuccess,
    required TResult Function(_Error value) error,
    required TResult Function(_SiteSelected value) siteSelected,
  }) {
    return siteSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Success value)? success,
    TResult? Function(_NewContextSuccess value)? newContextSuccess,
    TResult? Function(_Error value)? error,
    TResult? Function(_SiteSelected value)? siteSelected,
  }) {
    return siteSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Success value)? success,
    TResult Function(_NewContextSuccess value)? newContextSuccess,
    TResult Function(_Error value)? error,
    TResult Function(_SiteSelected value)? siteSelected,
    required TResult orElse(),
  }) {
    if (siteSelected != null) {
      return siteSelected(this);
    }
    return orElse();
  }
}

abstract class _SiteSelected implements SelectLocationState {
  const factory _SiteSelected() = _$_SiteSelected;
}
