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
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class OrdersSummaryPage extends ConsumerWidget {
  const OrdersSummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerId = ref.watch(userProvider)?.id.toString() ?? '';
    ref
        .read(OrdersProviders.ordersSummaryProvider.notifier)
        .getSummary(customerId);
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
                  inProgress: () =>
                      const Center(child: CircularProgressIndicator.adaptive()),
                  success: (responseData) {
                    List<OrderDetails> data = List.from(responseData);
                    data.removeWhere(
                        (element) => element.transactionLinesDTOList == null);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: data.length,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final summary = data[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: CustomColors.customLigthBlue),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 12),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OrdersSummaryDetailPage(
                                                transactionId: summary
                                                    .transactionId
                                                    .toString()),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MulishText(
                                            text:
                                                '${summary.transactionDate.formatDate(DateFormat.YEAR_ABBR_MONTH_DAY)},${summary.transactionDate.formatDate(DateFormat.HOUR_MINUTE)}',
                                            fontWeight: FontWeight.bold,
                                          ),
                                          MulishText(
                                            text:
                                                '${SplashScreenNotifier.getLanguageLabel("Reference")} ${summary.transactionId.toString()}',
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const MulishText(
                                            text: '',
                                            fontWeight: FontWeight.bold,
                                          ),
                                          MulishText(
                                            text: '${summary.status}',
                                          ),
                                        ],
                                      ),
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                          )
                                        ],
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
