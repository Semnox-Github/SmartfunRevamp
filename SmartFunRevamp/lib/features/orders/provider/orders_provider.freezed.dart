// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orders_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OrdersState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() inProgress,
    required TResult Function(List<OrderDetails> ordersSummary) success,
    required TResult Function(List<OrderStatus> customerUrdersStatus)
        successCustomerOrderStatus,
    required TResult Function(OrderDetails ordersSummaryDetails)
        successOrderDetail,
    required TResult Function() orderDetailInProgress,
    required TResult Function(String msg) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? inProgress,
    TResult? Function(List<OrderDetails> ordersSummary)? success,
    TResult? Function(List<OrderStatus> customerUrdersStatus)?
        successCustomerOrderStatus,
    TResult? Function(OrderDetails ordersSummaryDetails)? successOrderDetail,
    TResult? Function()? orderDetailInProgress,
    TResult? Function(String msg)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? inProgress,
    TResult Function(List<OrderDetails> ordersSummary)? success,
    TResult Function(List<OrderStatus> customerUrdersStatus)?
        successCustomerOrderStatus,
    TResult Function(OrderDetails ordersSummaryDetails)? successOrderDetail,
    TResult Function()? orderDetailInProgress,
    TResult Function(String msg)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Success value) success,
    required TResult Function(_SuccessCustomerOrderStatus value)
        successCustomerOrderStatus,
    required TResult Function(_SuccessOrderDetail value) successOrderDetail,
    required TResult Function(_OrderDetailInProgress value)
        orderDetailInProgress,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Success value)? success,
    TResult? Function(_SuccessCustomerOrderStatus value)?
        successCustomerOrderStatus,
    TResult? Function(_SuccessOrderDetail value)? successOrderDetail,
    TResult? Function(_OrderDetailInProgress value)? orderDetailInProgress,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Success value)? success,
    TResult Function(_SuccessCustomerOrderStatus value)?
        successCustomerOrderStatus,
    TResult Function(_SuccessOrderDetail value)? successOrderDetail,
    TResult Function(_OrderDetailInProgress value)? orderDetailInProgress,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrdersStateCopyWith<$Res> {
  factory $OrdersStateCopyWith(
          OrdersState value, $Res Function(OrdersState) then) =
      _$OrdersStateCopyWithImpl<$Res, OrdersState>;
}

/// @nodoc
class _$OrdersStateCopyWithImpl<$Res, $Val extends OrdersState>
    implements $OrdersStateCopyWith<$Res> {
  _$OrdersStateCopyWithImpl(this._value, this._then);

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
    extends _$OrdersStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'OrdersState.initial()';
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
    required TResult Function(List<OrderDetails> ordersSummary) success,
    required TResult Function(List<OrderStatus> customerUrdersStatus)
        successCustomerOrderStatus,
    required TResult Function(OrderDetails ordersSummaryDetails)
        successOrderDetail,
    required TResult Function() orderDetailInProgress,
    required TResult Function(String msg) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? inProgress,
    TResult? Function(List<OrderDetails> ordersSummary)? success,
    TResult? Function(List<OrderStatus> customerUrdersStatus)?
        successCustomerOrderStatus,
    TResult? Function(OrderDetails ordersSummaryDetails)? successOrderDetail,
    TResult? Function()? orderDetailInProgress,
    TResult? Function(String msg)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? inProgress,
    TResult Function(List<OrderDetails> ordersSummary)? success,
    TResult Function(List<OrderStatus> customerUrdersStatus)?
        successCustomerOrderStatus,
    TResult Function(OrderDetails ordersSummaryDetails)? successOrderDetail,
    TResult Function()? orderDetailInProgress,
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
    required TResult Function(_SuccessCustomerOrderStatus value)
        successCustomerOrderStatus,
    required TResult Function(_SuccessOrderDetail value) successOrderDetail,
    required TResult Function(_OrderDetailInProgress value)
        orderDetailInProgress,
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
    TResult? Function(_SuccessCustomerOrderStatus value)?
        successCustomerOrderStatus,
    TResult? Function(_SuccessOrderDetail value)? successOrderDetail,
    TResult? Function(_OrderDetailInProgress value)? orderDetailInProgress,
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
    TResult Function(_SuccessCustomerOrderStatus value)?
        successCustomerOrderStatus,
    TResult Function(_SuccessOrderDetail value)? successOrderDetail,
    TResult Function(_OrderDetailInProgress value)? orderDetailInProgress,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements OrdersState {
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
    extends _$OrdersStateCopyWithImpl<$Res, _$_InProgress>
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
    return 'OrdersState.inProgress()';
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
    required TResult Function(List<OrderDetails> ordersSummary) success,
    required TResult Function(List<OrderStatus> customerUrdersStatus)
        successCustomerOrderStatus,
    required TResult Function(OrderDetails ordersSummaryDetails)
        successOrderDetail,
    required TResult Function() orderDetailInProgress,
    required TResult Function(String msg) error,
  }) {
    return inProgress();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? inProgress,
    TResult? Function(List<OrderDetails> ordersSummary)? success,
    TResult? Function(List<OrderStatus> customerUrdersStatus)?
        successCustomerOrderStatus,
    TResult? Function(OrderDetails ordersSummaryDetails)? successOrderDetail,
    TResult? Function()? orderDetailInProgress,
    TResult? Function(String msg)? error,
  }) {
    return inProgress?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? inProgress,
    TResult Function(List<OrderDetails> ordersSummary)? success,
    TResult Function(List<OrderStatus> customerUrdersStatus)?
        successCustomerOrderStatus,
    TResult Function(OrderDetails ordersSummaryDetails)? successOrderDetail,
    TResult Function()? orderDetailInProgress,
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
    required TResult Function(_SuccessCustomerOrderStatus value)
        successCustomerOrderStatus,
    required TResult Function(_SuccessOrderDetail value) successOrderDetail,
    required TResult Function(_OrderDetailInProgress value)
        orderDetailInProgress,
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
    TResult? Function(_SuccessCustomerOrderStatus value)?
        successCustomerOrderStatus,
    TResult? Function(_SuccessOrderDetail value)? successOrderDetail,
    TResult? Function(_OrderDetailInProgress value)? orderDetailInProgress,
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
    TResult Function(_SuccessCustomerOrderStatus value)?
        successCustomerOrderStatus,
    TResult Function(_SuccessOrderDetail value)? successOrderDetail,
    TResult Function(_OrderDetailInProgress value)? orderDetailInProgress,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress(this);
    }
    return orElse();
  }
}

abstract class _InProgress implements OrdersState {
  const factory _InProgress() = _$_InProgress;
}

/// @nodoc
abstract class _$$_SuccessCopyWith<$Res> {
  factory _$$_SuccessCopyWith(
          _$_Success value, $Res Function(_$_Success) then) =
      __$$_SuccessCopyWithImpl<$Res>;
  @useResult
  $Res call({List<OrderDetails> ordersSummary});
}

/// @nodoc
class __$$_SuccessCopyWithImpl<$Res>
    extends _$OrdersStateCopyWithImpl<$Res, _$_Success>
    implements _$$_SuccessCopyWith<$Res> {
  __$$_SuccessCopyWithImpl(_$_Success _value, $Res Function(_$_Success) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ordersSummary = null,
  }) {
    return _then(_$_Success(
      null == ordersSummary
          ? _value._ordersSummary
          : ordersSummary // ignore: cast_nullable_to_non_nullable
              as List<OrderDetails>,
    ));
  }
}

/// @nodoc

class _$_Success implements _Success {
  const _$_Success(final List<OrderDetails> ordersSummary)
      : _ordersSummary = ordersSummary;

  final List<OrderDetails> _ordersSummary;
  @override
  List<OrderDetails> get ordersSummary {
    if (_ordersSummary is EqualUnmodifiableListView) return _ordersSummary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ordersSummary);
  }

  @override
  String toString() {
    return 'OrdersState.success(ordersSummary: $ordersSummary)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Success &&
            const DeepCollectionEquality()
                .equals(other._ordersSummary, _ordersSummary));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_ordersSummary));

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
    required TResult Function(List<OrderDetails> ordersSummary) success,
    required TResult Function(List<OrderStatus> customerUrdersStatus)
        successCustomerOrderStatus,
    required TResult Function(OrderDetails ordersSummaryDetails)
        successOrderDetail,
    required TResult Function() orderDetailInProgress,
    required TResult Function(String msg) error,
  }) {
    return success(ordersSummary);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? inProgress,
    TResult? Function(List<OrderDetails> ordersSummary)? success,
    TResult? Function(List<OrderStatus> customerUrdersStatus)?
        successCustomerOrderStatus,
    TResult? Function(OrderDetails ordersSummaryDetails)? successOrderDetail,
    TResult? Function()? orderDetailInProgress,
    TResult? Function(String msg)? error,
  }) {
    return success?.call(ordersSummary);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? inProgress,
    TResult Function(List<OrderDetails> ordersSummary)? success,
    TResult Function(List<OrderStatus> customerUrdersStatus)?
        successCustomerOrderStatus,
    TResult Function(OrderDetails ordersSummaryDetails)? successOrderDetail,
    TResult Function()? orderDetailInProgress,
    TResult Function(String msg)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(ordersSummary);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Success value) success,
    required TResult Function(_SuccessCustomerOrderStatus value)
        successCustomerOrderStatus,
    required TResult Function(_SuccessOrderDetail value) successOrderDetail,
    required TResult Function(_OrderDetailInProgress value)
        orderDetailInProgress,
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
    TResult? Function(_SuccessCustomerOrderStatus value)?
        successCustomerOrderStatus,
    TResult? Function(_SuccessOrderDetail value)? successOrderDetail,
    TResult? Function(_OrderDetailInProgress value)? orderDetailInProgress,
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
    TResult Function(_SuccessCustomerOrderStatus value)?
        successCustomerOrderStatus,
    TResult Function(_SuccessOrderDetail value)? successOrderDetail,
    TResult Function(_OrderDetailInProgress value)? orderDetailInProgress,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements OrdersState {
  const factory _Success(final List<OrderDetails> ordersSummary) = _$_Success;

  List<OrderDetails> get ordersSummary;
  @JsonKey(ignore: true)
  _$$_SuccessCopyWith<_$_Success> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_SuccessCustomerOrderStatusCopyWith<$Res> {
  factory _$$_SuccessCustomerOrderStatusCopyWith(
          _$_SuccessCustomerOrderStatus value,
          $Res Function(_$_SuccessCustomerOrderStatus) then) =
      __$$_SuccessCustomerOrderStatusCopyWithImpl<$Res>;
  @useResult
  $Res call({List<OrderStatus> customerUrdersStatus});
}

/// @nodoc
class __$$_SuccessCustomerOrderStatusCopyWithImpl<$Res>
    extends _$OrdersStateCopyWithImpl<$Res, _$_SuccessCustomerOrderStatus>
    implements _$$_SuccessCustomerOrderStatusCopyWith<$Res> {
  __$$_SuccessCustomerOrderStatusCopyWithImpl(
      _$_SuccessCustomerOrderStatus _value,
      $Res Function(_$_SuccessCustomerOrderStatus) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerUrdersStatus = null,
  }) {
    return _then(_$_SuccessCustomerOrderStatus(
      null == customerUrdersStatus
          ? _value._customerUrdersStatus
          : customerUrdersStatus // ignore: cast_nullable_to_non_nullable
              as List<OrderStatus>,
    ));
  }
}

/// @nodoc

class _$_SuccessCustomerOrderStatus implements _SuccessCustomerOrderStatus {
  const _$_SuccessCustomerOrderStatus(
      final List<OrderStatus> customerUrdersStatus)
      : _customerUrdersStatus = customerUrdersStatus;

  final List<OrderStatus> _customerUrdersStatus;
  @override
  List<OrderStatus> get customerUrdersStatus {
    if (_customerUrdersStatus is EqualUnmodifiableListView)
      return _customerUrdersStatus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_customerUrdersStatus);
  }

  @override
  String toString() {
    return 'OrdersState.successCustomerOrderStatus(customerUrdersStatus: $customerUrdersStatus)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SuccessCustomerOrderStatus &&
            const DeepCollectionEquality()
                .equals(other._customerUrdersStatus, _customerUrdersStatus));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_customerUrdersStatus));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SuccessCustomerOrderStatusCopyWith<_$_SuccessCustomerOrderStatus>
      get copyWith => __$$_SuccessCustomerOrderStatusCopyWithImpl<
          _$_SuccessCustomerOrderStatus>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() inProgress,
    required TResult Function(List<OrderDetails> ordersSummary) success,
    required TResult Function(List<OrderStatus> customerUrdersStatus)
        successCustomerOrderStatus,
    required TResult Function(OrderDetails ordersSummaryDetails)
        successOrderDetail,
    required TResult Function() orderDetailInProgress,
    required TResult Function(String msg) error,
  }) {
    return successCustomerOrderStatus(customerUrdersStatus);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? inProgress,
    TResult? Function(List<OrderDetails> ordersSummary)? success,
    TResult? Function(List<OrderStatus> customerUrdersStatus)?
        successCustomerOrderStatus,
    TResult? Function(OrderDetails ordersSummaryDetails)? successOrderDetail,
    TResult? Function()? orderDetailInProgress,
    TResult? Function(String msg)? error,
  }) {
    return successCustomerOrderStatus?.call(customerUrdersStatus);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? inProgress,
    TResult Function(List<OrderDetails> ordersSummary)? success,
    TResult Function(List<OrderStatus> customerUrdersStatus)?
        successCustomerOrderStatus,
    TResult Function(OrderDetails ordersSummaryDetails)? successOrderDetail,
    TResult Function()? orderDetailInProgress,
    TResult Function(String msg)? error,
    required TResult orElse(),
  }) {
    if (successCustomerOrderStatus != null) {
      return successCustomerOrderStatus(customerUrdersStatus);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Success value) success,
    required TResult Function(_SuccessCustomerOrderStatus value)
        successCustomerOrderStatus,
    required TResult Function(_SuccessOrderDetail value) successOrderDetail,
    required TResult Function(_OrderDetailInProgress value)
        orderDetailInProgress,
    required TResult Function(_Error value) error,
  }) {
    return successCustomerOrderStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Success value)? success,
    TResult? Function(_SuccessCustomerOrderStatus value)?
        successCustomerOrderStatus,
    TResult? Function(_SuccessOrderDetail value)? successOrderDetail,
    TResult? Function(_OrderDetailInProgress value)? orderDetailInProgress,
    TResult? Function(_Error value)? error,
  }) {
    return successCustomerOrderStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Success value)? success,
    TResult Function(_SuccessCustomerOrderStatus value)?
        successCustomerOrderStatus,
    TResult Function(_SuccessOrderDetail value)? successOrderDetail,
    TResult Function(_OrderDetailInProgress value)? orderDetailInProgress,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (successCustomerOrderStatus != null) {
      return successCustomerOrderStatus(this);
    }
    return orElse();
  }
}

abstract class _SuccessCustomerOrderStatus implements OrdersState {
  const factory _SuccessCustomerOrderStatus(
          final List<OrderStatus> customerUrdersStatus) =
      _$_SuccessCustomerOrderStatus;

  List<OrderStatus> get customerUrdersStatus;
  @JsonKey(ignore: true)
  _$$_SuccessCustomerOrderStatusCopyWith<_$_SuccessCustomerOrderStatus>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_SuccessOrderDetailCopyWith<$Res> {
  factory _$$_SuccessOrderDetailCopyWith(_$_SuccessOrderDetail value,
          $Res Function(_$_SuccessOrderDetail) then) =
      __$$_SuccessOrderDetailCopyWithImpl<$Res>;
  @useResult
  $Res call({OrderDetails ordersSummaryDetails});
}

/// @nodoc
class __$$_SuccessOrderDetailCopyWithImpl<$Res>
    extends _$OrdersStateCopyWithImpl<$Res, _$_SuccessOrderDetail>
    implements _$$_SuccessOrderDetailCopyWith<$Res> {
  __$$_SuccessOrderDetailCopyWithImpl(
      _$_SuccessOrderDetail _value, $Res Function(_$_SuccessOrderDetail) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ordersSummaryDetails = null,
  }) {
    return _then(_$_SuccessOrderDetail(
      null == ordersSummaryDetails
          ? _value.ordersSummaryDetails
          : ordersSummaryDetails // ignore: cast_nullable_to_non_nullable
              as OrderDetails,
    ));
  }
}

/// @nodoc

class _$_SuccessOrderDetail implements _SuccessOrderDetail {
  const _$_SuccessOrderDetail(this.ordersSummaryDetails);

  @override
  final OrderDetails ordersSummaryDetails;

  @override
  String toString() {
    return 'OrdersState.successOrderDetail(ordersSummaryDetails: $ordersSummaryDetails)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SuccessOrderDetail &&
            (identical(other.ordersSummaryDetails, ordersSummaryDetails) ||
                other.ordersSummaryDetails == ordersSummaryDetails));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ordersSummaryDetails);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SuccessOrderDetailCopyWith<_$_SuccessOrderDetail> get copyWith =>
      __$$_SuccessOrderDetailCopyWithImpl<_$_SuccessOrderDetail>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() inProgress,
    required TResult Function(List<OrderDetails> ordersSummary) success,
    required TResult Function(List<OrderStatus> customerUrdersStatus)
        successCustomerOrderStatus,
    required TResult Function(OrderDetails ordersSummaryDetails)
        successOrderDetail,
    required TResult Function() orderDetailInProgress,
    required TResult Function(String msg) error,
  }) {
    return successOrderDetail(ordersSummaryDetails);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? inProgress,
    TResult? Function(List<OrderDetails> ordersSummary)? success,
    TResult? Function(List<OrderStatus> customerUrdersStatus)?
        successCustomerOrderStatus,
    TResult? Function(OrderDetails ordersSummaryDetails)? successOrderDetail,
    TResult? Function()? orderDetailInProgress,
    TResult? Function(String msg)? error,
  }) {
    return successOrderDetail?.call(ordersSummaryDetails);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? inProgress,
    TResult Function(List<OrderDetails> ordersSummary)? success,
    TResult Function(List<OrderStatus> customerUrdersStatus)?
        successCustomerOrderStatus,
    TResult Function(OrderDetails ordersSummaryDetails)? successOrderDetail,
    TResult Function()? orderDetailInProgress,
    TResult Function(String msg)? error,
    required TResult orElse(),
  }) {
    if (successOrderDetail != null) {
      return successOrderDetail(ordersSummaryDetails);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Success value) success,
    required TResult Function(_SuccessCustomerOrderStatus value)
        successCustomerOrderStatus,
    required TResult Function(_SuccessOrderDetail value) successOrderDetail,
    required TResult Function(_OrderDetailInProgress value)
        orderDetailInProgress,
    required TResult Function(_Error value) error,
  }) {
    return successOrderDetail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Success value)? success,
    TResult? Function(_SuccessCustomerOrderStatus value)?
        successCustomerOrderStatus,
    TResult? Function(_SuccessOrderDetail value)? successOrderDetail,
    TResult? Function(_OrderDetailInProgress value)? orderDetailInProgress,
    TResult? Function(_Error value)? error,
  }) {
    return successOrderDetail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Success value)? success,
    TResult Function(_SuccessCustomerOrderStatus value)?
        successCustomerOrderStatus,
    TResult Function(_SuccessOrderDetail value)? successOrderDetail,
    TResult Function(_OrderDetailInProgress value)? orderDetailInProgress,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (successOrderDetail != null) {
      return successOrderDetail(this);
    }
    return orElse();
  }
}

abstract class _SuccessOrderDetail implements OrdersState {
  const factory _SuccessOrderDetail(final OrderDetails ordersSummaryDetails) =
      _$_SuccessOrderDetail;

  OrderDetails get ordersSummaryDetails;
  @JsonKey(ignore: true)
  _$$_SuccessOrderDetailCopyWith<_$_SuccessOrderDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_OrderDetailInProgressCopyWith<$Res> {
  factory _$$_OrderDetailInProgressCopyWith(_$_OrderDetailInProgress value,
          $Res Function(_$_OrderDetailInProgress) then) =
      __$$_OrderDetailInProgressCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_OrderDetailInProgressCopyWithImpl<$Res>
    extends _$OrdersStateCopyWithImpl<$Res, _$_OrderDetailInProgress>
    implements _$$_OrderDetailInProgressCopyWith<$Res> {
  __$$_OrderDetailInProgressCopyWithImpl(_$_OrderDetailInProgress _value,
      $Res Function(_$_OrderDetailInProgress) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_OrderDetailInProgress implements _OrderDetailInProgress {
  const _$_OrderDetailInProgress();

  @override
  String toString() {
    return 'OrdersState.orderDetailInProgress()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_OrderDetailInProgress);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() inProgress,
    required TResult Function(List<OrderDetails> ordersSummary) success,
    required TResult Function(List<OrderStatus> customerUrdersStatus)
        successCustomerOrderStatus,
    required TResult Function(OrderDetails ordersSummaryDetails)
        successOrderDetail,
    required TResult Function() orderDetailInProgress,
    required TResult Function(String msg) error,
  }) {
    return orderDetailInProgress();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? inProgress,
    TResult? Function(List<OrderDetails> ordersSummary)? success,
    TResult? Function(List<OrderStatus> customerUrdersStatus)?
        successCustomerOrderStatus,
    TResult? Function(OrderDetails ordersSummaryDetails)? successOrderDetail,
    TResult? Function()? orderDetailInProgress,
    TResult? Function(String msg)? error,
  }) {
    return orderDetailInProgress?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? inProgress,
    TResult Function(List<OrderDetails> ordersSummary)? success,
    TResult Function(List<OrderStatus> customerUrdersStatus)?
        successCustomerOrderStatus,
    TResult Function(OrderDetails ordersSummaryDetails)? successOrderDetail,
    TResult Function()? orderDetailInProgress,
    TResult Function(String msg)? error,
    required TResult orElse(),
  }) {
    if (orderDetailInProgress != null) {
      return orderDetailInProgress();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Success value) success,
    required TResult Function(_SuccessCustomerOrderStatus value)
        successCustomerOrderStatus,
    required TResult Function(_SuccessOrderDetail value) successOrderDetail,
    required TResult Function(_OrderDetailInProgress value)
        orderDetailInProgress,
    required TResult Function(_Error value) error,
  }) {
    return orderDetailInProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Success value)? success,
    TResult? Function(_SuccessCustomerOrderStatus value)?
        successCustomerOrderStatus,
    TResult? Function(_SuccessOrderDetail value)? successOrderDetail,
    TResult? Function(_OrderDetailInProgress value)? orderDetailInProgress,
    TResult? Function(_Error value)? error,
  }) {
    return orderDetailInProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Success value)? success,
    TResult Function(_SuccessCustomerOrderStatus value)?
        successCustomerOrderStatus,
    TResult Function(_SuccessOrderDetail value)? successOrderDetail,
    TResult Function(_OrderDetailInProgress value)? orderDetailInProgress,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (orderDetailInProgress != null) {
      return orderDetailInProgress(this);
    }
    return orElse();
  }
}

abstract class _OrderDetailInProgress implements OrdersState {
  const factory _OrderDetailInProgress() = _$_OrderDetailInProgress;
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
    extends _$OrdersStateCopyWithImpl<$Res, _$_Error>
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
    return 'OrdersState.error(msg: $msg)';
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
    required TResult Function(List<OrderDetails> ordersSummary) success,
    required TResult Function(List<OrderStatus> customerUrdersStatus)
        successCustomerOrderStatus,
    required TResult Function(OrderDetails ordersSummaryDetails)
        successOrderDetail,
    required TResult Function() orderDetailInProgress,
    required TResult Function(String msg) error,
  }) {
    return error(msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? inProgress,
    TResult? Function(List<OrderDetails> ordersSummary)? success,
    TResult? Function(List<OrderStatus> customerUrdersStatus)?
        successCustomerOrderStatus,
    TResult? Function(OrderDetails ordersSummaryDetails)? successOrderDetail,
    TResult? Function()? orderDetailInProgress,
    TResult? Function(String msg)? error,
  }) {
    return error?.call(msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? inProgress,
    TResult Function(List<OrderDetails> ordersSummary)? success,
    TResult Function(List<OrderStatus> customerUrdersStatus)?
        successCustomerOrderStatus,
    TResult Function(OrderDetails ordersSummaryDetails)? successOrderDetail,
    TResult Function()? orderDetailInProgress,
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
    required TResult Function(_SuccessCustomerOrderStatus value)
        successCustomerOrderStatus,
    required TResult Function(_SuccessOrderDetail value) successOrderDetail,
    required TResult Function(_OrderDetailInProgress value)
        orderDetailInProgress,
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
    TResult? Function(_SuccessCustomerOrderStatus value)?
        successCustomerOrderStatus,
    TResult? Function(_SuccessOrderDetail value)? successOrderDetail,
    TResult? Function(_OrderDetailInProgress value)? orderDetailInProgress,
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
    TResult Function(_SuccessCustomerOrderStatus value)?
        successCustomerOrderStatus,
    TResult Function(_SuccessOrderDetail value)? successOrderDetail,
    TResult Function(_OrderDetailInProgress value)? orderDetailInProgress,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements OrdersState {
  const factory _Error(final String msg) = _$_Error;

  String get msg;
  @JsonKey(ignore: true)
  _$$_ErrorCopyWith<_$_Error> get copyWith =>
      throw _privateConstructorUsedError;
}
