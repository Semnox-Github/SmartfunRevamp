// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cards_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CardsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() inProgress,
    required TResult Function(List<CreditPlusSummary> bonusSummary) success,
    required TResult Function(List<AccountGameDTOList> accountGamesSummary)
        accountGamesSuccess,
    required TResult Function(String msg) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? inProgress,
    TResult? Function(List<CreditPlusSummary> bonusSummary)? success,
    TResult? Function(List<AccountGameDTOList> accountGamesSummary)?
        accountGamesSuccess,
    TResult? Function(String msg)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? inProgress,
    TResult Function(List<CreditPlusSummary> bonusSummary)? success,
    TResult Function(List<AccountGameDTOList> accountGamesSummary)?
        accountGamesSuccess,
    TResult Function(String msg)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Success value) success,
    required TResult Function(_AccountGamesSuccess value) accountGamesSuccess,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Success value)? success,
    TResult? Function(_AccountGamesSuccess value)? accountGamesSuccess,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Success value)? success,
    TResult Function(_AccountGamesSuccess value)? accountGamesSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardsStateCopyWith<$Res> {
  factory $CardsStateCopyWith(
          CardsState value, $Res Function(CardsState) then) =
      _$CardsStateCopyWithImpl<$Res, CardsState>;
}

/// @nodoc
class _$CardsStateCopyWithImpl<$Res, $Val extends CardsState>
    implements $CardsStateCopyWith<$Res> {
  _$CardsStateCopyWithImpl(this._value, this._then);

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
    extends _$CardsStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'CardsState.initial()';
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
    required TResult Function(List<CreditPlusSummary> bonusSummary) success,
    required TResult Function(List<AccountGameDTOList> accountGamesSummary)
        accountGamesSuccess,
    required TResult Function(String msg) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? inProgress,
    TResult? Function(List<CreditPlusSummary> bonusSummary)? success,
    TResult? Function(List<AccountGameDTOList> accountGamesSummary)?
        accountGamesSuccess,
    TResult? Function(String msg)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? inProgress,
    TResult Function(List<CreditPlusSummary> bonusSummary)? success,
    TResult Function(List<AccountGameDTOList> accountGamesSummary)?
        accountGamesSuccess,
    TResult Function(String msg)? error,
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
    required TResult Function(_AccountGamesSuccess value) accountGamesSuccess,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Success value)? success,
    TResult? Function(_AccountGamesSuccess value)? accountGamesSuccess,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Success value)? success,
    TResult Function(_AccountGamesSuccess value)? accountGamesSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements CardsState {
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
    extends _$CardsStateCopyWithImpl<$Res, _$_InProgress>
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
    return 'CardsState.inProgress()';
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
    required TResult Function(List<CreditPlusSummary> bonusSummary) success,
    required TResult Function(List<AccountGameDTOList> accountGamesSummary)
        accountGamesSuccess,
    required TResult Function(String msg) error,
  }) {
    return inProgress();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? inProgress,
    TResult? Function(List<CreditPlusSummary> bonusSummary)? success,
    TResult? Function(List<AccountGameDTOList> accountGamesSummary)?
        accountGamesSuccess,
    TResult? Function(String msg)? error,
  }) {
    return inProgress?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? inProgress,
    TResult Function(List<CreditPlusSummary> bonusSummary)? success,
    TResult Function(List<AccountGameDTOList> accountGamesSummary)?
        accountGamesSuccess,
    TResult Function(String msg)? error,
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
    required TResult Function(_AccountGamesSuccess value) accountGamesSuccess,
    required TResult Function(_Error value) error,
  }) {
    return inProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Success value)? success,
    TResult? Function(_AccountGamesSuccess value)? accountGamesSuccess,
    TResult? Function(_Error value)? error,
  }) {
    return inProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Success value)? success,
    TResult Function(_AccountGamesSuccess value)? accountGamesSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress(this);
    }
    return orElse();
  }
}

abstract class _InProgress implements CardsState {
  const factory _InProgress() = _$_InProgress;
}

/// @nodoc
abstract class _$$_SuccessCopyWith<$Res> {
  factory _$$_SuccessCopyWith(
          _$_Success value, $Res Function(_$_Success) then) =
      __$$_SuccessCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CreditPlusSummary> bonusSummary});
}

/// @nodoc
class __$$_SuccessCopyWithImpl<$Res>
    extends _$CardsStateCopyWithImpl<$Res, _$_Success>
    implements _$$_SuccessCopyWith<$Res> {
  __$$_SuccessCopyWithImpl(_$_Success _value, $Res Function(_$_Success) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bonusSummary = null,
  }) {
    return _then(_$_Success(
      null == bonusSummary
          ? _value._bonusSummary
          : bonusSummary // ignore: cast_nullable_to_non_nullable
              as List<CreditPlusSummary>,
    ));
  }
}

/// @nodoc

class _$_Success implements _Success {
  const _$_Success(final List<CreditPlusSummary> bonusSummary)
      : _bonusSummary = bonusSummary;

  final List<CreditPlusSummary> _bonusSummary;
  @override
  List<CreditPlusSummary> get bonusSummary {
    if (_bonusSummary is EqualUnmodifiableListView) return _bonusSummary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bonusSummary);
  }

  @override
  String toString() {
    return 'CardsState.success(bonusSummary: $bonusSummary)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Success &&
            const DeepCollectionEquality()
                .equals(other._bonusSummary, _bonusSummary));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_bonusSummary));

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
    required TResult Function(List<CreditPlusSummary> bonusSummary) success,
    required TResult Function(List<AccountGameDTOList> accountGamesSummary)
        accountGamesSuccess,
    required TResult Function(String msg) error,
  }) {
    return success(bonusSummary);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? inProgress,
    TResult? Function(List<CreditPlusSummary> bonusSummary)? success,
    TResult? Function(List<AccountGameDTOList> accountGamesSummary)?
        accountGamesSuccess,
    TResult? Function(String msg)? error,
  }) {
    return success?.call(bonusSummary);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? inProgress,
    TResult Function(List<CreditPlusSummary> bonusSummary)? success,
    TResult Function(List<AccountGameDTOList> accountGamesSummary)?
        accountGamesSuccess,
    TResult Function(String msg)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(bonusSummary);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Success value) success,
    required TResult Function(_AccountGamesSuccess value) accountGamesSuccess,
    required TResult Function(_Error value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Success value)? success,
    TResult? Function(_AccountGamesSuccess value)? accountGamesSuccess,
    TResult? Function(_Error value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Success value)? success,
    TResult Function(_AccountGamesSuccess value)? accountGamesSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements CardsState {
  const factory _Success(final List<CreditPlusSummary> bonusSummary) =
      _$_Success;

  List<CreditPlusSummary> get bonusSummary;
  @JsonKey(ignore: true)
  _$$_SuccessCopyWith<_$_Success> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_AccountGamesSuccessCopyWith<$Res> {
  factory _$$_AccountGamesSuccessCopyWith(_$_AccountGamesSuccess value,
          $Res Function(_$_AccountGamesSuccess) then) =
      __$$_AccountGamesSuccessCopyWithImpl<$Res>;
  @useResult
  $Res call({List<AccountGameDTOList> accountGamesSummary});
}

/// @nodoc
class __$$_AccountGamesSuccessCopyWithImpl<$Res>
    extends _$CardsStateCopyWithImpl<$Res, _$_AccountGamesSuccess>
    implements _$$_AccountGamesSuccessCopyWith<$Res> {
  __$$_AccountGamesSuccessCopyWithImpl(_$_AccountGamesSuccess _value,
      $Res Function(_$_AccountGamesSuccess) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountGamesSummary = null,
  }) {
    return _then(_$_AccountGamesSuccess(
      null == accountGamesSummary
          ? _value._accountGamesSummary
          : accountGamesSummary // ignore: cast_nullable_to_non_nullable
              as List<AccountGameDTOList>,
    ));
  }
}

/// @nodoc

class _$_AccountGamesSuccess implements _AccountGamesSuccess {
  const _$_AccountGamesSuccess(
      final List<AccountGameDTOList> accountGamesSummary)
      : _accountGamesSummary = accountGamesSummary;

  final List<AccountGameDTOList> _accountGamesSummary;
  @override
  List<AccountGameDTOList> get accountGamesSummary {
    if (_accountGamesSummary is EqualUnmodifiableListView)
      return _accountGamesSummary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_accountGamesSummary);
  }

  @override
  String toString() {
    return 'CardsState.accountGamesSuccess(accountGamesSummary: $accountGamesSummary)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AccountGamesSuccess &&
            const DeepCollectionEquality()
                .equals(other._accountGamesSummary, _accountGamesSummary));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_accountGamesSummary));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AccountGamesSuccessCopyWith<_$_AccountGamesSuccess> get copyWith =>
      __$$_AccountGamesSuccessCopyWithImpl<_$_AccountGamesSuccess>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() inProgress,
    required TResult Function(List<CreditPlusSummary> bonusSummary) success,
    required TResult Function(List<AccountGameDTOList> accountGamesSummary)
        accountGamesSuccess,
    required TResult Function(String msg) error,
  }) {
    return accountGamesSuccess(accountGamesSummary);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? inProgress,
    TResult? Function(List<CreditPlusSummary> bonusSummary)? success,
    TResult? Function(List<AccountGameDTOList> accountGamesSummary)?
        accountGamesSuccess,
    TResult? Function(String msg)? error,
  }) {
    return accountGamesSuccess?.call(accountGamesSummary);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? inProgress,
    TResult Function(List<CreditPlusSummary> bonusSummary)? success,
    TResult Function(List<AccountGameDTOList> accountGamesSummary)?
        accountGamesSuccess,
    TResult Function(String msg)? error,
    required TResult orElse(),
  }) {
    if (accountGamesSuccess != null) {
      return accountGamesSuccess(accountGamesSummary);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Success value) success,
    required TResult Function(_AccountGamesSuccess value) accountGamesSuccess,
    required TResult Function(_Error value) error,
  }) {
    return accountGamesSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Success value)? success,
    TResult? Function(_AccountGamesSuccess value)? accountGamesSuccess,
    TResult? Function(_Error value)? error,
  }) {
    return accountGamesSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Success value)? success,
    TResult Function(_AccountGamesSuccess value)? accountGamesSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (accountGamesSuccess != null) {
      return accountGamesSuccess(this);
    }
    return orElse();
  }
}

abstract class _AccountGamesSuccess implements CardsState {
  const factory _AccountGamesSuccess(
          final List<AccountGameDTOList> accountGamesSummary) =
      _$_AccountGamesSuccess;

  List<AccountGameDTOList> get accountGamesSummary;
  @JsonKey(ignore: true)
  _$$_AccountGamesSuccessCopyWith<_$_AccountGamesSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ErrorCopyWith<$Res> {
  factory _$$_ErrorCopyWith(_$_Error value, $Res Function(_$_Error) then) =
      __$$_ErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String msg});
}

/// @nodoc
class __$$_ErrorCopyWithImpl<$Res>
    extends _$CardsStateCopyWithImpl<$Res, _$_Error>
    implements _$$_ErrorCopyWith<$Res> {
  __$$_ErrorCopyWithImpl(_$_Error _value, $Res Function(_$_Error) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = null,
  }) {
    return _then(_$_Error(
      null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Error implements _Error {
  const _$_Error(this.msg);

  @override
  final String msg;

  @override
  String toString() {
    return 'CardsState.error(msg: $msg)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Error &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, msg);

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
    required TResult Function(List<CreditPlusSummary> bonusSummary) success,
    required TResult Function(List<AccountGameDTOList> accountGamesSummary)
        accountGamesSuccess,
    required TResult Function(String msg) error,
  }) {
    return error(msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? inProgress,
    TResult? Function(List<CreditPlusSummary> bonusSummary)? success,
    TResult? Function(List<AccountGameDTOList> accountGamesSummary)?
        accountGamesSuccess,
    TResult? Function(String msg)? error,
  }) {
    return error?.call(msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? inProgress,
    TResult Function(List<CreditPlusSummary> bonusSummary)? success,
    TResult Function(List<AccountGameDTOList> accountGamesSummary)?
        accountGamesSuccess,
    TResult Function(String msg)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(msg);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Success value) success,
    required TResult Function(_AccountGamesSuccess value) accountGamesSuccess,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Success value)? success,
    TResult? Function(_AccountGamesSuccess value)? accountGamesSuccess,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Success value)? success,
    TResult Function(_AccountGamesSuccess value)? accountGamesSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements CardsState {
  const factory _Error(final String msg) = _$_Error;

  String get msg;
  @JsonKey(ignore: true)
  _$$_ErrorCopyWith<_$_Error> get copyWith =>
      throw _privateConstructorUsedError;
}
