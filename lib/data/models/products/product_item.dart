import 'package:json_annotation/json_annotation.dart';

part 'product_item.g.dart';

@JsonSerializable()
class ProductItem {
  @JsonKey(defaultValue: "", name: "product_id")
  String productId;

  @JsonKey(defaultValue: "", name: "category_id")
  String categoryId;

  @JsonKey(defaultValue: 0, name: "count")
  int count;

  @JsonKey(defaultValue: 0.0, name: "price")
  double price;

  @JsonKey(defaultValue: "", name: "product_name")
  String productName;

  @JsonKey(defaultValue: "", name: "currency")
  String currency;

  @JsonKey(defaultValue: "", name: "description")
  String description;

  @JsonKey(defaultValue: [], name: "product_images")
  List<String>  productImages;

  @JsonKey(name: "created_at")
  DateTime createdAt;

  ProductItem({
    required this.currency,
    required this.createdAt,
    required this.count,
    required this.categoryId,
    required this.description,
    required this.productId,
    required this.price,
    required this.productImages,
    required this.productName,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) =>
      _$ProductItemFromJson(json);

  Map<String, dynamic> toJson() => _$ProductItemToJson(this);
}