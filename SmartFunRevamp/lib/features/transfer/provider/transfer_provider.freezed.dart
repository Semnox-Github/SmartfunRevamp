// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TransferState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() myCards,
    required TResult Function() othersCards,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? myCards,
    TResult? Function()? othersCards,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? myCards,
    TResult Function()? othersCards,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MyCard value) myCards,
    required TResult Function(_OtherCards value) othersCards,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MyCard value)? myCards,
    TResult? Function(_OtherCards value)? othersCards,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MyCard value)? myCards,
    TResult Function(_OtherCards value)? othersCards,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferStateCopyWith<$Res> {
  factory $TransferStateCopyWith(
          TransferState value, $Res Function(TransferState) then) =
      _$TransferStateCopyWithImpl<$Res, TransferState>;
}

/// @nodoc
class _$TransferStateCopyWithImpl<$Res, $Val extends TransferState>
    implements $TransferStateCopyWith<$Res> {
  _$TransferStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_MyCardCopyWith<$Res> {
  factory _$$_MyCardCopyWith(_$_MyCard value, $Res Function(_$_MyCard) then) =
      __$$_MyCardCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_MyCardCopyWithImpl<$Res>
    extends _$TransferStateCopyWithImpl<$Res, _$_MyCard>
    implements _$$_MyCardCopyWith<$Res> {
  __$$_MyCardCopyWithImpl(_$_MyCard _value, $Res Function(_$_MyCard) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_MyCard implements _MyCard {
  const _$_MyCard();

  @override
  String toString() {
    return 'TransferState.myCards()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_MyCard);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() myCards,
    required TResult Function() othersCards,
  }) {
    return myCards();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? myCards,
    TResult? Function()? othersCards,
  }) {
    return myCards?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? myCards,
    TResult Function()? othersCards,
    required TResult orElse(),
  }) {
    if (myCards != null) {
      return myCards();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MyCard value) myCards,
    required TResult Function(_OtherCards value) othersCards,
  }) {
    return myCards(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MyCard value)? myCards,
    TResult? Function(_OtherCards value)? othersCards,
  }) {
    return myCards?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MyCard value)? myCards,
    TResult Function(_OtherCards value)? othersCards,
    required TResult orElse(),
  }) {
    if (myCards != null) {
      return myCards(this);
    }
    return orElse();
  }
}

abstract class _MyCard implements TransferState {
  const factory _MyCard() = _$_MyCard;
}

/// @nodoc
abstract class _$$_OtherCardsCopyWith<$Res> {
  factory _$$_OtherCardsCopyWith(
          _$_OtherCards value, $Res Function(_$_OtherCards) then) =
      __$$_OtherCardsCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_OtherCardsCopyWithImpl<$Res>
    extends _$TransferStateCopyWithImpl<$Res, _$_OtherCards>
    implements _$$_OtherCardsCopyWith<$Res> {
  __$$_OtherCardsCopyWithImpl(
      _$_OtherCards _value, $Res Function(_$_OtherCards) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_OtherCards implements _OtherCards {
  const _$_OtherCards();

  @override
  String toString() {
    return 'TransferState.othersCards()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_OtherCards);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() myCards,
    required TResult Function() othersCards,
  }) {
    return othersCards();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? myCards,
    TResult? Function()? othersCards,
  }) {
    return othersCards?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? myCards,
    TResult Function()? othersCards,
    required TResult orElse(),
  }) {
    if (othersCards != null) {
      return othersCards();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MyCard value) myCards,
    required TResult Function(_OtherCards value) othersCards,
  }) {
    return othersCards(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MyCard value)? myCards,
    TResult? Function(_OtherCards value)? othersCards,
  }) {
    return othersCards?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MyCard value)? myCards,
    TResult Function(_OtherCards value)? othersCards,
    required TResult orElse(),
  }) {
    if (othersCards != null) {
      return othersCards(this);
    }
    return orElse();
  }
}

abstract class _OtherCards implements TransferState {
  const factory _OtherCards() = _$_OtherCards;
}
