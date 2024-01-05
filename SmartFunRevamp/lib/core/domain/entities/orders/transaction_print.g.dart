// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_print.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionPrint _$TransactionPrintFromJson(Map<String, dynamic> json) =>
    TransactionPrint(
      json['Name'] as String,
      json['Format'] as String,
      json['DocumentType'] as String,
      json['TemplateId'] as int,
      json['POSPrinterId'] as int,
      json['Data'] as String,
    );

Map<String, dynamic> _$TransactionPrintToJson(TransactionPrint instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'Format': instance.format,
      'DocumentType': instance.documentType,
      'TemplateId': instance.templateId,
      'POSPrinterId': instance.pOSPrinterId,
      'Data': instance.data,
    };
