import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/data/datasources/local_data_source.dart';
import 'package:semnox/core/domain/entities/payment/hosted_payment_gateway.dart';
import 'package:semnox/core/domain/entities/payment/hosted_payment_gateway_request.dart';
import 'package:semnox/core/domain/use_cases/payment/get_hosted_payment_gateways_use_case.dart';

part 'hosted_payment_state.dart';
part 'hosted_payment_provider.freezed.dart';

final hostedPaymentProvider = StateNotifierProvider.autoDispose<HostedPaymentProvider, HostedPaymentState>(
  (ref) => HostedPaymentProvider(
    Get.find<GetHostedPaymentGatewayUseCase>(),
    Get.find<LocalDataSource>(),
  ),
);

class HostedPaymentProvider extends StateNotifier<HostedPaymentState> {
  final GetHostedPaymentGatewayUseCase _getHostedPaymentGatewayUseCase;
  final LocalDataSource _localDataSource;

  HostedPaymentProvider(
    this._getHostedPaymentGatewayUseCase,
    this._localDataSource,
  ) : super(const _Initial());

  void getHtml(HostedPaymentGatewayRequest request) async {
    await _localDataSource.saveValue(LocalDataSource.kTransactionId, request.transactionId);
    state = const _InProgress();
    final response = await _getHostedPaymentGatewayUseCase(
      amount: request.amount,

      hostedPaymentGateway: request.hostedPaymentGateway,
      transactionId: request.transactionId,
    );
    state = response.fold(
      (l) => const _Error('Unable to load'),
      (r) => _Success(r),
    );
  }
}
