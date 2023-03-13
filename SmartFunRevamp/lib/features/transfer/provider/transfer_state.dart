part of 'transfer_provider.dart';

@freezed
class TransferState with _$TransferState {
  const factory TransferState.myCards() = _MyCard;
  const factory TransferState.othersCards() = _OtherCards;
}
