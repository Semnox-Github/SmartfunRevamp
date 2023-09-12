import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/buy_card/estimate_transaction_response.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/domain/entities/payment/hosted_payment_gateway_request.dart';
import 'package:semnox/core/domain/entities/payment/payment_mode.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/payment/pages/payment_failed_page.dart';
import 'package:semnox/features/payment/pages/payment_success_page.dart';
import 'package:semnox/features/payment/provider/hosted_payment_provider/hosted_payment_provider.dart';
import 'package:semnox/features/payment/provider/payment_options_provider.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentOptionsPage extends ConsumerWidget {
  const PaymentOptionsPage(
      {Key? key,
      required this.transactionResponse,
      required this.cardProduct,
      this.cardDetails,
      required this.transactionType,
      this.finalPrice})
      : super(key: key);
  final EstimateTransactionResponse transactionResponse;
  final CardProduct cardProduct;
  final CardDetails? cardDetails;
  final String transactionType;
  final double? finalPrice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parafaitDefault = ref.watch(parafaitDefaultsProvider);
    final currency =
        parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencySymbol) ??
            'USD';
    final format =
        parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencyFormat) ??
            '#,##0.00';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          SplashScreenNotifier.getLanguageLabel('Payment Options'),
          style: const TextStyle(
            color: CustomColors.customBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              SplashScreenNotifier.getLanguageLabel('Recharge Value'),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEEB2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cardProduct.productName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    transactionResponse.transactionNetAmount
                        .toCurrency(currency, format),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  return ref
                      .watch(PaymentOptionsProvider.paymentModesProvider)
                      .when(
                        error: (e, s) =>
                            MulishText(text: 'An error has ocurred $e'),
                        loading: () => const Center(
                            child: CircularProgressIndicator.adaptive()),
                        data: (data) {
                          return ExpansionPaymentMethodsList(
                            paymentsMode: data,
                            transactionResponse: transactionResponse,
                            cardProduct: cardProduct,
                            transactionType: transactionType,
                            cardDetails: cardDetails,
                            finalPrice: finalPrice,
                          );
                        },
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PanelItem {
  PanelItem({
    required this.paymentMode,
    required this.isExpanded,
  });

  PaymentMode paymentMode;
  bool isExpanded;
}

class ExpansionPaymentMethodsList extends StatefulWidget {
  const ExpansionPaymentMethodsList({
    super.key,
    required this.paymentsMode,
    required this.transactionResponse,
    required this.cardProduct,
    this.cardDetails,
    required this.transactionType,
    this.finalPrice,
  });
  final List<PaymentMode> paymentsMode;
  final EstimateTransactionResponse transactionResponse;
  final CardProduct cardProduct;
  final CardDetails? cardDetails;
  final String transactionType;
  final double? finalPrice;
  @override
  State<ExpansionPaymentMethodsList> createState() =>
      _ExpansionPaymentMethodsListState();
}

class _ExpansionPaymentMethodsListState
    extends State<ExpansionPaymentMethodsList> {
  List<PanelItem> _data = [];
  final webviewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  @override
  void initState() {
    super.initState();
    _data = widget.paymentsMode
        .map((e) => PanelItem(
            paymentMode: e,
            isExpanded: widget.paymentsMode.length == 1 ? true : false))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, __) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.70,
          child: SingleChildScrollView(
            child: ExpansionPanelList(
              expansionCallback: (panelIndex, _) {
                setState(
                  () {
                    for (var i = 0; i < _data.length; i++) {
                      if (i == panelIndex && _data[i].isExpanded == false) {
                        _data[i].isExpanded = true;
                        ref.read(hostedPaymentProvider.notifier).getHtml(
                              HostedPaymentGatewayRequest(
                                hostedPaymentGateway: _data[panelIndex]
                                        .paymentMode
                                        .paymentGateway
                                        ?.lookupValue ??
                                    '',
                                amount: widget
                                    .transactionResponse.transactionNetAmount,
                                transactionId:
                                    widget.transactionResponse.transactionId,
                              ),
                            );
                      } else {
                        _data[i].isExpanded = false;
                      }
                    }
                  },
                );
              },
              children: _data.map(
                (panelItem) {
                  return ExpansionPanel(
                    isExpanded: panelItem.isExpanded,
                    headerBuilder: (_, __) => ListTile(
                      title: MulishText(
                        text: panelItem.paymentMode.paymentMode,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    body: ref.watch(hostedPaymentProvider).when(
                          initial: () => Container(),
                          inProgress: () =>
                              const CircularProgressIndicator.adaptive(),
                          error: (msg) => const Icon(Icons.error,
                              color: Colors.green, size: 30.0),
                          success: (data) {
                            final htmlString = data.gatewayRequestFormString ??
                                data.gatewayRequestString;
                            final Set<Factory<OneSequenceGestureRecognizer>>
                                gestureRecognizers = {
                              Factory(() => EagerGestureRecognizer())
                            };
                            if (htmlString.isNotEmpty && panelItem.isExpanded) {
                              final uri = Uri.parse(Uri.dataFromString(
                                      htmlString,
                                      mimeType: 'text/html',
                                      encoding: Encoding.getByName('UTF-8'))
                                  .toString());
                              webviewController.loadRequest(uri);
                              webviewController.setNavigationDelegate(
                                NavigationDelegate(
                                  onNavigationRequest:
                                      (NavigationRequest request) {
                                    Logger().e(request.url);
                                    //Lookups callback URLs
                                    if (request.url.contains(
                                        SplashScreenNotifier.getLookupValue(
                                            "SUCCESS_REDIRECT_URL"))) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PaymentSuccessPage(
                                            amount: widget.transactionResponse
                                                .transactionNetAmount,
                                            cardNumber: widget
                                                .transactionResponse
                                                .primaryCard,
                                            transactionType:
                                                widget.transactionType,
                                            productName:
                                                widget.cardProduct.productName,
                                          ),
                                        ),
                                      );
                                      return NavigationDecision.navigate;
                                    } else if (request.url.contains(
                                        SplashScreenNotifier.getLookupValue(
                                            "FAILURE_REDIRECT_URL"))) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PaymentFailedPage(),
                                        ),
                                      );
                                      return NavigationDecision.prevent;
                                    } else if (request.url.contains(
                                        SplashScreenNotifier.getLookupValue(
                                            "CANCEL_REDIRECT_URL"))) {
                                      return NavigationDecision.prevent;
                                    }
                                    //Payment Method callback URLs
                                    if (request.url
                                        .contains(data.successURL.toString())) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PaymentSuccessPage(
                                            amount: widget.transactionResponse
                                                .transactionNetAmount,
                                            cardNumber: widget
                                                .transactionResponse
                                                .primaryCard,
                                            transactionType:
                                                widget.transactionType,
                                            productName:
                                                widget.cardProduct.productName,
                                          ),
                                        ),
                                      );
                                      return NavigationDecision.navigate;
                                    } else if (request.url
                                        .contains(data.failureURL.toString())) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PaymentFailedPage(),
                                        ),
                                      );
                                      return NavigationDecision.prevent;
                                    } else if (request.url
                                        .contains(data.cancelURL.toString())) {
                                      return NavigationDecision.prevent;
                                    }
                                    return NavigationDecision.navigate;
                                  },
                                ),
                              );
                              return SizedBox(
                                height: _data.length > 1
                                    ? (MediaQuery.of(context).size.height *
                                            0.70) -
                                        150
                                    : (MediaQuery.of(context).size.height *
                                            0.80) -
                                        150,
                                child: WebViewWidget(
                                  controller: webviewController,
                                  gestureRecognizers: gestureRecognizers,
                                ),
                              );
                            } else {
                              return Column(
                                children: [
                                  const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                  MulishText(
                                    text: SplashScreenNotifier.getLanguageLabel(
                                        "This payment mode is not available"),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                  );
                },
              ).toList(),
            ),
          ),
        );
      },
    );
  }
}
