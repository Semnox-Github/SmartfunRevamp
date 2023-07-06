import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import 'package:semnox/features/payment/provider/payment_options_provider.dart';
import 'package:semnox/features/splash/after_splash_screen.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentOptionsPage extends ConsumerWidget {
  const PaymentOptionsPage({Key? key, required this.transactionResponse, required this.cardProduct, this.cardDetails, required this.transactionType, this.finalPrice}) : super(key: key);
  final EstimateTransactionResponse transactionResponse;
  final CardProduct cardProduct;
  final CardDetails? cardDetails;
  final String transactionType;
  final double? finalPrice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parafaitDefault = ref.watch(parafaitDefaultsProvider).value;
    final currency = parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencySymbol) ?? 'USD';
    final format = parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencyFormat) ?? '#,##0.00';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCFF8FF),
        elevation: 0.0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
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
                    transactionResponse.transactionNetAmount.toCurrency(currency, format),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Consumer(
              builder: (context, ref, child) {
                return ref.watch(PaymentOptionsProvider.paymentModesProvider).maybeWhen(
                      orElse: () => Container(
                        height: 20.0,
                        width: 20.0,
                        color: Colors.red,
                      ),
                      error: (e, s) => MulishText(
                        text: 'An error has ocurred $e',
                      ),
                      loading: () => const CircularProgressIndicator(),
                      data: (data) {
                        return PaymentOptionsWidged(
                            paymentOptionsList: data,
                            cardProduct: cardProduct,
                            transactionResponse: transactionResponse,
                            cardDetails: cardDetails,
                            transactionType: transactionType,
                            finalPrice: finalPrice);
                      },
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// stores ExpansionPanel state information
class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    required this.isExpanded,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(List<PaymentMode> paymentOptionsList) {
  return List<Item>.generate(paymentOptionsList.length, (int index) {
    return Item(
      headerValue: paymentOptionsList[index].paymentMode,
      expandedValue: (paymentOptionsList[index].paymentGateway as Map)["LookupValue"].toString(),
      // if there is only 1 payment option show expanded
      isExpanded: paymentOptionsList.length == 1 ? true : false
    );
  });
}

class PaymentOptionsWidged extends StatefulWidget {
  const PaymentOptionsWidged(
      {super.key, required this.paymentOptionsList, required this.transactionResponse, required this.cardProduct, this.cardDetails, required this.transactionType, this.finalPrice});
  final List<PaymentMode> paymentOptionsList;
  final EstimateTransactionResponse transactionResponse;
  final CardProduct cardProduct;
  final CardDetails? cardDetails;
  final String transactionType;
  final double? finalPrice;

  @override
  State<PaymentOptionsWidged> createState() => _PaymentOptionsWidgedState();
}

class _PaymentOptionsWidgedState extends State<PaymentOptionsWidged> {
  List<Item> _data = [];

  @override
  void initState() {
    _data = generateItems(widget.paymentOptionsList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.70,
      child: SingleChildScrollView(
        child: Container(
          child: _buildPanel(),
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          //Collapse all the panels to have max one panel expanded at the same time
          for(int i = 0; i < _data.length; i++) {                    
            _data[i].isExpanded = false;                    
          }
          //Then apply the change to current panel
          _data[index].isExpanded = !isExpanded;
          /*
            note: Due a library update the webview doesn't support multiple webviews loaded at the same time.
            The webview is loaded only if the expansion panel is expanded.
            Before a different panel is expended we need to be sure the other ones get collapsed to force the webview "to close".            
          */
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          //Only load if item.isExpanded because webview controller doesn't support multiple instances.
          body: item.isExpanded ? Consumer(
            builder: (context, ref, child) {
              return ref
              .watch(PaymentOptionsProvider.hostedPaymentGatewayProvider(HostedPaymentGatewayRequest(
                  hostedPaymentGateway: item.expandedValue, amount: widget.transactionResponse.transactionNetAmount, transactionId: widget.transactionResponse.transactionId)))
              .maybeWhen(
                orElse: () => Container(
                  height: 20.0,
                  width: 20.0,
                  color: Colors.red,
                ),
                error: (e, s) => MulishText(
                  text: 'An error has ocurred $e',
                ),
                loading: () => const CircularProgressIndicator(),
                data: (data) {                  
                  var webviewController = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);
                  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {Factory(() => EagerGestureRecognizer())};
                  //for some payment options the html string comes in GatewayRequestFormString instead of GatewayRequestString
                  final htmlString = data.gatewayRequestFormString ?? data.gatewayRequestString;                  
                  if (htmlString.isNotEmpty) {
                    webviewController.loadHtmlString(htmlString);
                    webviewController.setNavigationDelegate(
                      NavigationDelegate(
                        onProgress: (int progress) {
                          // Update loading bar.
                        },
                        onPageStarted: (String url) {},
                        onPageFinished: (String url) {},
                        onWebResourceError: (WebResourceError error) {},
                        onNavigationRequest: (NavigationRequest request) {
                          if (request.url.contains(data.successURL)) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentSuccessPage(
                                  amount: widget.transactionResponse.transactionNetAmount,
                                  cardNumber: widget.transactionResponse.primaryCard,
                                  transactionType: widget.transactionType,
                                  productName: widget.cardProduct.productName,
                                ),
                              ),
                            );
                            return NavigationDecision.navigate;
                          } else if (request.url.contains(data.failureURL)) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PaymentFailedPage(),
                              ),
                            );
                            return NavigationDecision.prevent;
                          } else if (request.url.contains(data.cancelURL)) {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     // builder: (context) => const PaymentSuccessPage(amount: 10, cardNumber: '123',),
                            //     builder: (context) => const PaymentFailedPage(),
                            //   ),
                            // );
                            return NavigationDecision.prevent;
                          }
                          return NavigationDecision.navigate;
                        },
                      ),
                    );
                    return SizedBox(
                      //If only one payment method then make the box bigger
                      height: _data.length == 1 ? (MediaQuery.of(context).size.height * 0.80) - 150 : (MediaQuery.of(context).size.height * 0.70) - 150,
                      child: WebViewWidget(controller: webviewController, gestureRecognizers: gestureRecognizers,),
                    );                                     
                  } else {
                    return Text(SplashScreenNotifier.getLanguageLabel("This payment mode is not available"));
                  }
                },
              );
            },
          ) 
          :
          Text(SplashScreenNotifier.getLanguageLabel("This item is collapsed"))
          ,
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
