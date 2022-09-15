import 'package:json_annotation/json_annotation.dart';

part 'order_item.g.dart';

@JsonSerializable()
class OrderItem {
  @JsonKey(defaultValue: "", name: "product_id")
  String productId;

  @JsonKey(defaultValue: "", name: "order_id")
  String orderId;

  @JsonKey(defaultValue: 0, name: "count")
  int count;

  @JsonKey(defaultValue: 0.0, name: "total_price")
  double totalPrice;

  @JsonKey(defaultValue: "", name: "order_status")
  String orderStatus;

  @JsonKey(defaultValue: "", name: "currency")
  String currency;

   @JsonKey(defaultValue: "", name: "order_product_name")
  String orderProductName;

  @JsonKey(defaultValue: "", name: "user_id")
  String userId;

  @JsonKey(name: "created_at")
  DateTime createdAt;

  OrderItem({
    required this.currency,
    required this.createdAt,
    required this.count,
    required this.userId,
    required this.totalPrice,
    required this.productId,
    required this.orderId,
    required this.orderStatus,
    required this.orderProductName});

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}