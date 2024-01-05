// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'estimate_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EstimateState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() inProgress,
    required TResult Function(String message) error,
    required TResult Function(String message) invalidCoupon,
    required TResult Function(AddCardProductResponse response)
        transactionEstimated,
    required TResult Function(DiscountCountResponse response) transactionSaved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? inProgress,
    TResult? Function(String message)? error,
    TResult? Function(String message)? invalidCoupon,
    TResult? Function(AddCardProductResponse response)? transactionEstimated,
    TResult? Function(DiscountCountResponse response)? transactionSaved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inProgress,
    TResult Function(String message)? error,
    TResult Function(String message)? invalidCoupon,
    TResult Function(AddCardProductResponse response)? transactionEstimated,
    TResult Function(DiscountCountResponse response)? transactionSaved,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Error value) error,
    required TResult Function(_InvalidCoupon value) invalidCoupon,
    required TResult Function(_TransactionEstimated value) transactionEstimated,
    required TResult Function(_TransactionSaved value) transactionSaved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Error value)? error,
    TResult? Function(_InvalidCoupon value)? invalidCoupon,
    TResult? Function(_TransactionEstimated value)? transactionEstimated,
    TResult? Function(_TransactionSaved value)? transactionSaved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Error value)? error,
    TResult Function(_InvalidCoupon value)? invalidCoupon,
    TResult Function(_TransactionEstimated value)? transactionEstimated,
    TResult Function(_TransactionSaved value)? transactionSaved,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EstimateStateCopyWith<$Res> {
  factory $EstimateStateCopyWith(
          EstimateState value, $Res Function(EstimateState) then) =
      _$EstimateStateCopyWithImpl<$Res, EstimateState>;
}

/// @nodoc
class _$EstimateStateCopyWithImpl<$Res, $Val extends EstimateState>
    implements $EstimateStateCopyWith<$Res> {
  _$EstimateStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_InProgressCopyWith<$Res> {
  factory _$$_InProgressCopyWith(
          _$_InProgress value, $Res Function(_$_InProgress) then) =
      __$$_InProgressCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InProgressCopyWithImpl<$Res>
    extends _$EstimateStateCopyWithImpl<$Res, _$_InProgress>
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
    return 'EstimateState.inProgress()';
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
    required TResult Function() inProgress,
    required TResult Function(String message) error,
    required TResult Function(String message) invalidCoupon,
    required TResult Function(AddCardProductResponse response)
        transactionEstimated,
    required TResult Function(DiscountCountResponse response) transactionSaved,
  }) {
    return inProgress();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? inProgress,
    TResult? Function(String message)? error,
    TResult? Function(String message)? invalidCoupon,
    TResult? Function(AddCardProductResponse response)? transactionEstimated,
    TResult? Function(DiscountCountResponse response)? transactionSaved,
  }) {
    return inProgress?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inProgress,
    TResult Function(String message)? error,
    TResult Function(String message)? invalidCoupon,
    TResult Function(AddCardProductResponse response)? transactionEstimated,
    TResult Function(DiscountCountResponse response)? transactionSaved,
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
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Error value) error,
    required TResult Function(_InvalidCoupon value) invalidCoupon,
    required TResult Function(_TransactionEstimated value) transactionEstimated,
    required TResult Function(_TransactionSaved value) transactionSaved,
  }) {
    return inProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Error value)? error,
    TResult? Function(_InvalidCoupon value)? invalidCoupon,
    TResult? Function(_TransactionEstimated value)? transactionEstimated,
    TResult? Function(_TransactionSaved value)? transactionSaved,
  }) {
    return inProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Error value)? error,
    TResult Function(_InvalidCoupon value)? invalidCoupon,
    TResult Function(_TransactionEstimated value)? transactionEstimated,
    TResult Function(_TransactionSaved value)? transactionSaved,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress(this);
    }
    return orElse();
  }
}

abstract class _InProgress implements EstimateState {
  const factory _InProgress() = _$_InProgress;
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
    extends _$EstimateStateCopyWithImpl<$Res, _$_Error>
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
    return 'EstimateState.error(message: $message)';
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
    required TResult Function() inProgress,
    required TResult Function(String message) error,
    required TResult Function(String message) invalidCoupon,
    required TResult Function(AddCardProductResponse response)
        transactionEstimated,
    required TResult Function(DiscountCountResponse response) transactionSaved,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? inProgress,
    TResult? Function(String message)? error,
    TResult? Function(String message)? invalidCoupon,
    TResult? Function(AddCardProductResponse response)? transactionEstimated,
    TResult? Function(DiscountCountResponse response)? transactionSaved,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inProgress,
    TResult Function(String message)? error,
    TResult Function(String message)? invalidCoupon,
    TResult Function(AddCardProductResponse response)? transactionEstimated,
    TResult Function(DiscountCountResponse response)? transactionSaved,
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
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Error value) error,
    required TResult Function(_InvalidCoupon value) invalidCoupon,
    required TResult Function(_TransactionEstimated value) transactionEstimated,
    required TResult Function(_TransactionSaved value) transactionSaved,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Error value)? error,
    TResult? Function(_InvalidCoupon value)? invalidCoupon,
    TResult? Function(_TransactionEstimated value)? transactionEstimated,
    TResult? Function(_TransactionSaved value)? transactionSaved,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Error value)? error,
    TResult Function(_InvalidCoupon value)? invalidCoupon,
    TResult Function(_TransactionEstimated value)? transactionEstimated,
    TResult Function(_TransactionSaved value)? transactionSaved,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements EstimateState {
  const factory _Error(final String message) = _$_Error;

  String get message;
  @JsonKey(ignore: true)
  _$$_ErrorCopyWith<_$_Error> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_InvalidCouponCopyWith<$Res> {
  factory _$$_InvalidCouponCopyWith(
          _$_InvalidCoupon value, $Res Function(_$_InvalidCoupon) then) =
      __$$_InvalidCouponCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$_InvalidCouponCopyWithImpl<$Res>
    extends _$EstimateStateCopyWithImpl<$Res, _$_InvalidCoupon>
    implements _$$_InvalidCouponCopyWith<$Res> {
  __$$_InvalidCouponCopyWithImpl(
      _$_InvalidCoupon _value, $Res Function(_$_InvalidCoupon) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$_InvalidCoupon(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_InvalidCoupon implements _InvalidCoupon {
  const _$_InvalidCoupon(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'EstimateState.invalidCoupon(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InvalidCoupon &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InvalidCouponCopyWith<_$_InvalidCoupon> get copyWith =>
      __$$_InvalidCouponCopyWithImpl<_$_InvalidCoupon>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() inProgress,
    required TResult Function(String message) error,
    required TResult Function(String message) invalidCoupon,
    required TResult Function(AddCardProductResponse response)
        transactionEstimated,
    required TResult Function(DiscountCountResponse response) transactionSaved,
  }) {
    return invalidCoupon(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? inProgress,
    TResult? Function(String message)? error,
    TResult? Function(String message)? invalidCoupon,
    TResult? Function(AddCardProductResponse response)? transactionEstimated,
    TResult? Function(DiscountCountResponse response)? transactionSaved,
  }) {
    return invalidCoupon?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inProgress,
    TResult Function(String message)? error,
    TResult Function(String message)? invalidCoupon,
    TResult Function(AddCardProductResponse response)? transactionEstimated,
    TResult Function(DiscountCountResponse response)? transactionSaved,
    required TResult orElse(),
  }) {
    if (invalidCoupon != null) {
      return invalidCoupon(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Error value) error,
    required TResult Function(_InvalidCoupon value) invalidCoupon,
    required TResult Function(_TransactionEstimated value) transactionEstimated,
    required TResult Function(_TransactionSaved value) transactionSaved,
  }) {
    return invalidCoupon(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Error value)? error,
    TResult? Function(_InvalidCoupon value)? invalidCoupon,
    TResult? Function(_TransactionEstimated value)? transactionEstimated,
    TResult? Function(_TransactionSaved value)? transactionSaved,
  }) {
    return invalidCoupon?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Error value)? error,
    TResult Function(_InvalidCoupon value)? invalidCoupon,
    TResult Function(_TransactionEstimated value)? transactionEstimated,
    TResult Function(_TransactionSaved value)? transactionSaved,
    required TResult orElse(),
  }) {
    if (invalidCoupon != null) {
      return invalidCoupon(this);
    }
    return orElse();
  }
}

abstract class _InvalidCoupon implements EstimateState {
  const factory _InvalidCoupon(final String message) = _$_InvalidCoupon;

  String get message;
  @JsonKey(ignore: true)
  _$$_InvalidCouponCopyWith<_$_InvalidCoupon> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_TransactionEstimatedCopyWith<$Res> {
  factory _$$_TransactionEstimatedCopyWith(_$_TransactionEstimated value,
          $Res Function(_$_TransactionEstimated) then) =
      __$$_TransactionEstimatedCopyWithImpl<$Res>;
  @useResult
  $Res call({AddCardProductResponse response});
}

/// @nodoc
class __$$_TransactionEstimatedCopyWithImpl<$Res>
    extends _$EstimateStateCopyWithImpl<$Res, _$_TransactionEstimated>
    implements _$$_TransactionEstimatedCopyWith<$Res> {
  __$$_TransactionEstimatedCopyWithImpl(_$_TransactionEstimated _value,
      $Res Function(_$_TransactionEstimated) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$_TransactionEstimated(
      null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as AddCardProductResponse,
    ));
  }
}

/// @nodoc

class _$_TransactionEstimated implements _TransactionEstimated {
  const _$_TransactionEstimated(this.response);

  @override
  final AddCardProductResponse response;

  @override
  String toString() {
    return 'EstimateState.transactionEstimated(response: $response)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionEstimated &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionEstimatedCopyWith<_$_TransactionEstimated> get copyWith =>
      __$$_TransactionEstimatedCopyWithImpl<_$_TransactionEstimated>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() inProgress,
    required TResult Function(String message) error,
    required TResult Function(String message) invalidCoupon,
    required TResult Function(AddCardProductResponse response)
        transactionEstimated,
    required TResult Function(DiscountCountResponse response) transactionSaved,
  }) {
    return transactionEstimated(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? inProgress,
    TResult? Function(String message)? error,
    TResult? Function(String message)? invalidCoupon,
    TResult? Function(AddCardProductResponse response)? transactionEstimated,
    TResult? Function(DiscountCountResponse response)? transactionSaved,
  }) {
    return transactionEstimated?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inProgress,
    TResult Function(String message)? error,
    TResult Function(String message)? invalidCoupon,
    TResult Function(AddCardProductResponse response)? transactionEstimated,
    TResult Function(DiscountCountResponse response)? transactionSaved,
    required TResult orElse(),
  }) {
    if (transactionEstimated != null) {
      return transactionEstimated(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Error value) error,
    required TResult Function(_InvalidCoupon value) invalidCoupon,
    required TResult Function(_TransactionEstimated value) transactionEstimated,
    required TResult Function(_TransactionSaved value) transactionSaved,
  }) {
    return transactionEstimated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Error value)? error,
    TResult? Function(_InvalidCoupon value)? invalidCoupon,
    TResult? Function(_TransactionEstimated value)? transactionEstimated,
    TResult? Function(_TransactionSaved value)? transactionSaved,
  }) {
    return transactionEstimated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Error value)? error,
    TResult Function(_InvalidCoupon value)? invalidCoupon,
    TResult Function(_TransactionEstimated value)? transactionEstimated,
    TResult Function(_TransactionSaved value)? transactionSaved,
    required TResult orElse(),
  }) {
    if (transactionEstimated != null) {
      return transactionEstimated(this);
    }
    return orElse();
  }
}

abstract class _TransactionEstimated implements EstimateState {
  const factory _TransactionEstimated(final AddCardProductResponse response) =
      _$_TransactionEstimated;

  AddCardProductResponse get response;
  @JsonKey(ignore: true)
  _$$_TransactionEstimatedCopyWith<_$_TransactionEstimated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_TransactionSavedCopyWith<$Res> {
  factory _$$_TransactionSavedCopyWith(
          _$_TransactionSaved value, $Res Function(_$_TransactionSaved) then) =
      __$$_TransactionSavedCopyWithImpl<$Res>;
  @useResult
  $Res call({DiscountCountResponse response});
}

/// @nodoc
class __$$_TransactionSavedCopyWithImpl<$Res>
    extends _$EstimateStateCopyWithImpl<$Res, _$_TransactionSaved>
    implements _$$_TransactionSavedCopyWith<$Res> {
  __$$_TransactionSavedCopyWithImpl(
      _$_TransactionSaved _value, $Res Function(_$_TransactionSaved) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$_TransactionSaved(
      null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as DiscountCountResponse,
    ));
  }
}

/// @nodoc

class _$_TransactionSaved implements _TransactionSaved {
  const _$_TransactionSaved(this.response);

  @override
  final DiscountCountResponse response;

  @override
  String toString() {
    return 'EstimateState.transactionSaved(response: $response)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionSaved &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionSavedCopyWith<_$_TransactionSaved> get copyWith =>
      __$$_TransactionSavedCopyWithImpl<_$_TransactionSaved>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() inProgress,
    required TResult Function(String message) error,
    required TResult Function(String message) invalidCoupon,
    required TResult Function(AddCardProductResponse response)
        transactionEstimated,
    required TResult Function(DiscountCountResponse response) transactionSaved,
  }) {
    return transactionSaved(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? inProgress,
    TResult? Function(String message)? error,
    TResult? Function(String message)? invalidCoupon,
    TResult? Function(AddCardProductResponse response)? transactionEstimated,
    TResult? Function(DiscountCountResponse response)? transactionSaved,
  }) {
    return transactionSaved?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inProgress,
    TResult Function(String message)? error,
    TResult Function(String message)? invalidCoupon,
    TResult Function(AddCardProductResponse response)? transactionEstimated,
    TResult Function(DiscountCountResponse response)? transactionSaved,
    required TResult orElse(),
  }) {
    if (transactionSaved != null) {
      return transactionSaved(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Error value) error,
    required TResult Function(_InvalidCoupon value) invalidCoupon,
    required TResult Function(_TransactionEstimated value) transactionEstimated,
    required TResult Function(_TransactionSaved value) transactionSaved,
  }) {
    return transactionSaved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Error value)? error,
    TResult? Function(_InvalidCoupon value)? invalidCoupon,
    TResult? Function(_TransactionEstimated value)? transactionEstimated,
    TResult? Function(_TransactionSaved value)? transactionSaved,
  }) {
    return transactionSaved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Error value)? error,
    TResult Function(_InvalidCoupon value)? invalidCoupon,
    TResult Function(_TransactionEstimated value)? transactionEstimated,
    TResult Function(_TransactionSaved value)? transactionSaved,
    required TResult orElse(),
  }) {
    if (transactionSaved != null) {
      return transactionSaved(this);
    }
    return orElse();
  }
}

abstract class _TransactionSaved implements EstimateState {
  const factory _TransactionSaved(final DiscountCountResponse response) =
      _$_TransactionSaved;

  DiscountCountResponse get response;
  @JsonKey(ignore: true)
  _$$_TransactionSavedCopyWith<_$_TransactionSaved> get copyWith =>
      throw _privateConstructorUsedError;
}
