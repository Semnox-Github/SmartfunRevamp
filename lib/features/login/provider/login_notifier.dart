import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/di/injection_container.dart';
import 'package:semnox/core/domain/use_cases/login_user_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.dart';
part 'login_notifier.freezed.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) => LoginNotifier(sl<LoginUserUseCase>()));

class LoginNotifier extends StateNotifier<LoginState> {
  final LoginUserUseCase _loginUserUseCase;

  LoginNotifier(this._loginUserUseCase) : super(const _Initial());

  void loginUser(String loginId, String password) async {
    state = const _InProgress();

    final result = await _loginUserUseCase(
      {
        'LoginId': loginId,
        'password': password,
      },
    );
    state = result.fold(
      (failure) => _Error(failure.message),
      (user) {
        return const _Success();
      },
    );
  }
}
