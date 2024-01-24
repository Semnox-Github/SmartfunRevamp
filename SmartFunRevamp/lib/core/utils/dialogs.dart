import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:open_filex/open_filex.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/data/datasources/local_data_source.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/buy_card/discount_entity.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/domain/entities/language/language_container_dto.dart';
import 'package:semnox/core/enums/contact_enum.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/image_handler.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/core/widgets/recharge_card_widget.dart';
import 'package:semnox/features/buy_a_card/pages/estimated_transaction_page.dart';
import 'package:semnox/features/buy_a_card/provider/estimate/estimate_provider.dart';
import 'package:semnox/features/orders/provider/orders_provider.dart';
import 'package:semnox/features/splash/after_splash_screen.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/features/recharge_card/providers/products_price_provider.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:url_launcher/url_launcher.dart';

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
                const ImageHandler(
                  height: 80.0,
                  imageKey: "coupon_congrats_image_path",
                )
              ],
            ),
            MulishText(
              text: SplashScreenNotifier.getLanguageLabel(
                  'Saved on the bill with the coupon'),
              fontColor: CustomColors.couponTextColor,
            )
          ],
        ),
      ),
    ).show();
  }

  static void getCoupongNumberDialog(BuildContext context, WidgetRef ref,
      CardProduct cardProduct, String? primaryCard, int qty) {
    final key = GlobalKey<FormState>();
    final siteId = ref.watch(selectedSiteIdProvider);
    bool isOkButtonPressed = false;
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
        if (!isOkButtonPressed) {
          if (key.currentState!.validate()) {
            key.currentState!.save();
            ref.read(estimateStateProvider.notifier).getEstimateTransaction(
                cardProduct,
                dtoList: DiscountApplicationHistoryDTOList(-1, coupon, -1),
                siteId: siteId,
                cardNumber: primaryCard,
                quantity: qty);
          }
        }
      },
    ).show();
  }

  static void selectLanguageDialog(BuildContext context, WidgetRef ref) {
    final currenLang = ref.watch(currentLanguageProvider);
    var newLang = ref.watch(currentLanguageProvider);
    final localDataSource = Get.find<LocalDataSource>();
    //final key = GlobalKey<FormState>();
    // final siteId = ref.watch(selectedSiteIdProvider);
    // String coupon = '';
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.scale,
      title: SplashScreenNotifier.getLanguageLabel('Select language'),
      desc: SplashScreenNotifier.getLanguageLabel('Select language'),
      descTextStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer(
            builder: (context, ref, child) {
              final langs = ref.watch(languangeContainerProvider);
              return DropdownButtonFormField<LanguageContainerDTOList>(
                isExpanded: true,
                value: currenLang,
                hint: const MulishText(text: 'Select a language'),
                items: langs?.languageContainerDTOList.map((item) {
                  return DropdownMenuItem<LanguageContainerDTOList>(
                    value: item,
                    child: Text(item.languageName),
                  );
                }).toList(),
                onChanged: (value) {
                  newLang = value;
                  // ref.read(currentLanguageProvider.notifier).state = value;
                },
              );
            },
          ),
        ],
      ),
      btnOkOnPress: () {
        localDataSource.saveCustomClass(
            LocalDataSource.kSelectedLanguage, newLang!.toJson());
        ref.read(currentLanguageProvider.notifier).state = newLang;
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
                      Html(
                        data: card.webDescription,
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          final parafaitDefault =
                              ref.watch(parafaitDefaultsProvider);
                          final currency = parafaitDefault?.getDefault(
                                  ParafaitDefaultsResponse.currencySymbol) ??
                              'USD';
                          final format = parafaitDefault?.getDefault(
                                  ParafaitDefaultsResponse.currencyFormat) ??
                              '#,##0.00';
                          return CustomButton(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EstimatedTransactionPage(
                                    cardProduct: card,
                                    transactionType: "newcard",
                                    qty: 1,
                                    finalPrice: 0,
                                  ),
                                ),
                              );
                            },
                            label: SplashScreenNotifier.getLanguageLabel(
                                    'BUY NOW @ &1')
                                .replaceAll(
                                    "&1",
                                    card.finalPrice
                                        .toCurrency(currency, format)),
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

  static void showMessageInfo(
      BuildContext context, String title, String meessge) {
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

  static void showErrorMessage(BuildContext context, String message,
      {Function()? onOkPress}) {
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
      btnOkOnPress: () {
        if (onOkPress != null) {
          onOkPress();
        }
      },
      btnOkText: SplashScreenNotifier.getLanguageLabel('OK'),
      btnOkColor: Colors.red,
    ).show();
  }

  static void showBarcodeTempCard(BuildContext context, String accountNumber) {
    String titleOfDialog = accountNumber.startsWith('T')
        ? SplashScreenNotifier.getLanguageLabel('Virtual Card')
        : SplashScreenNotifier.getLanguageLabel('Card');
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
                          barcode: cardCoachMark == 'BARCODE'
                              ? Barcode.code128()
                              : Barcode.qrCode(
                                  errorCorrectLevel:
                                      BarcodeQRCorrectionLevel.high),
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

  static void verifyDialog(BuildContext context, Function(String) onVerify,
      ContactType contactType) {
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
      btnCancel: SecondaryButton(
        onTap: () => Navigator.pop(context),
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
                  text:
                      '${SplashScreenNotifier.getLanguageLabel('Verify')} ${contactType.valueString}',
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 10.0),
                MulishText(
                  text: SplashScreenNotifier.getLanguageLabel(
                          'We have mailed you an OTP.\nEnter the OTP to verify your &1')
                      .replaceAll("&1", contactType.valueString),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 10.0),
                OtpPinField(
                    onSubmit: (otp) => {},
                    onChange: (code) => otp = code,
                    keyboardType: TextInputType.number,
                    otpPinFieldDecoration:
                        OtpPinFieldDecoration.defaultPinBoxDecoration,
                    otpPinFieldStyle: const OtpPinFieldStyle(
                      defaultFieldBorderColor: CustomColors.customOrange,
                      activeFieldBorderColor: CustomColors.hardOrange,
                    ),
                    maxLength: 6,
                    fieldHeight: MediaQuery.of(context).size.width * 0.07,
                    fieldWidth: MediaQuery.of(context).size.width * 0.07),
                const SizedBox(height: 10.0),
                MulishText(
                  text:
                      SplashScreenNotifier.getLanguageLabel("Didn't Receive?"),
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
                          text: SplashScreenNotifier.getLanguageLabel(
                              ' in 30 seconds'),
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
  static void _showAppRatingDialog(
      BuildContext context, Function() onSubmitted) {
    final isIOS = Platform.isIOS;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return RatingDialog(
          enableComment: false,
          initialRating: 1.0,
          title: Text(
            SplashScreenNotifier.getLanguageLabel(
                'Enjoying Parafait SmartFun?'),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          image: const ImageHandler(
            imageKey: "logo_image_path",
          ),
          message: Text(
            // 'Tap a star to rate it on the ${isIOS ? 'App Store' : 'Play Store'}',
            SplashScreenNotifier.getLanguageLabel(
                    'Tap a star to rate it on the &1')
                .replaceAll(
                    '&1',
                    isIOS
                        ? SplashScreenNotifier.getLanguageLabel('App Store')
                        : SplashScreenNotifier.getLanguageLabel('Play Store')),
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

  static void deleteProfileSuccessDialog(
      BuildContext context, Function() onSubmitted) {
    AwesomeDialog(
      context: context,
      dismissOnTouchOutside: true,
      onDismissCallback: (type) => onSubmitted(),
      title: SplashScreenNotifier.getLanguageLabel('Delete Profile'),
      desc: SplashScreenNotifier.getLanguageLabel(
          'Profile deleted successfully.'),
      descTextStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
    ).show();
  }

  static Future<void> downloadUpdateDialog(
      BuildContext context, String appUrl) async {
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.scale,
      descTextStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          MulishText(
              text: SplashScreenNotifier.getLanguageLabel(
                  "An updated version of the app is available. Do you wish to upgrade?"))
        ],
      ),
      btnOkOnPress: () {
        launchUrl(Uri.parse(appUrl), mode: LaunchMode.externalApplication);
      },
      btnCancelOnPress: () {},
    ).show();
  }

  static Future<void> lastTransactionDialog(
      BuildContext context, WidgetRef ref, String transactionId) async {
    ref
        .watch(
            OrdersProviders.orderSummaryDetailProviderResponse(transactionId))
        .maybeWhen(
            orElse: () => {null},
            data: (orderSummaryDetail) {
              ref
                  .watch(OrdersProviders.customerOrderStatusProviderResponse(
                      Get.find<CustomerDTO>().id.toString()))
                  .maybeWhen(
                      orElse: () => {null},
                      data: (customerOrderStatus) {
                        if (customerOrderStatus[0].transactionId.toString() ==
                            transactionId) {
                          GluttonLocalDataSource()
                              .deleteValue(LocalDataSource.kTransactionId);
                          AwesomeDialog(
                            context: context,
                            btnOkText:
                                SplashScreenNotifier.getLanguageLabel('Close'),
                            dialogType: DialogType.info,
                            animType: AnimType.scale,
                            title: "",
                            desc: "",
                            descTextStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                            body: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MulishText(
                                  text:
                                      customerOrderStatus[0].message.toString(),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                if (customerOrderStatus[0].transactionStatus ==
                                    "CLOSED")
                                  CustomButton(
                                    onTap: () => _createFileFromString(
                                        orderSummaryDetail.receipt.toString(),
                                        orderSummaryDetail.transactionId
                                            .toString()),
                                    label:
                                        SplashScreenNotifier.getLanguageLabel(
                                            'DOWNLOAD'),
                                  )
                              ],
                            ),
                            btnOkOnPress: () {},
                          ).show();
                        }
                      });
            });
  }

  static void _createFileFromString(String receipt, String fileName) async {
    var base64 = receipt;
    var bytes = base64Decode(base64);
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/$fileName.pdf");
    await file.writeAsBytes(bytes.buffer.asUint8List());
    debugPrint("${output.path}/$fileName.pdf");
    await OpenFilex.open("${output.path}/$fileName.pdf");
  }
}
