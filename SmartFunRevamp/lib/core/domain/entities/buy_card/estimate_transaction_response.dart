import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'estimate_transaction_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class EstimateTransactionResponse extends Equatable {
  final int transactionId;
  final double transactionAmount;
  final double taxAmount;
  final double transactionDiscountAmount;
  final double transactionNetAmount;

  const EstimateTransactionResponse(
    this.transactionId,
    this.transactionAmount,
    this.taxAmount,
    this.transactionDiscountAmount,
    this.transactionNetAmount,
  );
  factory EstimateTransactionResponse.fromJson(Map<String, dynamic> json) => _$EstimateTransactionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EstimateTransactionResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable(fieldRename: FieldRename.pascal)
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

  EstimateTransactionRequest({
    required this.siteId,
    required this.customerId,
    required this.userName,
    required this.commitTransaction,
    required this.transactionLinesDTOList,
    this.transactionId = -1,
    this.posMachine = 'webplatform',
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

  TransactionLinesDTO({
    required this.productId,
    this.transactionId = -1,
    this.lineId = -1,
    this.quantity = 1,
    this.cardNumber = '',
  });
  factory TransactionLinesDTO.fromJson(Map<String, dynamic> json) => _$TransactionLinesDTOFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionLinesDTOToJson(this);
}
