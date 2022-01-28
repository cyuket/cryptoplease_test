import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_model.g.dart';

@JsonSerializable()
class TokenModel {
  TokenModel(
      {required this.id, required this.name, required this.symbol, this.price});
  String id;
  String symbol;
  String name;
  double? price;
  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);
}
