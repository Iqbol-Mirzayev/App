// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      currency: json['currency'] as String? ?? '',
      createdAt: DateTime.parse(json['created_at'] as String),
      count: json['count'] as int? ?? 0,
      userId: json['user_id'] as String? ?? '',
      totalPrice: (json['total_price'] as num?)?.toDouble() ?? 0.0,
      productId: json['product_id'] as String? ?? '',
      orderId: json['order_id'] as String? ?? '',
      orderStatus: json['order_status'] as String? ?? '',
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'product_id': instance.productId,
      'order_id': instance.orderId,
      'count': instance.count,
      'total_price': instance.totalPrice,
      'order_status': instance.orderStatus,
      'currency': instance.currency,
      'user_id': instance.userId,
      'created_at': instance.createdAt.toIso8601String(),
    };