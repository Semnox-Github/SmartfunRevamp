import 'dart:convert';
import 'dart:io';

import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:path_provider/path_provider.dart';
import 'package:semnox/core/domain/use_cases/cards/get_card_activity_transaction_detail_use_case.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/custom_app_bar.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

final _getReceipt = FutureProvider.autoDispose.family<String, String>((ref, transactionId) async {
  final GetCardActivityTransactionDetailUseCase getTrxDetail = Get.find<GetCardActivityTransactionDetailUseCase>();
  final response = await getTrxDetail(transactionId, true);
  return response.fold(
    (l) => throw l,
    (r) async {
      final bytes = base64Decode(r.receipt ?? '');
      final output = await getTemporaryDirectory();
      final file = File("${output.path}/receipt.pdf");
      await file.writeAsBytes(bytes);
      return file.path;
    },
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
                  data: (path) {
                    if (path.isNullOrEmpty()) {
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
                        Expanded(
                          child: PDFView(
                            filePath: path,
                            enableSwipe: true,
                            swipeHorizontal: true,
                            autoSpacing: false,
                            pageFling: false,
                            onRender: (pages) {},
                            onError: (error) {},
                            onPageError: (page, error) {},
                            onViewCreated: (PDFViewController pdfViewController) {},
                          ),
                        ),
                        CustomButton(
                          onTap: () async {
                            File fileDef = File(path);
                            DocumentFileSavePlus().saveFile(fileDef.readAsBytesSync(), 'receipt.pdf', 'application/pdf');
                            if (Platform.isAndroid) {
                              Fluttertoast.showToast(msg: 'Receipt Downloaded');
                            }
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
