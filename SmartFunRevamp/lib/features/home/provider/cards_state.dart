part of 'cards_provider.dart';

@freezed
class CardsState with _$CardsState {
  const factory CardsState.initial() = _Initial;
  const factory CardsState.inProgress() = _InProgress;
  const factory CardsState.success(List<AccountCreditPlusDTOList> bonusSummary) = _Success;
  const factory CardsState.accountGamesSuccess(List<AccountGameDTOList> accountGamesSummary) = _AccountGamesSuccess;
  const factory CardsState.error(String msg) = _Error;
}
