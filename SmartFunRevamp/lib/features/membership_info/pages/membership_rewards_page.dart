import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/background_card_details.dart';
import 'package:semnox/core/widgets/custom_app_bar.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';

class MembershipRewardsPage extends ConsumerWidget {
  const MembershipRewardsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final card = ref.watch(CardsProviders.membershipCardProvider);
    return Scaffold(
      appBar: const CustomAppBar(title: 'Card Details'),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            CardCustomWidget(card: card),
            const SizedBox(height: 20.0),
            const MulishText(
              text: 'Membership rewards are loaded on to your primary card',
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
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
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 1.0, color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: const Text(
              'Get Balance',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
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
