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
import 'package:semnox/core/enums/contact_enum.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/core/widgets/recharge_card_widget.dart';
import 'package:semnox/features/buy_a_card/pages/estimated_transaction_page.dart';
import 'package:semnox/features/buy_a_card/provider/estimate/estimate_provider.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';
import 'package:semnox/features/payment/provider/feedback_provider.dart';

class Dialogs {
  static void couponSuccessDialog(BuildContext context, double couponValue) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      title: 'Error',
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
            const MulishText(
              text: 'Saved on the bill with the coupon',
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
          decoration: const InputDecoration(
            hintText: 'Coupon',
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
                      const MulishText(
                        text: 'Features & Terms',
                        fontWeight: FontWeight.w800,
                        textAlign: TextAlign.start,
                        fontSize: 20.0,
                      ),
                      const MulishText(
                        text: '\u2022 Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                        fontSize: 14.0,
                        textAlign: TextAlign.start,
                      ),
                      const MulishText(
                        text: '\u2022 Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                        fontSize: 14.0,
                        textAlign: TextAlign.start,
                      ),
                      const MulishText(
                        text: '\u2022 Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                        fontSize: 14.0,
                        textAlign: TextAlign.start,
                      ),
                      const MulishText(
                        text: '\u2022 Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                        fontSize: 14.0,
                        textAlign: TextAlign.start,
                      ),
                      CustomButton(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EstimatedTransactionPage(cardProduct: card, transactionType: "newcard", qty: 1, finalPrice: 0,),
                            ),
                          );
                        },
                        label: 'BUY NOW @ ${card.finalPrice.toStringAsFixed(0)}',
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
      btnOkText: 'OK',
      btnOkColor: Colors.blue,
    ).show();
  }

  static void showErrorMessage(BuildContext context, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: 'Error',
      desc: message,
      descTextStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
      btnOkOnPress: () {},
      btnOkText: 'OK',
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
                const MulishText(
                  text: "Didn't Receive?",
                  textAlign: TextAlign.start,
                ),
                RichText(
                  text: const TextSpan(children: [
                    WidgetSpan(
                      child: MulishText(
                        text: 'RESEND',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    WidgetSpan(
                      child: MulishText(
                        text: ' in 30 seconds',
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    ).show();
  }

  static void showTransactionFeedbackDialog(BuildContext context, Function() onSubmitted) {
    AwesomeDialog(
        context: context,
        body: Consumer(
          builder: (context, ref, child) {
            return ref.watch(surveyDetailsProvider).when(
                  loading: () => const CircularProgressIndicator(),
                  error: (_, __) => const MulishText(text: 'Error loading feedback questions'),
                  data: (surveyDetail) {
                    return MulishText(text: surveyDetail.first.question);
                  },
                );
          },
        )).show();
    // showDialog(
    //   context: context,
    //   barrierDismissible: true,
    //   builder: (context) {
    //     return RatingDialog(
    //       initialRating: 1.0,
    //       title: const Text(
    //         'Your feedback',
    //         textAlign: TextAlign.center,
    //         style: TextStyle(
    //           fontSize: 25,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       message: const Text(
    //         'Please rate your experience on this transaction',
    //         textAlign: TextAlign.center,
    //         style: TextStyle(fontSize: 15),
    //       ),
    //       submitButtonText: 'Submit',
    //       commentHint: ' Do you have any other feedback?',
    //       onCancelled: () {},
    //       onSubmitted: (response) {
    //         Logger().d('rating: ${response.rating}, comment: ${response.comment}');
    //         if (response.rating == 5.0) {
    //           _showAppRatingDialog(context, onSubmitted);
    //         }
    //       },
    //     );
    //   },
    // );
  }

  static void _showAppRatingDialog(BuildContext context, Function() onSubmitted) {
    final isIOS = Platform.isIOS;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return RatingDialog(
          enableComment: false,
          initialRating: 1.0,
          title: const Text(
            'Enjoying Parafait SmartFun?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          image: Image.asset('assets/home/logo.png'),
          message: Text(
            'Tap a star to rate it on the ${isIOS ? 'App Store' : 'Play Store'}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15),
          ),
          submitButtonText: 'Submit',
          onCancelled: () {},
          onSubmitted: (response) {
            onSubmitted();
          },
        );
      },
    );
  }
}
