import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/buy_card/discount_entity.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/enums/contact_enum.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/core/widgets/recharge_card_widget.dart';
import 'package:semnox/features/buy_a_card/pages/estimated_transaction_page.dart';
import 'package:semnox/features/buy_a_card/provider/estimate/estimate_provider.dart';
import 'package:semnox/features/splash/after_splash_screen.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class Dialogs {
  static void couponSuccessDialog(BuildContext context, double couponValue) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      title: SplashScreenNotifier.getLanguageLabel('Error'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MulishText(
                  text: '\$$couponValue',
                  fontSize: 48.0,
                ),
                Image.asset(
                  'assets/buy_card/coupon_congrats.png',
                  height: 80.0,
                )
              ],
            ),
            MulishText(
              text: SplashScreenNotifier.getLanguageLabel('Saved on the bill with the coupon'),
              fontColor: CustomColors.couponTextColor,
            )
          ],
        ),
      ),
    ).show();
  }

  static void getCoupongNumberDialog(BuildContext context, WidgetRef ref, CardProduct cardProduct) {
    final key = GlobalKey<FormState>();
    String coupon = '';
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      body: Form(
        key: key,
        child: TextFormField(
          validator: (value) => value!.isNotEmpty ? null : 'Required',
          onSaved: (newValue) => coupon = newValue!,
          decoration: InputDecoration(
            hintText: SplashScreenNotifier.getLanguageLabel('Coupon'),
          ),
        ),
      ),
      btnOkOnPress: () {
        if (key.currentState!.validate()) {
          key.currentState!.save();
          ref.read(estimateStateProvider.notifier).getEstimateTransaction(
                cardProduct,
                dtoList: DiscountApplicationHistoryDTOList(-1, coupon, -1),
              );
        }
      },
    ).show();
  }

  static void showCardInfo(BuildContext context, CardProduct card) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: Container(
            padding: const EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 5.0),
                  decoration: BoxDecoration(
                    color: CustomColors.customLigthBlue,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MulishText(
                        text: card.productName,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.cancel_outlined,
                        ),
                      )
                    ],
                  ),
                ),
                RechargeCardWidget(cardProduct: card),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MulishText(
                        text: card.description,
                        fontWeight: FontWeight.w800,
                        textAlign: TextAlign.start,
                        fontSize: 20.0,
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          final parafaitDefault = ref.watch(parafaitDefaultsProvider).value;
                          final currency = parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencySymbol) ?? 'USD';
                          final format = parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencyFormat) ?? '#,##0.00';
                          return CustomButton(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EstimatedTransactionPage(
                                    cardProduct: card,
                                    transactionType: "newcard",
                                    qty: 1,
                                    finalPrice: 0,
                                  ),
                                ),
                              );
                            },
                            label: SplashScreenNotifier.getLanguageLabel('BUY NOW @ &1').replaceAll("&1", card.finalPrice.toCurrency(currency, format)),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static void showMessageInfo(BuildContext context, String title, String meessge) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.infoReverse,
      animType: AnimType.scale,
      title: title,
      desc: meessge,
      descTextStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
      btnOkOnPress: () {},
      btnOkText: SplashScreenNotifier.getLanguageLabel('OK'),
      btnOkColor: Colors.blue,
    ).show();
  }

  static void showErrorMessage(BuildContext context, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: SplashScreenNotifier.getLanguageLabel('Error'),
      desc: message,
      descTextStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
      btnOkOnPress: () {},
      btnOkText: SplashScreenNotifier.getLanguageLabel('OK'),
      btnOkColor: Colors.red,
    ).show();
  }

  static void showBarcodeTempCard(BuildContext context, String accountNumber) {
    String titleOfDialog = accountNumber.startsWith('T') ? SplashScreenNotifier.getLanguageLabel('Virtual Card') : SplashScreenNotifier.getLanguageLabel('Card');
    String cardCoachMark = 'BARCODE';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          title: Text(
            titleOfDialog,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsetsDirectional.all(10.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsetsDirectional.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: BarcodeWidget(
                          barcode: cardCoachMark == 'BARCODE' ? Barcode.code128() : Barcode.qrCode(errorCorrectLevel: BarcodeQRCorrectionLevel.high),
                          data: accountNumber,
                          drawText: false,
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: double.maxFinite,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      accountNumber,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20.0),
                    CustomButton(
                      onTap: () => Navigator.pop(context),
                      label: SplashScreenNotifier.getLanguageLabel('DONE'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void verifyDialog(BuildContext context, Function(String) onVerify, ContactType contactType) {
    String otp = '';
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      btnOk: CustomButton(
        onTap: () {
          onVerify(otp);
          Navigator.pop(context);
        },
        label: SplashScreenNotifier.getLanguageLabel('VERIFY'),
      ),
      btnCancel: CustomCancelButton(
        onPressed: () => Navigator.pop(context),
        label: SplashScreenNotifier.getLanguageLabel('CANCEL'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsetsDirectional.all(10.0),
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MulishText(
                  text: '${SplashScreenNotifier.getLanguageLabel('Verify')} ${contactType.valueString}',
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 10.0),
                MulishText(
                  text: SplashScreenNotifier.getLanguageLabel('We have mailed you an OTP.\nEnter the OTP to verify your &1').replaceAll("&1", contactType.valueString),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 10.0),
                OtpPinField(
                    onSubmit: (otp) => {},
                    onChange: (code) => otp = code,
                    keyboardType: TextInputType.number,
                    otpPinFieldDecoration: OtpPinFieldDecoration.defaultPinBoxDecoration,
                    otpPinFieldStyle: const OtpPinFieldStyle(
                      defaultFieldBorderColor: CustomColors.customOrange,
                      activeFieldBorderColor: CustomColors.hardOrange,
                    ),
                    maxLength: 6,
                    fieldHeight: MediaQuery.of(context).size.width * 0.12,
                    fieldWidth: MediaQuery.of(context).size.width * 0.12),
                const SizedBox(height: 10.0),
                MulishText(
                  text: SplashScreenNotifier.getLanguageLabel("Didn't Receive?"),
                  textAlign: TextAlign.start,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: MulishText(
                          text: SplashScreenNotifier.getLanguageLabel('RESEND'),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      WidgetSpan(
                        child: MulishText(
                          text: SplashScreenNotifier.getLanguageLabel(' in 30 seconds'),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).show();
  }

  // ignore: unused_element
  static void _showAppRatingDialog(BuildContext context, Function() onSubmitted) {
    final isIOS = Platform.isIOS;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return RatingDialog(
          enableComment: false,
          initialRating: 1.0,
          title: Text(
            SplashScreenNotifier.getLanguageLabel('Enjoying Parafait SmartFun?'),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          image: Image.asset('assets/home/logo.png'),
          message: Text(
            // 'Tap a star to rate it on the ${isIOS ? 'App Store' : 'Play Store'}',
            SplashScreenNotifier.getLanguageLabel('Tap a star to rate it on the &1')
                .replaceAll('&1', isIOS ? SplashScreenNotifier.getLanguageLabel('App Store') : SplashScreenNotifier.getLanguageLabel('Play Store')),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15),
          ),
          submitButtonText: SplashScreenNotifier.getLanguageLabel('Submit'),
          onCancelled: () {},
          onSubmitted: (response) {
            onSubmitted();
          },
        );
      },
    );
  }

  static void deleteProfileSuccessDialog(BuildContext context, Function() onSubmitted) {
    AwesomeDialog(
      context: context,
      dismissOnTouchOutside: true,
      onDismissCallback: (type) => onSubmitted(),
      title: SplashScreenNotifier.getLanguageLabel('Delete Profile'),
      desc: SplashScreenNotifier.getLanguageLabel('Profile deleted successfully.'),
      descTextStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
    ).show();
  }
}
