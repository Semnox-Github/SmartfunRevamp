part of 'update_account_provider.dart';

@freezed
class UpdateAccountState with _$UpdateAccountState {
  const factory UpdateAccountState.initial() = _Initial;
  const factory UpdateAccountState.loading() = _Loading;
  const factory UpdateAccountState.success(CustomerDTO customerDTO) = _Success;
  const factory UpdateAccountState.error(String msg) = _Error;
}
