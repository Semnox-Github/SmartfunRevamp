import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/orders/order_details.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/custom_app_bar.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/orders/pages/orders_summary_detail_page.dart';
import 'package:semnox/features/orders/provider/orders_provider.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class OrdersSummaryPage extends ConsumerWidget {
  const OrdersSummaryPage({Key? key, required this.customerId}) : super(key: key);
  final String customerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(OrdersProviders.ordersSummaryProvider.notifier).getSummary(customerId);
    return Scaffold(
      appBar: CustomAppBar(
        title: SplashScreenNotifier.getLanguageLabel("Orders"),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Consumer(
          builder: (context, ref, child) {
            return ref.watch(OrdersProviders.ordersSummaryProvider).maybeWhen(
                  orElse: () => Container(),
                  error: (_) {
                    return Container();
                  },
                  inProgress: () => const Center(child: CircularProgressIndicator.adaptive()),
                  success: (responseData) {
                    List<OrderDetails> data = List.from(responseData);
                    data.removeWhere((element) => element.transactionLinesDTOList == null);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final summary = data[index];
                              return InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrdersSummaryDetailPage(transactionId: summary.transactionId.toString()),
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          color: CustomColors.customLigthGray,
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            MulishText(
                                              text: '${summary.transactionDate.formatDate(DateFormat.YEAR_ABBR_MONTH_DAY)},${summary.transactionDate.formatDate(DateFormat.HOUR_MINUTE)}',
                                              fontSize: 10,
                                            ),
                                            MulishText(
                                              text: '${SplashScreenNotifier.getLanguageLabel("Reference")} ${summary.transactionId.toString()}',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios_outlined,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
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
