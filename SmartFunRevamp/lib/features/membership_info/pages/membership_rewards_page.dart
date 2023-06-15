import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/background_card_details.dart';
import 'package:semnox/core/widgets/custom_app_bar.dart';
import 'package:semnox/core/widgets/custom_date_picker.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/features/membership_info/provider/membership_rewards_provider.dart';

class MembershipRewardsPage extends ConsumerStatefulWidget {
  const MembershipRewardsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MembershipRewardsPageState();
}

class _MembershipRewardsPageState extends ConsumerState<MembershipRewardsPage> {
  @override
  Widget build(BuildContext context) {
    final fromDate = ref.watch(fromDateProvider);
    final toDate = ref.watch(toDateProvider);
    final membershipCard = ref.watch(CardsProviders.membershipCardProvider);
    return Scaffold(
      appBar: const CustomAppBar(title: 'Card Details'),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Column(
          children: [
            CardCustomWidget(card: membershipCard),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: MulishText(
                text: 'Membership rewards are loaded on to your primary card',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomDatePicker(
                    labelText: 'From',
                    format: 'dd-MM-yyyy',
                    onItemSelected: (date) {
                      ref.read(fromDateProvider.notifier).update((_) => date);
                      ref.read(membershipRewardsProvider.notifier).filter(fromDate, toDate);
                    },
                    initialText: fromDate.formatDate('dd-MM-yyyy'),
                    suffixIcon: const Icon(
                      Icons.calendar_month,
                      color: CustomColors.hardOrange,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: CustomDatePicker(
                    labelText: 'To',
                    format: 'dd-MM-yyyy',
                    initialText: toDate.formatDate('dd-MM-yyyy'),
                    onItemSelected: (date) {
                      ref.read(toDateProvider.notifier).update((_) => date);
                      ref.read(membershipRewardsProvider.notifier).filter(fromDate, toDate);
                    },
                    suffixIcon: const Icon(
                      Icons.calendar_month,
                      color: CustomColors.hardOrange,
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                child: ref.watch(membershipRewardsProvider).maybeWhen(
                      orElse: () => Container(),
                      error: (_) => Container(
                        height: 100,
                        width: 100,
                        color: Colors.red,
                      ),
                      inProgress: () => const Center(child: CircularProgressIndicator()),
                      success: (data) {
                        if (data.isEmpty) {
                          return const Center(
                            child: MulishText(
                              text: "There's no rewards between those dates",
                              fontSize: 25.0,
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                  color: CustomColors.customLigthBlue,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: CustomColors.customOrange,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        MulishText(
                                          text: data[index].remarks,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        const MulishText(
                                          text: 'Bonus',
                                        ),
                                        MulishText(
                                          text: '${data[index].periodFrom.formatDate(DateFormat.YEAR_MONTH_DAY)} ${data[index].periodFrom.formatDate(DateFormat.HOUR_MINUTE)}',
                                          fontSize: 10.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          const MulishText(text: 'Value Loaded'),
                                          MulishText(
                                            text: '${data[index].creditPlus.toInt()}',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          const MulishText(text: 'Balance'),
                                          MulishText(
                                            text: '${data[index].creditPlusBalance.toInt()}',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardCustomWidget extends StatelessWidget {
  const CardCustomWidget({super.key, required this.card});
  final CardDetails card;
  @override
  Widget build(BuildContext context) {
    return BackgroundCard(
      isVirtual: card.isBlocked(),
      isExpired: card.isExpired(),
      cardNumber: card.accountNumber!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${card.accountNumber}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 7.0),
                  Text(
                    '${card.accountIdentifier == '' ? '+ Add nickname' : card.accountIdentifier?.substring(0, 15)}',
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Dialogs.showBarcodeTempCard(context, card.accountNumber!),
                child: Image.asset(
                  'assets/home/QR.png',
                  height: 42.0,
                ),
              )
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            '${card.issueDate != null ? DateFormat('dd  MMM yyyy').format(card.issueDate as DateTime) : ''} ${card.expiryDate != null ? DateFormat('- dd  MMM yyyy').format(DateTime.parse(card.expiryDate.toString())) : ''}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
