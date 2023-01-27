part of 'nfc_reader.dart';

class SemnoxNFCReaderProperties extends SemnoxTextFieldProperties {
  SemnoxNFCReaderProperties({
    ///
    ///Defaults to true,
    ///
    bool autoStartListening = true,
    String? initialValue,
    bool isObscured = false,
    String? label,
    String? hintText,
    TextInputType inputType = TextInputType.text,
    int maxLines = 1,
    List<ValidatorFunction> validators = const [],
    this.canReadBarcode = false,
    // bool enableTyping = true,
  }) : super(
          label: label,
          inputType: inputType,
          isObscured: isObscured,
          hintText: hintText,
          maxLines: maxLines,
          validators: validators,
        ) {
    if (autoStartListening) startListening();
  }
  StreamSubscription<NFCReadData>? _subscription;
  final bool canReadBarcode;

  ///
  /// Starts to listning the NFC Card Tap.
  ///
  void startListening() {
    _subscription = _nfcManager.dataStream.listen((event) {
      textEditingController.text = extractIdFromMessage(event.data) ?? "";
    });

    _nfcManager.startScan();
    if (canReadBarcode) BarcodeReader.instance.registerCallback(_readBarcode);
  }

  void _readBarcode(String data) {
    textEditingController.text = data;
  }

  ///
  /// Stops to listning the NFC Card Tap.
  ///
  void stop() {
    _subscription?.cancel();
    _nfcManager.stop();
    BarcodeReader.instance.unregisterCallback(_readBarcode);
  }

  NFCManager _nfcManager = NFCManager();

  String? extractIdFromMessage(Map<String, dynamic> message) {
    final nfcadata = message["nfca"];
    if (nfcadata != null) {
      List identifierList = nfcadata["identifier"];
      String identifier = "";

      for (var item in identifierList) {
        identifier +=
            int.tryParse("$item")?.toRadixString(16).padLeft(2, "0") ?? "";
      }
      return identifier.toUpperCase();
    }
    return null;
  }
}
