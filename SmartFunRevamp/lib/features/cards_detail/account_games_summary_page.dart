import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/card_details/account_game_dto_list.dart';
import 'package:semnox/core/widgets/custom_app_bar.dart';
import 'package:semnox/core/widgets/custom_date_picker.dart';
import 'package:semnox/core/widgets/general_error_widget.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/cards_detail/account_games_summary_detail_page.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class AccountGamesSummaryPage extends ConsumerWidget {
  const AccountGamesSummaryPage({Key? key, required this.cardNumber}) : super(key: key);
  final String cardNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(CardsProviders.accountGamesSummaryProvider.notifier).getSummary(cardNumber);
    return Scaffold(
      appBar: CustomAppBar(
        title: SplashScreenNotifier.getLanguageLabel("Card Games Balance"),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Consumer(
          builder: (context, ref, child) {
            return ref.watch(CardsProviders.accountGamesSummaryProvider).maybeWhen(
                  orElse: () => Container(),
                  error: (message) {
                    return GeneralErrorWidget(message: message);
                  },
                  inProgress: () => const Center(child: CircularProgressIndicator.adaptive()),
                  accountGamesSuccess: (responseData) {
                    List<AccountGameDTOList> data = List.from(responseData);
                    int totalBonus = 0;
                    for (var element in data) {
                      totalBonus += element.balanceGames.toInt();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MulishText(
                              text: SplashScreenNotifier.getLanguageLabel('Expiring By'),
                              fontWeight: FontWeight.bold,
                            ),
                            CustomDatePicker(
                              labelText: '',
                              format: DateFormat.YEAR_ABBR_MONTH_DAY,
                              onItemSelected: (dob) =>
                                  ref.read(CardsProviders.bonusSummaryProvider.notifier).filter(dob),
                              hintText: SplashScreenNotifier.getLanguageLabel('Enter Date'),
                              suffixIcon: const Icon(
                                Icons.date_range,
                                color: CustomColors.hardOrange,
                              ),
                            ),
                          ],
                        ),
                        TotalBonusBalance(totalBonus: totalBonus),
                        const MulishText(
                          text: 'Card Games Balance Details',
                          fontWeight: FontWeight.bold,
                        ),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final summary = data[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AccountGamesSummaryDetailPage(summary: summary),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10.0),
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: CustomColors.customLigthGray),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                        decoration: BoxDecoration(
                                          color: CustomColors.customOrange,
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            MulishText(
                                              text: summary.gameId.toString(),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            MulishText(
                                              text:
                                                  '${summary.fromDate.formatDate(DateFormat.YEAR_ABBR_MONTH_DAY)},${summary.fromDate.formatDate(DateFormat.HOUR_MINUTE)}',
                                              fontSize: 10.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                const MulishText(
                                                  text: 'Value Loaded',
                                                ),
                                                MulishText(
                                                  text: '${summary.quantity.toInt()}',
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                const MulishText(
                                                  text: 'Balance',
                                                ),
                                                MulishText(
                                                  text: '${summary.balanceGames.toInt()}',
                                                ),
                                              ],
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios_outlined,
                                            ),
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

class TotalBonusBalance extends StatelessWidget {
  const TotalBonusBalance({
    Key? key,
    required this.totalBonus,
  }) : super(key: key);

  final int totalBonus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        color: CustomColors.customYellow,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const MulishText(
            text: 'Total Card Games Balance',
            fontWeight: FontWeight.bold,
          ),
          MulishText(
            text: '$totalBonus',
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
