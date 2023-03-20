import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/utils/dialogs.dart';

import 'package:semnox/core/widgets/background_card_details.dart';

class ListOfCard extends StatelessWidget {
  const ListOfCard({Key? key, required this.data}) : super(key: key);

  final List<CardDetails> data;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 200.0),
      items: data.map((i) {
        bool hasBlocked = i.accountNumber!.startsWith('T') ? true : false;
        return Builder(
          builder: (BuildContext context) {
            // return Image.asset('assets/home/carousel_test.png');
            return BackgroundCard(
              isTemporary: hasBlocked,
              cardNumber: i.accountNumber!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${i.accountNumber}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 7.0),
                          Text(
                            '${i.accountIdentifier == '' ? '+ Add nickname' : i.accountIdentifier?.substring(0, 15)}',
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Dialogs.showBarcodeTempCard(context, i.accountNumber!),
                        child: Image.asset(
                          'assets/home/QR.png',
                          height: 42.0,
                          ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  OutlinedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: const BorderSide(
                            width: 1.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Get Balance',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    '${i.issueDate != null ? DateFormat('dd  MMM yyyy').format(i.issueDate as DateTime) : ''} ${i.expiryDate != null ? DateFormat('- dd  MMM yyyy').format(i.expiryDate as DateTime) : ''}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
