import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/card_details/account_credit_plus_dto_list.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/features/cards_detail/bonus_summary_page.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';

class BonusSummaryDetailPage extends StatelessWidget {
  const BonusSummaryDetailPage({Key? key, required this.summary}) : super(key: key);
  final AccountCreditPlusDTOList summary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MulishText(
              text: summary.remarks,
              fontColor: CustomColors.customBlue,
              fontWeight: FontWeight.bold,
            ),
            MulishText(
              text: '${summary.periodFrom.formatDate(DateFormat.YEAR_ABBR_MONTH_DAY)} - ${summary.periodFrom.formatDate(DateFormat.HOUR_MINUTE)}',
              fontColor: CustomColors.customBlue,
              fontSize: 16.0,
            ),
          ],
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(CardsProviders.userGamesSummaryProvider).maybeWhen(
                          orElse: () => Container(),
                        );
                  },
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: CustomColors.customLigthGray,
                      ),
                    ),
                    child: Column(
                      children: [
                        const MulishText(
                          text: 'Valid From',
                          fontWeight: FontWeight.bold,
                        ),
                        MulishText(text: summary.periodFrom.formatDate('dd MMM yyyy')),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: CustomColors.customLigthGray,
                      ),
                    ),
                    child: Column(
                      children: [
                        const MulishText(
                          text: 'Valid To',
                          fontWeight: FontWeight.bold,
                        ),
                        MulishText(text: summary.periodTo.formatDate('dd MMM yyyy')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            TotalBonusBalance(
              totalBonus: summary.creditPlusBalance.toInt(),
            )
          ],
        ),
      ),
    );
  }
}
