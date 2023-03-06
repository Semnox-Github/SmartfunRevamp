import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/features/lost_card/pages/lost_card_page.dart';
import 'package:semnox/features/recharge_card/widgets/recharge_bottom_sheet_button.dart';

class BlockCardButton extends ConsumerWidget {
  const BlockCardButton({
    Key? key,
    required this.cardDetails,
  }) : super(key: key);
  final CardDetails? cardDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomSheetButton(
        label: 'BLOCK & ISSUE REPLACEMENT',
        onTap: () => {
          ref.listenManual(
            CardsProviders.lostCardProvider(cardDetails!),
            (previous, next) {
              next.maybeWhen(
                orElse: () => {},
                data: (data) {
                  ref.invalidate(CardsProviders.userCardsProvider);
                  ref.read(CardsProviders.userCardsProvider);
                },
                error: (e, s) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.scale,
                    title: 'Lost Card',
                    desc: 'Try again',
                    btnOkOnPress: () {},
                  ).show();
                },
              );
            },
          ),    
          Navigator.pop(context),
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LostCardPage(cardDetails: cardDetails!),
            ),
          ),
        }
      );
  }
}
