// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductItem _$ProductItemFromJson(Map<String, dynamic> json) => ProductItem(
      currency: json['currency'] as String? ?? '',
      createdAt: DateTime.parse(json['created_at'] as String),
      count: json['count'] as int? ?? 0,
      categoryId: json['category_id'] as String? ?? '',
      description: json['description'] as String? ?? '',
      productId: json['product_id'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      productImages: (json['product_images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      productName: json['product_name'] as String? ?? '',
    );

Map<String, dynamic> _$ProductItemToJson(ProductItem instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'category_id': instance.categoryId,
      'count': instance.count,
      'price': instance.price,
      'product_name': instance.productName,
      'currency': instance.currency,
      'description': instance.description,
      'product_images': instance.productImages,
      'created_at': instance.createdAt.toIso8601String(),
    };