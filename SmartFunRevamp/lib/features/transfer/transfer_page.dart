import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/domain/entities/transfer/transfer_balance.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/custom_app_bar.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';
import 'package:semnox/features/transfer/transfer_success_page.dart';
import 'package:semnox/features/transfer/widgets/amount_form_field.dart';
import 'package:semnox/features/transfer/widgets/bottom_sheet_button.dart';
import 'package:semnox/features/transfer/widgets/entitlement_field.dart';
import 'package:semnox/features/transfer/widgets/from_selection_container.dart';
import 'package:semnox/features/transfer/widgets/to_selection_container.dart';

class TransferPage extends ConsumerStatefulWidget {
  const TransferPage({Key? key, this.cardDetails}) : super(key: key);

  final CardDetails? cardDetails;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TransferPageState();
}

class _TransferPageState extends ConsumerState<TransferPage> {
  bool isAmountVisible = false;
  String entitlement = '';
  num amount = 0;
  final formKey = GlobalKey<FormState>();
  CardDetails? cardFrom;
  CardDetails? cardTo;
  late List<CardDetails> cards;
  late List<CardDetails> cardsFrom;
  @override
  void initState() {
    super.initState();
    cardsFrom = [];
    cards = List<CardDetails>.from(ref.read(CardsProviders.userCardsProvider).value ?? []);
    cards.removeWhere((element) => element.isBlocked() || element.isExpired());
    if (widget.cardDetails != null) {
      //is added to cards list as the only card
      cardsFrom.add(widget.cardDetails!);
    } else {
      cardsFrom = cards;
    }
    cardFrom = cardsFrom.first;
    cardTo = cards.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: SplashScreenNotifier.getLanguageLabel('Transfer')),
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0, bottom: 100),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                EntitlementField(
                  onChanged: (selected) {
                    setState(() {
                      isAmountVisible = true;
                      entitlement = selected?.toLowerCase() ?? '';
                    });
                  },
                ),
                AnimatedOpacity(
                  opacity: isAmountVisible ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AmountFormField(
                        entitlement: entitlement,
                        onSaved: (newValue) => amount = num.tryParse(newValue!) ?? 0,
                      ),
                      FromSelectionContainer(
                        cards: cardsFrom,
                        onCardChanged: (index) {
                          cardFrom = cards[index];
                        },
                      ),
                      const SizedBox(height: 10.0),
                      ToSelectionContainer(
                        cards: cards,
                        onCardChanged: (index) => cardTo = cards[index],
                        onOtherCardSelected: () => cardTo = null,
                        onAccountNumberSaved: (accountNumber) => cardTo = CardDetails(accountNumber: accountNumber),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomSheet: BottomSheetButton(
        onTap: () {
          if (!formKey.currentState!.validate()) {
            return;
          }
          formKey.currentState!.save();
          if (cardFrom!.isSameCard(cardTo)) {
            Dialogs.showErrorMessage(context, SplashScreenNotifier.getLanguageLabel("You can't transfer from/to the same card"));
          } else {
            TransferBalance transferBalance = TransferBalance(
              cardFrom!,
              cardTo!,
              amount,
              entitlement,
            );
            ref.listenManual(
              CardsProviders.transferBalance(transferBalance),
              (previous, next) {
                next.maybeWhen(
                  orElse: () => {},
                  loading: () => context.loaderOverlay.show(),
                  data: (_) {
                    context.loaderOverlay.hide();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransferSuccessPage(transferBalance: transferBalance),
                      ),
                    );
                  },
                  error: (error, stackTrace) {
                    context.loaderOverlay.hide();
                    Dialogs.showErrorMessage(
                      context,
                      SplashScreenNotifier.getLanguageLabel('There was an error during the transfer.\nPlease try again.'),
                    );
                  },
                );
              },
              fireImmediately: true,
            );
          }
        },
      ),
    );
  }
}
