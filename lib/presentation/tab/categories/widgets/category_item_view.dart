import 'package:flutter/material.dart';
import 'package:shopping/data/models/category/category_item.dart';

class CategoryItemView extends StatelessWidget {
  const CategoryItemView({Key? key, required this.categoryItem})
      : super(key: key);

  final CategoryItem categoryItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                spreadRadius: 6,
                blurRadius: 5,
                offset: const Offset(3, 4),
                color: Colors.grey.withOpacity(0.3))
          ]),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            categoryItem.imageUrl,
            width: 60,
            height: 55,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          categoryItem.categoryName,
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
        subtitle: Text(
          categoryItem.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 13, color: Colors.black),
        ),
      ),
    );
  }
}