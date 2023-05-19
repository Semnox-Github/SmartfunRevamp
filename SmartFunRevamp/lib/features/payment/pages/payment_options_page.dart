import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/buy_card/estimate_transaction_response.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/domain/entities/payment/hosted_payment_gateway_request.dart';
import 'package:semnox/core/domain/entities/payment/payment_mode.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/payment/pages/payment_failed_page.dart';
import 'package:semnox/features/payment/pages/payment_success_page.dart';
import 'package:semnox/features/payment/provider/payment_options_provider.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentOptionsPage extends StatelessWidget {
  const PaymentOptionsPage({Key? key, required this.transactionResponse, required this.cardProduct, this.cardDetails, required this.transactionType, this.finalPrice}) : super(key: key);
  final EstimateTransactionResponse transactionResponse;
  final CardProduct cardProduct;
  final CardDetails? cardDetails;
  final String transactionType;
  final double? finalPrice;

  @override
  Widget build(BuildContext context) {
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
                    '${cardProduct.credits} ${SplashScreenNotifier.getLanguageLabel('play credit')}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${cardProduct.productType == "VARIABLECARD" ? finalPrice : transactionResponse.transactionNetAmount}',
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
                        return PaymentOptionsWidged(paymentOptionsList: data, cardProduct: cardProduct, transactionResponse: transactionResponse, cardDetails: cardDetails, transactionType: transactionType, finalPrice: finalPrice);
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
    this.isExpanded = false,
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
    );
  });
}

class PaymentOptionsWidged extends StatefulWidget {
  const PaymentOptionsWidged({super.key, required this.paymentOptionsList, required this.transactionResponse, required this.cardProduct, this.cardDetails, required this.transactionType, this.finalPrice});
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

  final gestureRecognizers = {
    Factory(() => EagerGestureRecognizer()),
  };

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
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: Consumer(
            builder: (context, ref, child) {
              return ref
                  .watch(PaymentOptionsProvider.hostedPaymentGatewayProvider(
                      HostedPaymentGatewayRequest(hostedPaymentGateway: item.expandedValue, amount: widget.cardProduct.productType == "VARIABLECARD" ? widget.finalPrice! : widget.transactionResponse.transactionNetAmount, transactionId: widget.transactionResponse.transactionId)))
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
                      //for some payment options the html string comes in GatewayRequestFormString instead of GatewayRequestString
                      final htmlString = data.gatewayRequestFormString ?? data.gatewayRequestString;
                      if (htmlString.isNotEmpty) {
                        return SizedBox(
                          height: (MediaQuery.of(context).size.height * 0.70) -150 ,
                          child: WebView(
                            gestureRecognizers: gestureRecognizers,
                            navigationDelegate: (NavigationRequest request) {
                              if (request.url.contains(data.successURL)) {                          
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PaymentSuccessPage(
                                      amount: widget.transactionResponse.transactionNetAmount,
                                      cardNumber: widget.transactionResponse.primaryCard,
                                      transactionType: widget.transactionType
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
                            initialUrl: Uri.dataFromString(htmlString, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString(),
                            javascriptMode: JavascriptMode.unrestricted
                          ),
                        );
                      } else {
                        return Text(SplashScreenNotifier.getLanguageLabel("This payment mode is not available"));
                      }
                    },
                  );
            },
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
