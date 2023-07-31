// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'buy_card_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BuyCardState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() inProgress,
    required TResult Function(List<CardProduct> cards) success,
    required TResult Function(String message) error,
    required TResult Function() estimatingTransaction,
    required TResult Function(EstimateTransactionResponse response)
        transactionEstimated,
    required TResult Function(String msg) estimationError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? inProgress,
    TResult? Function(List<CardProduct> cards)? success,
    TResult? Function(String message)? error,
    TResult? Function()? estimatingTransaction,
    TResult? Function(EstimateTransactionResponse response)?
        transactionEstimated,
    TResult? Function(String msg)? estimationError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inProgress,
    TResult Function(List<CardProduct> cards)? success,
    TResult Function(String message)? error,
    TResult Function()? estimatingTransaction,
    TResult Function(EstimateTransactionResponse response)?
        transactionEstimated,
    TResult Function(String msg)? estimationError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_EstimatingTransaction value)
        estimatingTransaction,
    required TResult Function(_TransactionEstimated value) transactionEstimated,
    required TResult Function(_EstimationError value) estimationError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_EstimatingTransaction value)? estimatingTransaction,
    TResult? Function(_TransactionEstimated value)? transactionEstimated,
    TResult? Function(_EstimationError value)? estimationError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_EstimatingTransaction value)? estimatingTransaction,
    TResult Function(_TransactionEstimated value)? transactionEstimated,
    TResult Function(_EstimationError value)? estimationError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuyCardStateCopyWith<$Res> {
  factory $BuyCardStateCopyWith(
          BuyCardState value, $Res Function(BuyCardState) then) =
      _$BuyCardStateCopyWithImpl<$Res, BuyCardState>;
}

/// @nodoc
class _$BuyCardStateCopyWithImpl<$Res, $Val extends BuyCardState>
    implements $BuyCardStateCopyWith<$Res> {
  _$BuyCardStateCopyWithImpl(this._value, this._then);

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
    extends _$BuyCardStateCopyWithImpl<$Res, _$_InProgress>
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
    return 'BuyCardState.inProgress()';
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
    required TResult Function(List<CardProduct> cards) success,
    required TResult Function(String message) error,
    required TResult Function() estimatingTransaction,
    required TResult Function(EstimateTransactionResponse response)
        transactionEstimated,
    required TResult Function(String msg) estimationError,
  }) {
    return inProgress();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? inProgress,
    TResult? Function(List<CardProduct> cards)? success,
    TResult? Function(String message)? error,
    TResult? Function()? estimatingTransaction,
    TResult? Function(EstimateTransactionResponse response)?
        transactionEstimated,
    TResult? Function(String msg)? estimationError,
  }) {
    return inProgress?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inProgress,
    TResult Function(List<CardProduct> cards)? success,
    TResult Function(String message)? error,
    TResult Function()? estimatingTransaction,
    TResult Function(EstimateTransactionResponse response)?
        transactionEstimated,
    TResult Function(String msg)? estimationError,
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
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_EstimatingTransaction value)
        estimatingTransaction,
    required TResult Function(_TransactionEstimated value) transactionEstimated,
    required TResult Function(_EstimationError value) estimationError,
  }) {
    return inProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_EstimatingTransaction value)? estimatingTransaction,
    TResult? Function(_TransactionEstimated value)? transactionEstimated,
    TResult? Function(_EstimationError value)? estimationError,
  }) {
    return inProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_EstimatingTransaction value)? estimatingTransaction,
    TResult Function(_TransactionEstimated value)? transactionEstimated,
    TResult Function(_EstimationError value)? estimationError,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress(this);
    }
    return orElse();
  }
}

abstract class _InProgress implements BuyCardState {
  const factory _InProgress() = _$_InProgress;
}

/// @nodoc
abstract class _$$_SuccessCopyWith<$Res> {
  factory _$$_SuccessCopyWith(
          _$_Success value, $Res Function(_$_Success) then) =
      __$$_SuccessCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CardProduct> cards});
}

/// @nodoc
class __$$_SuccessCopyWithImpl<$Res>
    extends _$BuyCardStateCopyWithImpl<$Res, _$_Success>
    implements _$$_SuccessCopyWith<$Res> {
  __$$_SuccessCopyWithImpl(_$_Success _value, $Res Function(_$_Success) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
  }) {
    return _then(_$_Success(
      null == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<CardProduct>,
    ));
  }
}

/// @nodoc

class _$_Success implements _Success {
  const _$_Success(final List<CardProduct> cards) : _cards = cards;

  final List<CardProduct> _cards;
  @override
  List<CardProduct> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  String toString() {
    return 'BuyCardState.success(cards: $cards)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Success &&
            const DeepCollectionEquality().equals(other._cards, _cards));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_cards));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SuccessCopyWith<_$_Success> get copyWith =>
      __$$_SuccessCopyWithImpl<_$_Success>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() inProgress,
    required TResult Function(List<CardProduct> cards) success,
    required TResult Function(String message) error,
    required TResult Function() estimatingTransaction,
    required TResult Function(EstimateTransactionResponse response)
        transactionEstimated,
    required TResult Function(String msg) estimationError,
  }) {
    return success(cards);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? inProgress,
    TResult? Function(List<CardProduct> cards)? success,
    TResult? Function(String message)? error,
    TResult? Function()? estimatingTransaction,
    TResult? Function(EstimateTransactionResponse response)?
        transactionEstimated,
    TResult? Function(String msg)? estimationError,
  }) {
    return success?.call(cards);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inProgress,
    TResult Function(List<CardProduct> cards)? success,
    TResult Function(String message)? error,
    TResult Function()? estimatingTransaction,
    TResult Function(EstimateTransactionResponse response)?
        transactionEstimated,
    TResult Function(String msg)? estimationError,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(cards);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_EstimatingTransaction value)
        estimatingTransaction,
    required TResult Function(_TransactionEstimated value) transactionEstimated,
    required TResult Function(_EstimationError value) estimationError,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_EstimatingTransaction value)? estimatingTransaction,
    TResult? Function(_TransactionEstimated value)? transactionEstimated,
    TResult? Function(_EstimationError value)? estimationError,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_EstimatingTransaction value)? estimatingTransaction,
    TResult Function(_TransactionEstimated value)? transactionEstimated,
    TResult Function(_EstimationError value)? estimationError,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements BuyCardState {
  const factory _Success(final List<CardProduct> cards) = _$_Success;

  List<CardProduct> get cards;
  @JsonKey(ignore: true)
  _$$_SuccessCopyWith<_$_Success> get copyWith =>
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
    extends _$BuyCardStateCopyWithImpl<$Res, _$_Error>
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
    return 'BuyCardState.error(message: $message)';
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
    required TResult Function(List<CardProduct> cards) success,
    required TResult Function(String message) error,
    required TResult Function() estimatingTransaction,
    required TResult Function(EstimateTransactionResponse response)
        transactionEstimated,
    required TResult Function(String msg) estimationError,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? inProgress,
    TResult? Function(List<CardProduct> cards)? success,
    TResult? Function(String message)? error,
    TResult? Function()? estimatingTransaction,
    TResult? Function(EstimateTransactionResponse response)?
        transactionEstimated,
    TResult? Function(String msg)? estimationError,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inProgress,
    TResult Function(List<CardProduct> cards)? success,
    TResult Function(String message)? error,
    TResult Function()? estimatingTransaction,
    TResult Function(EstimateTransactionResponse response)?
        transactionEstimated,
    TResult Function(String msg)? estimationError,
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
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_EstimatingTransaction value)
        estimatingTransaction,
    required TResult Function(_TransactionEstimated value) transactionEstimated,
    required TResult Function(_EstimationError value) estimationError,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_EstimatingTransaction value)? estimatingTransaction,
    TResult? Function(_TransactionEstimated value)? transactionEstimated,
    TResult? Function(_EstimationError value)? estimationError,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_EstimatingTransaction value)? estimatingTransaction,
    TResult Function(_TransactionEstimated value)? transactionEstimated,
    TResult Function(_EstimationError value)? estimationError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements BuyCardState {
  const factory _Error(final String message) = _$_Error;

  String get message;
  @JsonKey(ignore: true)
  _$$_ErrorCopyWith<_$_Error> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_EstimatingTransactionCopyWith<$Res> {
  factory _$$_EstimatingTransactionCopyWith(_$_EstimatingTransaction value,
          $Res Function(_$_EstimatingTransaction) then) =
      __$$_EstimatingTransactionCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_EstimatingTransactionCopyWithImpl<$Res>
    extends _$BuyCardStateCopyWithImpl<$Res, _$_EstimatingTransaction>
    implements _$$_EstimatingTransactionCopyWith<$Res> {
  __$$_EstimatingTransactionCopyWithImpl(_$_EstimatingTransaction _value,
      $Res Function(_$_EstimatingTransaction) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_EstimatingTransaction implements _EstimatingTransaction {
  const _$_EstimatingTransaction();

  @override
  String toString() {
    return 'BuyCardState.estimatingTransaction()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_EstimatingTransaction);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() inProgress,
    required TResult Function(List<CardProduct> cards) success,
    required TResult Function(String message) error,
    required TResult Function() estimatingTransaction,
    required TResult Function(EstimateTransactionResponse response)
        transactionEstimated,
    required TResult Function(String msg) estimationError,
  }) {
    return estimatingTransaction();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? inProgress,
    TResult? Function(List<CardProduct> cards)? success,
    TResult? Function(String message)? error,
    TResult? Function()? estimatingTransaction,
    TResult? Function(EstimateTransactionResponse response)?
        transactionEstimated,
    TResult? Function(String msg)? estimationError,
  }) {
    return estimatingTransaction?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inProgress,
    TResult Function(List<CardProduct> cards)? success,
    TResult Function(String message)? error,
    TResult Function()? estimatingTransaction,
    TResult Function(EstimateTransactionResponse response)?
        transactionEstimated,
    TResult Function(String msg)? estimationError,
    required TResult orElse(),
  }) {
    if (estimatingTransaction != null) {
      return estimatingTransaction();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_EstimatingTransaction value)
        estimatingTransaction,
    required TResult Function(_TransactionEstimated value) transactionEstimated,
    required TResult Function(_EstimationError value) estimationError,
  }) {
    return estimatingTransaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_EstimatingTransaction value)? estimatingTransaction,
    TResult? Function(_TransactionEstimated value)? transactionEstimated,
    TResult? Function(_EstimationError value)? estimationError,
  }) {
    return estimatingTransaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_EstimatingTransaction value)? estimatingTransaction,
    TResult Function(_TransactionEstimated value)? transactionEstimated,
    TResult Function(_EstimationError value)? estimationError,
    required TResult orElse(),
  }) {
    if (estimatingTransaction != null) {
      return estimatingTransaction(this);
    }
    return orElse();
  }
}

abstract class _EstimatingTransaction implements BuyCardState {
  const factory _EstimatingTransaction() = _$_EstimatingTransaction;
}

/// @nodoc
abstract class _$$_TransactionEstimatedCopyWith<$Res> {
  factory _$$_TransactionEstimatedCopyWith(_$_TransactionEstimated value,
          $Res Function(_$_TransactionEstimated) then) =
      __$$_TransactionEstimatedCopyWithImpl<$Res>;
  @useResult
  $Res call({EstimateTransactionResponse response});
}

/// @nodoc
class __$$_TransactionEstimatedCopyWithImpl<$Res>
    extends _$BuyCardStateCopyWithImpl<$Res, _$_TransactionEstimated>
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
              as EstimateTransactionResponse,
    ));
  }
}

/// @nodoc

class _$_TransactionEstimated implements _TransactionEstimated {
  const _$_TransactionEstimated(this.response);

  @override
  final EstimateTransactionResponse response;

  @override
  String toString() {
    return 'BuyCardState.transactionEstimated(response: $response)';
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
    required TResult Function(List<CardProduct> cards) success,
    required TResult Function(String message) error,
    required TResult Function() estimatingTransaction,
    required TResult Function(EstimateTransactionResponse response)
        transactionEstimated,
    required TResult Function(String msg) estimationError,
  }) {
    return transactionEstimated(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? inProgress,
    TResult? Function(List<CardProduct> cards)? success,
    TResult? Function(String message)? error,
    TResult? Function()? estimatingTransaction,
    TResult? Function(EstimateTransactionResponse response)?
        transactionEstimated,
    TResult? Function(String msg)? estimationError,
  }) {
    return transactionEstimated?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inProgress,
    TResult Function(List<CardProduct> cards)? success,
    TResult Function(String message)? error,
    TResult Function()? estimatingTransaction,
    TResult Function(EstimateTransactionResponse response)?
        transactionEstimated,
    TResult Function(String msg)? estimationError,
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
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_EstimatingTransaction value)
        estimatingTransaction,
    required TResult Function(_TransactionEstimated value) transactionEstimated,
    required TResult Function(_EstimationError value) estimationError,
  }) {
    return transactionEstimated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_EstimatingTransaction value)? estimatingTransaction,
    TResult? Function(_TransactionEstimated value)? transactionEstimated,
    TResult? Function(_EstimationError value)? estimationError,
  }) {
    return transactionEstimated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_EstimatingTransaction value)? estimatingTransaction,
    TResult Function(_TransactionEstimated value)? transactionEstimated,
    TResult Function(_EstimationError value)? estimationError,
    required TResult orElse(),
  }) {
    if (transactionEstimated != null) {
      return transactionEstimated(this);
    }
    return orElse();
  }
}

abstract class _TransactionEstimated implements BuyCardState {
  const factory _TransactionEstimated(
      final EstimateTransactionResponse response) = _$_TransactionEstimated;

  EstimateTransactionResponse get response;
  @JsonKey(ignore: true)
  _$$_TransactionEstimatedCopyWith<_$_TransactionEstimated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_EstimationErrorCopyWith<$Res> {
  factory _$$_EstimationErrorCopyWith(
          _$_EstimationError value, $Res Function(_$_EstimationError) then) =
      __$$_EstimationErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String msg});
}

/// @nodoc
class __$$_EstimationErrorCopyWithImpl<$Res>
    extends _$BuyCardStateCopyWithImpl<$Res, _$_EstimationError>
    implements _$$_EstimationErrorCopyWith<$Res> {
  __$$_EstimationErrorCopyWithImpl(
      _$_EstimationError _value, $Res Function(_$_EstimationError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = null,
  }) {
    return _then(_$_EstimationError(
      null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_EstimationError implements _EstimationError {
  const _$_EstimationError(this.msg);

  @override
  final String msg;

  @override
  String toString() {
    return 'BuyCardState.estimationError(msg: $msg)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EstimationError &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EstimationErrorCopyWith<_$_EstimationError> get copyWith =>
      __$$_EstimationErrorCopyWithImpl<_$_EstimationError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() inProgress,
    required TResult Function(List<CardProduct> cards) success,
    required TResult Function(String message) error,
    required TResult Function() estimatingTransaction,
    required TResult Function(EstimateTransactionResponse response)
        transactionEstimated,
    required TResult Function(String msg) estimationError,
  }) {
    return estimationError(msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? inProgress,
    TResult? Function(List<CardProduct> cards)? success,
    TResult? Function(String message)? error,
    TResult? Function()? estimatingTransaction,
    TResult? Function(EstimateTransactionResponse response)?
        transactionEstimated,
    TResult? Function(String msg)? estimationError,
  }) {
    return estimationError?.call(msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inProgress,
    TResult Function(List<CardProduct> cards)? success,
    TResult Function(String message)? error,
    TResult Function()? estimatingTransaction,
    TResult Function(EstimateTransactionResponse response)?
        transactionEstimated,
    TResult Function(String msg)? estimationError,
    required TResult orElse(),
  }) {
    if (estimationError != null) {
      return estimationError(msg);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_EstimatingTransaction value)
        estimatingTransaction,
    required TResult Function(_TransactionEstimated value) transactionEstimated,
    required TResult Function(_EstimationError value) estimationError,
  }) {
    return estimationError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_EstimatingTransaction value)? estimatingTransaction,
    TResult? Function(_TransactionEstimated value)? transactionEstimated,
    TResult? Function(_EstimationError value)? estimationError,
  }) {
    return estimationError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_EstimatingTransaction value)? estimatingTransaction,
    TResult Function(_TransactionEstimated value)? transactionEstimated,
    TResult Function(_EstimationError value)? estimationError,
    required TResult orElse(),
  }) {
    if (estimationError != null) {
      return estimationError(this);
    }
    return orElse();
  }
}

abstract class _EstimationError implements BuyCardState {
  const factory _EstimationError(final String msg) = _$_EstimationError;

  String get msg;
  @JsonKey(ignore: true)
  _$$_EstimationErrorCopyWith<_$_EstimationError> get copyWith =>
      throw _privateConstructorUsedError;
}
