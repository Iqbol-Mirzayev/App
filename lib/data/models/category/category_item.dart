import 'package:json_annotation/json_annotation.dart';

part 'category_item.g.dart';

@JsonSerializable()
class CategoryItem {
  @JsonKey(defaultValue: "", name: "category_id")
  String categoryId;

  @JsonKey(defaultValue: "", name: "category_name")
  String categoryName;

  @JsonKey(defaultValue: "", name: "description")
  String description;

  @JsonKey(defaultValue: "", name: "image_url")
  String imageUrl;

  @JsonKey(name: "created_at")
  DateTime createdAt;

  CategoryItem({
    required this.imageUrl,
    required this.createdAt,
    required this.categoryName,
    required this.categoryId,
    required this.description,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) =>
      _$CategoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryItemToJson(this);
}