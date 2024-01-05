// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estimate_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EstimateTransactionResponse _$EstimateTransactionResponseFromJson(
        Map<String, dynamic> json) =>
    EstimateTransactionResponse(
      json['TransactionId'] as int,
      (json['TransactionAmount'] as num).toDouble(),
      (json['TaxAmount'] as num).toDouble(),
      (json['TransactionDiscountAmount'] as num).toDouble(),
      (json['TransactionNetAmount'] as num).toDouble(),
      (json['CouponDiscountAmount'] as num?)?.toDouble(),
      json['CouponNumber'] as String?,
      json['PrimaryCard'] as String?,
    );

Map<String, dynamic> _$EstimateTransactionResponseToJson(
    EstimateTransactionResponse instance) {
  final val = <String, dynamic>{
    'TransactionId': instance.transactionId,
    'TransactionAmount': instance.transactionAmount,
    'TaxAmount': instance.taxAmount,
    'TransactionDiscountAmount': instance.transactionDiscountAmount,
    'TransactionNetAmount': instance.transactionNetAmount,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('CouponDiscountAmount', instance.couponDiscountAmount);
  writeNotNull('CouponNumber', instance.couponNumber);
  writeNotNull('PrimaryCard', instance.primaryCard);
  return val;
}

AddCardProductResponse _$AddCardProductResponseFromJson(
        Map<String, dynamic> json) =>
    AddCardProductResponse(
      json['TransactionId'] as int,
      (json['TransactionAmount'] as num).toDouble(),
      (json['TransactionTaxTotal'] as num).toDouble(),
      (json['TransactionDiscountTotal'] as num).toDouble(),
      (json['TransactionNetAmount'] as num).toDouble(),
      (json['CouponDiscountAmount'] as num?)?.toDouble(),
      json['CouponNumber'] as String?,
      json['PrimaryCard'] as String?,
    );

Map<String, dynamic> _$AddCardProductResponseToJson(
    AddCardProductResponse instance) {
  final val = <String, dynamic>{
    'TransactionId': instance.transactionId,
    'TransactionAmount': instance.transactionAmount,
    'TransactionTaxTotal': instance.transactionTaxTotal,
    'TransactionDiscountTotal': instance.transactionDiscountTotal,
    'TransactionNetAmount': instance.transactionNetAmount,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('CouponDiscountAmount', instance.couponDiscountAmount);
  writeNotNull('CouponNumber', instance.couponNumber);
  writeNotNull('PrimaryCard', instance.primaryCard);
  return val;
}

EstimateTransactionRequest _$EstimateTransactionRequestFromJson(
        Map<String, dynamic> json) =>
    EstimateTransactionRequest(
      siteId: json['SiteId'] as int,
      customerId: json['CustomerId'] as int,
      userName: json['UserName'] as String,
      customerName: json['CustomerName'] as String,
      commitTransaction: json['CommitTransaction'] as bool,
      transactionLinesDTOList: (json['TransactionLinesDTOList']
              as List<dynamic>)
          .map((e) => TransactionLinesDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      discountApplicationHistoryDTOList:
          (json['DiscountApplicationHistoryDTOList'] as List<dynamic>)
              .map((e) => DiscountApplicationHistoryDTOList.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
      transactionId: json['TransactionId'] as int? ?? -1,
      posMachine: json['PosMachine'] as String? ?? 'CustomerApp',
      primaryCard: json['PrimaryCard'] as String? ?? '',
      closeTransaction: json['CloseTransaction'] as bool? ?? false,
      paymentProcessingCompleted:
          json['PaymentProcessingCompleted'] as bool? ?? false,
      reverseTransaction: json['ReverseTransaction'] as bool? ?? false,
    );

Map<String, dynamic> _$EstimateTransactionRequestToJson(
        EstimateTransactionRequest instance) =>
    <String, dynamic>{
      'TransactionId': instance.transactionId,
      'SiteId': instance.siteId,
      'PosMachine': instance.posMachine,
      'CustomerId': instance.customerId,
      'UserName': instance.userName,
      'CustomerName': instance.customerName,
      'PrimaryCard': instance.primaryCard,
      'CommitTransaction': instance.commitTransaction,
      'CloseTransaction': instance.closeTransaction,
      'PaymentProcessingCompleted': instance.paymentProcessingCompleted,
      'ReverseTransaction': instance.reverseTransaction,
      'TransactionLinesDTOList':
          instance.transactionLinesDTOList.map((e) => e.toJson()).toList(),
      'DiscountApplicationHistoryDTOList': instance
          .discountApplicationHistoryDTOList
          .map((e) => e.toJson())
          .toList(),
    };

TransactionLinesDTO _$TransactionLinesDTOFromJson(Map<String, dynamic> json) =>
    TransactionLinesDTO(
      productId: json['ProductId'] as int,
      transactionId: json['TransactionId'] as int? ?? -1,
      lineId: json['LineId'] as int? ?? -1,
      quantity: json['Quantity'] as num? ?? 1,
      cardNumber: json['CardNumber'] as String? ?? '',
      productName: json['ProductName'] as String?,
      taxAmount: json['TaxAmount'] as num?,
      amount: json['Amount'] as num?,
    );

Map<String, dynamic> _$TransactionLinesDTOToJson(TransactionLinesDTO instance) {
  final val = <String, dynamic>{
    'TransactionId': instance.transactionId,
    'LineId': instance.lineId,
    'ProductId': instance.productId,
    'Quantity': instance.quantity,
    'CardNumber': instance.cardNumber,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ProductName', instance.productName);
  writeNotNull('TaxAmount', instance.taxAmount);
  writeNotNull('Amount', instance.amount);
  return val;
}
