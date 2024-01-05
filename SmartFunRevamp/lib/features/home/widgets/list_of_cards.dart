import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/utils/dialogs.dart';

import 'package:semnox/core/widgets/background_card_details.dart';
import 'package:semnox/core/widgets/image_handler.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class ListOfCard extends StatelessWidget {
  const ListOfCard({Key? key, required this.data}) : super(key: key);

  final List<CardDetails> data;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 200.0),
      items: data.map((i) {
        bool hasBlocked = i.accountNumber?.startsWith('T') ?? false ? true : false;
        late final DateTime timeNow = DateTime.now();
        late final DateTime expirationDate = i.expiryDate != null ? DateTime.parse(i.expiryDate.toString()) : timeNow;
        late final int daysUntilExpiration = (expirationDate.difference(timeNow).inHours / 24).round();
        return Builder(
          builder: (BuildContext context) {
            // return Image.asset('assets/home/carousel_test.png');
            return BackgroundCard(
              isVirtual: hasBlocked,
              isExpired: daysUntilExpiration < 0,
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
                            '${i.accountIdentifier == '' ? '+ ${SplashScreenNotifier.getLanguageLabel('Add nickname')}' : i.accountIdentifier?.substring(0, 15)}',
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
                        child: const ImageHandler(
                          height: 42.0,
                          imageKey: "QR_image_path",
                        ),
                      )
                    ],
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
