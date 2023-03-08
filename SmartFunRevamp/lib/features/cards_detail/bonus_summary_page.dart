import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/widgets/custom_date_picker.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/cards_detail/bonus_summary_detail_page.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/core/utils/extensions.dart';

import '../../core/domain/entities/card_details/account_credit_plus_dto_list.dart';

class BonusSummaryPage extends ConsumerWidget {
  const BonusSummaryPage({Key? key, required this.cardNumber, required this.creditPlusType, required this.pageTitle}) : super(key: key);
  final String cardNumber;
  final int? creditPlusType;
  final String pageTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //TODO:Whenever the app rebuilds this is called again
    ref.read(CardsProviders.bonusSummaryProvider.notifier).getSummary('27637CC1');
    return Scaffold(
      appBar: CustomAppBar(
        title: MulishText(
          text: pageTitle,
          fontColor: CustomColors.customBlue,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Consumer(
          builder: (context, ref, child) {
            return ref.watch(CardsProviders.bonusSummaryProvider).maybeWhen(
                  orElse: () => Container(),
                  error: (_) {
                    return Container();
                  },
                  inProgress: () => const Center(child: CircularProgressIndicator()),
                  success: (responseData) {
                    List<AccountCreditPlusDTOList> data = List.from(responseData);
                    data = data..removeWhere((element) => (element.creditPlusType != creditPlusType && creditPlusType != null));
                    int totalBonus = 0;
                    for (var element in data) {
                      totalBonus += element.creditPlusBalance.toInt();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MulishText(
                              text: 'Expiring By',
                              fontWeight: FontWeight.bold,
                            ),
                            CustomDatePicker(
                              labelText: '',
                              format: DateFormat.YEAR_ABBR_MONTH_DAY,
                              onItemSelected: (dob) => ref.read(CardsProviders.bonusSummaryProvider.notifier).filter(dob),
                              hintText: 'Enter Date',
                              suffixIcon: const Icon(
                                Icons.date_range,
                                color: CustomColors.hardOrange,
                              ),
                            ),
                          ],
                        ),
                        TotalBonusBalance(totalBonus: totalBonus),
                        const MulishText(
                          text: 'Bonus Balance Details',
                          fontWeight: FontWeight.bold,
                        ),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final summary = data[index];
                              return Container(
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
                                            text: summary.remarks,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          MulishText(
                                            text: '${summary.periodFrom.formatDate(DateFormat.YEAR_ABBR_MONTH_DAY)},${summary.periodFrom.formatDate(DateFormat.HOUR_MINUTE)}',
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
                                                text: '${summary.creditPlus.toInt()}',
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const MulishText(
                                                text: 'Balance',
                                              ),
                                              MulishText(
                                                text: '${summary.creditPlusBalance.toInt()}',
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            onPressed: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => BonusSummaryDetailPage(summary: summary),
                                              ),
                                            ),
                                            icon: const Icon(
                                              Icons.arrow_forward_ios_outlined,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
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
            text: 'Total Bonus Balance',
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

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      iconTheme: const IconThemeData(color: CustomColors.customBlue),
      backgroundColor: CustomColors.customLigthBlue,
      title: title,
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
