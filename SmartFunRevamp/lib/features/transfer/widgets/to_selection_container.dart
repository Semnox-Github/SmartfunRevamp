import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/inputs_decorations.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/home/widgets/carousel_cards.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

enum TransferType { myCards, othersCards }

extension TransferTypeExtension on TransferType {
  String stringValue() {
    switch (this) {
      case TransferType.myCards:
        return SplashScreenNotifier.getLanguageLabel('My Cards');
      case TransferType.othersCards:
        return SplashScreenNotifier.getLanguageLabel("Other's Cards");
      default:
        return '';
    }
  }
}

class ToSelectionContainer extends StatefulWidget {
  const ToSelectionContainer({
    super.key,
    required this.cards,
    required this.onCardChanged,
    required this.onOtherCardSelected,
    required this.onAccountNumberSaved,
  });

  final List<CardDetails> cards;
  final Function(int) onCardChanged;
  final Function() onOtherCardSelected;
  final Function(String?) onAccountNumberSaved;

  @override
  State<ToSelectionContainer> createState() => _ToSelectionContainerState();
}

class _ToSelectionContainerState extends State<ToSelectionContainer> {
  TransferType transferType = TransferType.myCards;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MulishText(
          text: SplashScreenNotifier.getLanguageLabel('Transfer To'),
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
        const SizedBox(height: 10.0),
        RadioGroup<TransferType>.builder(
          groupValue: transferType,
          activeColor: CustomColors.hardOrange,
          direction: Axis.horizontal,
          onChanged: (value) {
            setState(() {
              transferType = value!;
              if (transferType == TransferType.othersCards) {
                widget.onOtherCardSelected();
              }
            });
          },
          items: TransferType.values,
          itemBuilder: (item) => RadioButtonBuilder(item.stringValue()),
        ),
        const SizedBox(height: 10.0),
        Visibility(
          visible: transferType == TransferType.myCards,
          child: CarouselCards(
            showLinkCard: false,
            cards: widget.cards,
            onCardChanged: widget.onCardChanged,
          ),
        ),
        const SizedBox(height: 10.0),
        Visibility(
          visible: transferType == TransferType.othersCards,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              MulishText(
                text: SplashScreenNotifier.getLanguageLabel('Enter card number'),
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                validator: (value) => value.isNullOrEmpty() ? SplashScreenNotifier.getLanguageLabel('Required') : null,
                onSaved: widget.onAccountNumberSaved,
                decoration: InputDecoration(
                  enabledBorder: CustomInputDecorations.k12RoundedCustomBlue,
                  focusedBorder: CustomInputDecorations.k12RoundedCustomBlue,
                  errorBorder: CustomInputDecorations.k12RoundedError,
                  focusedErrorBorder: CustomInputDecorations.k12RoundedError,
                  hintText: SplashScreenNotifier.getLanguageLabel('Enter card number'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
