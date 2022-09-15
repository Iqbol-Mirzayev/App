// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryItem _$CategoryItemFromJson(Map<String, dynamic> json) => CategoryItem(
      imageUrl: json['image_url'] as String? ?? '',
      createdAt: DateTime.parse(json['created_at'] as String),
      categoryName: json['category_name'] as String? ?? '',
      categoryId: json['category_id'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$CategoryItemToJson(CategoryItem instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'created_at': instance.createdAt.toIso8601String(),
    };