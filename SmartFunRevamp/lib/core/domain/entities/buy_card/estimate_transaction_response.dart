import 'package:json_annotation/json_annotation.dart';

import 'discount_entity.dart';
part 'estimate_transaction_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class EstimateTransactionResponse {
  final int transactionId;
  final double transactionAmount;
  final double taxAmount;
  final double transactionDiscountAmount;
  final double transactionNetAmount;
  //TODO:Put final again
  double? couponDiscountAmount;
  String? couponNumber;

  EstimateTransactionResponse(
    this.transactionId,
    this.transactionAmount,
    this.taxAmount,
    this.transactionDiscountAmount,
    this.transactionNetAmount,
    this.couponDiscountAmount,
    this.couponNumber,
  );
  factory EstimateTransactionResponse.fromJson(Map<String, dynamic> json) => _$EstimateTransactionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EstimateTransactionResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class EstimateTransactionRequest {
  final int transactionId;
  final int siteId;
  final String posMachine;
  final int customerId;
  final String userName;
  final String primaryCard;
  final bool commitTransaction;
  final bool closeTransaction;
  final bool paymentProcessingCompleted;
  final bool reverseTransaction;
  final List<TransactionLinesDTO> transactionLinesDTOList;
  final List<DiscountApplicationHistoryDTOList> discountApplicationHistoryDTOList;

  EstimateTransactionRequest({
    required this.siteId,
    required this.customerId,
    required this.userName,
    required this.commitTransaction,
    required this.transactionLinesDTOList,
    required this.discountApplicationHistoryDTOList,
    this.transactionId = -1,
    this.posMachine = 'CustomerApp',
    this.primaryCard = '',
    this.closeTransaction = false,
    this.paymentProcessingCompleted = false,
    this.reverseTransaction = false,
  });
  factory EstimateTransactionRequest.fromJson(Map<String, dynamic> json) => _$EstimateTransactionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$EstimateTransactionRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class TransactionLinesDTO {
  final int transactionId;
  final int lineId;
  final int productId;
  final int quantity;
  final String cardNumber;
  final String? productName;
  final num? taxAmount;

  TransactionLinesDTO({
    required this.productId,
    this.transactionId = -1,
    this.lineId = -1,
    this.quantity = 1,
    this.cardNumber = '',
    this.productName,
    this.taxAmount,
  });
  factory TransactionLinesDTO.fromJson(Map<String, dynamic> json) => _$TransactionLinesDTOFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionLinesDTOToJson(this);
}
