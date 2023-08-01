import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/custom_app_bar.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/features/splash/after_splash_screen.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class LoyaltyPointsInfoPage extends ConsumerWidget {
  const LoyaltyPointsInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parafaitDefault = ref.watch(parafaitDefaultsProvider).value;
    final currency = parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencySymbol) ?? 'USD';
    final format = parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencyFormat) ?? '#,##0.00';
    final cards = ref.watch(CardsProviders.loyaltyPointsDetailProvider);
    return Scaffold(
      appBar: CustomAppBar(
        title: SplashScreenNotifier.getLanguageLabel('Loyalty Points Earning Detail'),
        fontSize: 18.0,
      ),
      body: cards.when(
        error: (_, __) => Container(),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (data) {
          if (data.isEmpty) {
            return Center(
              child: MulishText(
                text: SplashScreenNotifier.getLanguageLabel('No transaction details'),
                fontSize: 30.0,
              ),
            );
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final transaction = data[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: CustomColors.customLigthBlue,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MulishText(
                                text: SplashScreenNotifier.getLanguageLabel('TrxId: &1').replaceAll(
                                  '&1',
                                  transaction.refId.toString(),
                                ),
                              ),
                              MulishText(
                                text: transaction.amount.toCurrency(currency, format),
                              ),
                            ],
                          ),
                          MulishText(text: '${transaction.site}'),
                          MulishText(text: '${transaction.date.formatDate(DateFormat.YEAR_ABBR_MONTH_DAY)} - ${transaction.date.formatDate(DateFormat.HOUR_MINUTE)}'),
                          const SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE9DC),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MulishText(text: SplashScreenNotifier.getLanguageLabel('Loyalty Points Earned')),
                          MulishText(text: '${transaction.loyaltyPoints!.toInt()}'),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
