import 'package:json_annotation/json_annotation.dart';
part 'data.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class Data<T> {
  final T data;
  Data(this.data);
  factory Data.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$DataFromJson(
        json,
        (object) => fromJsonT(object),
      );
}
