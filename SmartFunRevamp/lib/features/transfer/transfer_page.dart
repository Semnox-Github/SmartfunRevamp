import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/inputs_decorations.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/domain/entities/transfer/transfer_balance.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/custom_app_bar.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/cards_detail/bonus_summary_page.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/features/home/widgets/carousel_cards.dart';
import 'package:semnox/features/transfer/transfer_success_page.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  bool isAmountVisible = false;
  bool isTranferToAnotherCard = false;
  String entitlement = '';
  num amount = 0;
  String transferTo = 'My Cards';
  bool isOwnTransfer = true;
  final formKey = GlobalKey<FormState>();
  CardDetails? cardFrom;
  CardDetails? cardTo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Consumer(builder: (context, ref, _) {
        return BottomSheetButton(
          onTap: () {
            if (cardFrom!.accountNumber!.startsWith('T') || cardTo!.accountNumber!.startsWith('T')) {
              Dialogs.showErrorMessage(context, "You can't transfer from/to a blocked card");
            } else if (cardFrom!.accountNumber == cardTo!.accountNumber) {
              Dialogs.showErrorMessage(context, "You can't transfer from/to the same card");
            } else if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
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
                      Logger().d('Success');
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
                        'There was an error during the transfer.\nPlease try again.',
                      );
                    },
                  );
                },
                fireImmediately: true,
              );
            }
          },
        );
      }),
      appBar: const CustomAppBar(title: 'Transfer'),
      body: LoaderOverlay(
        child: SafeArea(
          minimum: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0, bottom: 100),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const MulishText(text: 'Select Entitlement', fontWeight: FontWeight.bold),
                        const SizedBox(height: 10.0),
                        EntitlementDropdown(
                          onChanged: (selected) {
                            setState(() {
                              isAmountVisible = true;
                              entitlement = selected!.toLowerCase();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isAmountVisible ? 1.0 : 0.0,
                    child: Column(
                      children: [
                        AmountFormField(
                          entitlement: entitlement,
                          onSaved: (newValue) => amount = num.tryParse(newValue!) ?? 0,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const MulishText(
                                text: 'Transfer From',
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                              const SizedBox(height: 10.0),
                              Consumer(
                                builder: (context, ref, child) {
                                  return ref.watch(CardsProviders.userCardsProvider).maybeWhen(
                                        orElse: () => Container(),
                                        data: (data) {
                                          return CarouselCards(
                                            showLinkCard: false,
                                            cards: data,
                                            onCardChanged: (cardIndex) {
                                              cardFrom = data[cardIndex];
                                            },
                                          );
                                        },
                                      );
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const MulishText(
                                text: 'Transfer To',
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                              const SizedBox(height: 10.0),
                              RadioGroup<String>.builder(
                                groupValue: transferTo,
                                activeColor: CustomColors.hardOrange,
                                direction: Axis.horizontal,
                                onChanged: (value) {
                                  setState(() {
                                    transferTo = value!;
                                    isOwnTransfer = !isOwnTransfer;
                                    cardTo = null;
                                  });
                                },
                                items: const ['My Cards', "Other's Card"],
                                itemBuilder: (item) => RadioButtonBuilder(item),
                              ),
                              const SizedBox(height: 10.0),
                              Visibility(
                                visible: isOwnTransfer,
                                child: Consumer(
                                  builder: (context, ref, child) {
                                    return ref.watch(CardsProviders.userCardsProvider).maybeWhen(
                                          orElse: () => Container(),
                                          data: (data) {
                                            return CarouselCards(
                                              showLinkCard: false,
                                              cards: data,
                                              onCardChanged: (cardIndex) {
                                                cardTo = data[cardIndex];
                                              },
                                            );
                                          },
                                        );
                                  },
                                ),
                              ),
                              Visibility(
                                visible: !isOwnTransfer,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const MulishText(
                                      text: 'Enter card number',
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const SizedBox(height: 10.0),
                                    TextFormField(
                                      validator: (value) => value.isNullOrEmpty() ? 'Required' : null,
                                      decoration: InputDecoration(
                                        enabledBorder: CustomInputDecorations.k20RoundedCustomBlue,
                                        focusedBorder: CustomInputDecorations.k20RoundedCustomBlue,
                                        errorBorder: CustomInputDecorations.k20RoundedError,
                                        focusedErrorBorder: CustomInputDecorations.k20RoundedError,
                                        hintText: 'Enter card number',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EntitlementDropdown extends StatelessWidget {
  const EntitlementDropdown({
    super.key,
    required this.onChanged,
  });
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      validator: (value) => value.isNullOrEmpty() ? 'Required' : null,
      decoration: InputDecoration(
        hintText: 'Select',
        enabledBorder: CustomInputDecorations.k20RoundedCustomBlue,
        focusedBorder: CustomInputDecorations.k20RoundedCustomBlue,
        errorBorder: CustomInputDecorations.k20RoundedError,
        focusedErrorBorder: CustomInputDecorations.k20RoundedError,
      ),
      items: const ['Credits', 'Bonus', 'Tickets']
          .map(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: MulishText(text: e),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}

class AmountFormField extends StatelessWidget {
  const AmountFormField({
    super.key,
    required this.entitlement,
    required this.onSaved,
  });

  final String entitlement;
  final Function(String?) onSaved;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MulishText(text: 'Enter the $entitlement you want to transfer', fontWeight: FontWeight.bold),
          const SizedBox(height: 10.0),
          TextFormField(
            validator: (value) => value.isNullOrEmpty() ? 'Required' : null,
            onSaved: onSaved,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              enabledBorder: CustomInputDecorations.k20RoundedCustomBlue,
              focusedBorder: CustomInputDecorations.k20RoundedCustomBlue,
              errorBorder: CustomInputDecorations.k20RoundedError,
              focusedErrorBorder: CustomInputDecorations.k20RoundedError,
              hintText: 'Amount',
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSheetButton extends StatelessWidget {
  const BottomSheetButton({
    super.key,
    required this.onTap,
  });
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25.0),
      color: Colors.transparent,
      child: CustomButton(
        onTap: onTap,
        label: 'TRANSFER CREDITS',
      ),
    );
  }
}
