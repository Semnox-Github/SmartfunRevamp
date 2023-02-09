import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/buy_card/estimate_transaction_response.dart';
import 'package:semnox/core/domain/entities/payment/payment_mode.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/payment/provider/payment_options_provider.dart';


class PaymentOptionsPage extends StatelessWidget {
  const PaymentOptionsPage({Key? key, required this.transactionResponse, required this.cardProduct}) : super(key: key);
  final EstimateTransactionResponse transactionResponse;
  final CardProduct cardProduct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCFF8FF),
        elevation: 0.0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Payment Options',
          style: TextStyle(
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
            const Text(
              'Recharge Value',
              style: TextStyle(
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
                    '${cardProduct.credits} play credit',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${cardProduct.finalPrice}',
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
                      error: (e,s) => MulishText(
                        text: 'An error has ocurred $e',
                      ),
                      loading: () => const CircularProgressIndicator(),
                      data: (data) {
                        return PaymentOptionsWidged(paymentOptionsList: data);
                      },
                    );
              },
            ),
            const SizedBox(height: 10.0),
           
            const Spacer(),
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
      expandedValue: 'placeholder',
    );
  });
}

List<Item> generateItemsInt(int numberOfItems) {
  
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class PaymentOptionsWidged extends StatefulWidget {
  const PaymentOptionsWidged({super.key, required this.paymentOptionsList});
  final List<PaymentMode> paymentOptionsList;

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
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
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
          body: ListTile(
              title: Text(item.expandedValue),
              subtitle:
                  const Text('To delete this panel, tap the trash can icon'),
              trailing: const Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _data.removeWhere((Item currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
