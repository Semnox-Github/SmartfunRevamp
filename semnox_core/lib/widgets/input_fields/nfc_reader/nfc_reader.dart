import 'dart:async';
import 'package:barcode_reader/barcode_reader.dart';
import 'package:flutter/material.dart';
import 'package:nfc/nfc.dart';
import '../../../semnox_core.dart';
import 'semnox_ride_tap_card.dart';
part 'properties.dart';

class NfcCardReader extends StatelessWidget {
  const NfcCardReader({
    Key? key,
    required this.properties,
  }) : super(key: key);
  final SemnoxNFCReaderProperties properties;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SemnoxRideTapCard(
          title:
              "Tap Card" "${properties.canReadBarcode ? " Or Scan Code" : ""}",
          disableShadow: true,
          enableQrScan: properties.canReadBarcode,
        ),
        SemnoxText.bodyMed2(text: "--OR--"),
        Padding(
          padding: EdgeInsets.only(
            top: 32.mapToIdealWidth(context),
            // left: 32.mapToIdealWidth(context),
            // right: 32.mapToIdealWidth(context),
          ),
          child: Column(
            children: [
              SemnoxTextFormField(properties: properties),
              SizedBox(
                height: 32.mapToIdealHeight(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
