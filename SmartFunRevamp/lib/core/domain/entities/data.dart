import 'package:json_annotation/json_annotation.dart';
part 'data.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class Data<T> {
  final T data;
  Data(this.data);
  factory Data.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$DataFromJson(
        json,
        (object) => fromJsonT(object),
      );

  Map<String, dynamic> toJson(T? Function(T? value) toJsonT) =>
      _$DataToJson(this, toJsonT);
}

@JsonSerializable(genericArgumentFactories: true)
@JsonSerializable(genericArgumentFactories: true)
class ListDataWrapper<T> {
  final List<T> data;

  ListDataWrapper(this.data);

  factory ListDataWrapper.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ListDataWrapperFromJson(
        json,
        (object) => fromJsonT(object),
      );

  Map<String, dynamic> toJson(T Function(Object? json) toJsonT) =>
      _$ListDataWrapperToJson(
        this,
        (value) => toJsonT(value),
      );
}

// class ListDataWrapper<T> {
//   final List<T> data;

//   ListDataWrapper(this.data);
//   factory ListDataWrapper.fromJson(
//           Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
//       _$ListDataWrapperFromJson(
//         json,
//         (object) => fromJsonT(object),
//       );
//   Map<String, dynamic> toJson(T Function(Object? json) toJsonTo) =>
//       _$ListDataWrapperToJson(
//         this,
//         (value) => toJsonTo(value),
//       );
// }
