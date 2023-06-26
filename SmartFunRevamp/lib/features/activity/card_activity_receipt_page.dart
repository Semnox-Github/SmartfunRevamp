import 'dart:io';

import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:semnox/core/domain/entities/card_details/card_activity_details.dart';
import 'package:semnox/core/domain/use_cases/cards/get_card_activity_transaction_detail_use_case.dart';
import 'package:semnox/core/widgets/custom_app_bar.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';
import 'package:webcontent_converter/webcontent_converter.dart';
import 'package:semnox/core/utils/extensions.dart';

// TODO: this should not be hardcoded
const testHTML = """
 <div>\r<h2>FUN CITY INDIA</h2>\r<h2>Master</h2>\r<h2></h2>\r<p><strong>Date: </strong>05-Oct-2020</p>\r<p><strong>Invoice No: </strong>139812</p>\r<p><strong>OTP: </strong></p>\r<p><strong>NAME: </strong>Abhilash</p>\r<p><strong>PHONE: </strong>7760227031</p>\r<p><strong>EMAIL: </strong>abhilash.mathew@mailinator.com</p>\r\r<table>\r<tbody>\r<tr>\r<td>Product Details</td>\r<td>Price</td>\r<td>Quantity</td>\r<td>Amount</td>\r</tr>\r<tr>\r<td>@productName</td>\r<td>@price</td>\r<td>@quantity</td>\r<td><strong>@subTotal</strong></td>\r</tr>\r</tbody>\r</table>\r<p><strong>Tax Total GBP 0.00</strong></p>\r<p><strong>Discount GBP 0.00</strong></p>\r<p><strong>Grand Total GBP 10.00 </strong></p>\r<p><strong>Thank you for choosing FUN CITY</strong></p>\r</div>
""";
final _getReceipt = FutureProvider.autoDispose.family<CardActivityDetails, String>((ref, transactionId) async {
  final GetCardActivityTransactionDetailUseCase getTrxDetail = Get.find<GetCardActivityTransactionDetailUseCase>();
  final response = await getTrxDetail(transactionId, true);
  return response.fold(
    (l) => throw l,
    (r) => r,
  );
});

class CardActivityReceiptPage extends StatelessWidget {
  const CardActivityReceiptPage({super.key, required this.transactionId});
  final String transactionId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: SplashScreenNotifier.getLanguageLabel('Transaction Details'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: Consumer(
          builder: (context, ref, child) {
            return ref.watch(_getReceipt(transactionId)).maybeWhen(
                  orElse: () => Container(),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => const Center(
                    child: MulishText(
                      text: "We couldn't generate the receipt please try later.",
                      fontSize: 30.0,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  data: (data) {
                    if (data.receiptHTML.isNullOrEmpty()) {
                      return const Center(
                        child: MulishText(
                          text: "We couldn't generate the receipt please try later.",
                          fontSize: 30.0,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return Column(
                      children: [
                        Html(data: testHTML),
                        const Spacer(),
                        CustomIconButton(
                          onTap: () async {
                            Directory? appDocDir = await getApplicationDocumentsDirectory();
                            String appDocPath = appDocDir.path;
                            Logger().d(appDocPath);
                            var savedPath = '$appDocPath/receipt.pdf';
                            var result = await WebcontentConverter.contentToPDF(
                              content: testHTML,
                              savedPath: savedPath,
                              format: PaperFormat.a4,
                              margins: PdfMargins.px(top: 55, bottom: 55, right: 55, left: 55),
                            );
                            File fileDef = File(result!);
                            DocumentFileSavePlus().saveFile(fileDef.readAsBytesSync(), 'receipt.pdf', 'application/pdf');
                          },
                          label: SplashScreenNotifier.getLanguageLabel('DOWNLOAD'),
                          icon: const Icon(
                            Icons.download_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  },
                );
          },
        ),
      ),
    );
  }
}
