import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/use_cases/authentication/sign_up_user_use_case.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
part 'update_account_state.dart';
part 'update_account_provider.freezed.dart';

final updateAccountProvider = StateNotifierProvider<AccountProvider, UpdateAccountState>(
  (ref) => AccountProvider(Get.find<SignUpUserUseCase>()),
);

class AccountProvider extends StateNotifier<UpdateAccountState> {
  AccountProvider(this._updateUseCase) : super(const _Initial());
  final SignUpUserUseCase _updateUseCase;
  Future<void> updateProfile(CustomerDTO customerDTO) async {
    state = const _Loading();
    final response = await _updateUseCase(customerDTO.toJson());
    state = response.fold(
      (l) => const _Error('There was an error updating your profile please try again.'),
      (r) => _Success(r),
    );
  }
}
