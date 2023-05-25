import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:intl/intl.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/domain/entities/orders/order_details.dart';
import 'package:semnox/core/widgets/custom_app_bar.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/orders/provider/orders_provider.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrdersSummaryDetailPage extends ConsumerWidget {
  const OrdersSummaryDetailPage({Key? key, required this.transactionId}) : super(key: key);
  final String transactionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(OrdersProviders.orderSummaryDetailProvider.notifier).getDetail(transactionId);
    return Scaffold(
      appBar: CustomAppBar(
        title: SplashScreenNotifier.getLanguageLabel("Transaction Details"),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Consumer(
          builder: (context, ref, child) {
            return ref.watch(OrdersProviders.orderSummaryDetailProvider).maybeWhen(
                  orElse: () => Container(),
                  error: (_) {
                    return Container();
                  },
                  inProgress: () => const Center(child: CircularProgressIndicator()),
                  successOrderDetail: (responseData) {
                    TransactionLinesDTOList transactionLines = responseData.transactionLinesDTOList![0];
                    
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MulishText(
                          text: transactionLines.productName.toString(),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                        MulishText(
                          text: '${SplashScreenNotifier.getLanguageLabel("Card")}: ${transactionLines.cardNumber}',
                          fontSize: 14.0,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: QrImageView(
                            data: responseData.transactionOTP,
                            version: QrVersions.auto,
                            size: MediaQuery.of(context).size.width * 0.6,
                          ),
                        ),                        
                        MulishText(
                          text: '${SplashScreenNotifier.getLanguageLabel("OTP")}: ${responseData.transactionOTP}',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: MulishText(
                                  text: SplashScreenNotifier.getLanguageLabel("Reference Id"),
                                  fontSize: 14.0,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Expanded(
                                child: MulishText(
                                  text: responseData.transactionId.toString(),
                                  fontSize: 14.0,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ),
                        MulishText(                              
                          text: '${responseData.transactionDate.formatDate(DateFormat.YEAR_ABBR_MONTH_DAY)},${responseData.transactionDate.formatDate(DateFormat.HOUR_MINUTE)}',
                          fontSize: 14.0,
                          textAlign: TextAlign.end,
                        ),
                        const Divider(
                          height: 10,
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: MulishText(
                                  text: transactionLines.productName.toString(),
                                  fontSize: 14.0,
                                  textAlign: TextAlign.start
                                ),
                              ),
                              Expanded(
                                child: MulishText(
                                  text: responseData.transactionAmount.toString(),
                                  fontSize: 14.0,
                                  textAlign: TextAlign.end
                                ),
                              ),
                            ],
                          ),
                        ),
                        MulishText(                              
                          text: responseData.taxAmount.toString(),
                          fontSize: 14.0,
                          textAlign: TextAlign.end
                        ),
                        MulishText(                              
                          text: responseData.transactionDiscountAmount.toString(),
                          fontSize: 14.0,
                          textAlign: TextAlign.end
                        ),
                        const Divider(
                          height: 10,
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Expanded(
                                child: MulishText(                              
                                  text: 'Total',
                                  fontSize: 14.0,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Expanded(
                                child: MulishText(                              
                                  text: responseData.transactionNetAmount.toString(),
                                  fontSize: 14.0,
                                  textAlign: TextAlign.end,
                                ),
                              )
                            ],
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

// class TotalBonusBalance extends StatelessWidget {
//   const TotalBonusBalance({
//     Key? key,
//     required this.totalBonus,
//   }) : super(key: key);

//   final int totalBonus;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20.0),
//       margin: const EdgeInsets.symmetric(vertical: 20.0),
//       decoration: BoxDecoration(
//         color: CustomColors.customYellow,
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const MulishText(
//             text: 'Total Bonus Balance',
//             fontWeight: FontWeight.bold,
//           ),
//           MulishText(
//             text: '$totalBonus',
//             fontWeight: FontWeight.bold,
//           ),
//         ],
//       ),
//     );
//   }
// }
