import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/use_cases/authentication/send_link_reset_password_use_case.dart';
part 'reset_password_state.dart';
part 'reset_password_provider.freezed.dart';

final resetPasswordStateProvider = StateNotifierProvider<ResetPasswordProvider, ResetPasswordState>(
  (ref) => ResetPasswordProvider(
    Get.find<SendLinkResetPasswordUseCase>(),
  ),
);

class ResetPasswordProvider extends StateNotifier<ResetPasswordState> {
  final SendLinkResetPasswordUseCase _resetPasswordUseCase;
  ResetPasswordProvider(this._resetPasswordUseCase) : super(const _Initial());
  void sendEmail(String phoneOrEmail) async {
    state = const _InProgress();
    final response = await _resetPasswordUseCase(phoneOrEmail);
    state = response.fold(
      (l) => _Error(l.message),
      (r) => const _Success(),
    );
  }
}
