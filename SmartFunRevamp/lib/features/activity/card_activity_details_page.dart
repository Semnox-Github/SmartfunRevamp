import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/card_details/card_activity_details.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/domain/use_cases/cards/get_card_activity_transaction_detail_use_case.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/custom_app_bar.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/image_handler.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/activity/card_activity_receipt_page.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

final _getTrxDetail = FutureProvider.autoDispose
    .family<CardActivityDetails, String>((ref, transactionId) async {
  final GetCardActivityTransactionDetailUseCase getTrxDetail =
      Get.find<GetCardActivityTransactionDetailUseCase>();
  final response = await getTrxDetail(transactionId, false);
  return response.fold(
    (l) => throw l,
    (r) => r,
  );
});

class CardActivityDetailPage extends ConsumerWidget {
  const CardActivityDetailPage({super.key, required this.transactionId});
  final String transactionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parafaitDefault = ref.watch(parafaitDefaultsProvider);
    final currencySymbol =
        parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencySymbol) ??
            'USD';
    final currencyFormat =
        parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencyFormat) ??
            '#,##0.00';
    return Scaffold(
      appBar: CustomAppBar(
        title: SplashScreenNotifier.getLanguageLabel('Transaction Details'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Consumer(
          builder: (context, ref, child) {
            return ref.watch(_getTrxDetail(transactionId)).maybeWhen(
                  orElse: () => Container(),
                  loading: () =>
                      const Center(child: CircularProgressIndicator.adaptive()),
                  error: (error, stackTrace) => Center(
                    child: MulishText(
                      text: (error as ServerFailure).message,
                    ),
                  ),
                  data: (data) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 10.0),
                          margin: const EdgeInsets.only(bottom: 30.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10.0),
                              MulishText(
                                text: data.transactionLinesDTOList?.first
                                        .productName ??
                                    SplashScreenNotifier.getLanguageLabel(
                                        'Variable App Recharge'),
                                fontWeight: FontWeight.bold,
                                fontColor: Colors.white,
                                fontSize: 20.0,
                              ),
                              const SizedBox(height: 10.0),
                              MulishText(
                                text: data.transactionLinesDTOList?.first
                                        .productName ??
                                    '${SplashScreenNotifier.getLanguageLabel('Card')} - XXXXXXXX',
                                fontWeight: FontWeight.bold,
                                fontColor: Colors.white,
                              ),
                              const SizedBox(height: 10.0),
                              const DottedLine(
                                dashColor: Colors.white,
                                lineThickness: 1.5,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MulishText(
                                          text: SplashScreenNotifier
                                              .getLanguageLabel('OTP'),
                                          fontColor: Colors.white,
                                        ),
                                        const SizedBox(height: 10.0),
                                        MulishText(
                                          text: data.transactionOTP.isEmpty
                                              ? 'XXXXXXXXX'
                                              : data.transactionOTP,
                                          fontColor: Colors.white,
                                        ),
                                      ],
                                    ),
                                    const ImageHandler(
                                      height: 70,
                                      imageKey: "QR_image_path",
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MulishText(
                              text: SplashScreenNotifier.getLanguageLabel(
                                  'Reference Id'),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                MulishText(
                                  text: '${data.transactionId}',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                                MulishText(
                                  text: '${data.status}',
                                  fontSize: 15,
                                ),
                                MulishText(
                                  text:
                                      '${data.transactionDate?.formatDate(DateFormat.YEAR_ABBR_MONTH_DAY)}, ${data.transactionDate?.formatDate(DateFormat.HOUR_MINUTE)}',
                                  fontSize: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MulishText(
                              text: data.transactionLinesDTOList?.first
                                      .productName ??
                                  SplashScreenNotifier.getLanguageLabel(
                                      'Variable App Recharge'),
                            ),
                            MulishText(
                              text:
                                  '${data.transactionLinesDTOList?.first.taxAmount.toCurrency(currencySymbol, currencyFormat)}',
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MulishText(
                              text:
                                  SplashScreenNotifier.getLanguageLabel('Tax'),
                            ),
                            MulishText(
                              text:
                                  '${data.transactionLinesDTOList?.first.taxAmount.toCurrency(currencySymbol, currencyFormat)}',
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1.5,
                          color: CustomColors.customLigthBlue,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MulishText(
                              text: SplashScreenNotifier.getLanguageLabel(
                                  'Paid Amount'),
                              fontWeight: FontWeight.bold,
                            ),
                            const MulishText(
                              text: '\$0',
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ],
                        ),
                        const Spacer(),
                        if (data.status == "CLOSED")
                          CustomButton(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CardActivityReceiptPage(
                                  transactionId: transactionId,
                                ),
                              ),
                            ),
                            label: SplashScreenNotifier.getLanguageLabel(
                                'VIEW RECEIPT'),
                            icon: const Icon(
                              Icons.receipt_rounded,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    );
                  },
                );
          },
        ),
      ),
    );
  }
}
