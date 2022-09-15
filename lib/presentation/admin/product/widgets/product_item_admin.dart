import 'package:flutter/material.dart';
import 'package:shopping/data/models/products/product_item.dart';

class ProductItemAdmin extends StatelessWidget {
  const ProductItemAdmin(
      {Key? key,
      required this.onDeleteTap,
      required this.onUpdateTap,
      required this.productItem})
      : super(key: key);

  final VoidCallback onDeleteTap;
  final VoidCallback onUpdateTap;
  final ProductItem productItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
        child: Image.network(
          productItem.productImages[0],
          width: 45,
          height: 45,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        productItem.productName,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        productItem.description,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: SizedBox(
        width: 96,
        child: Row(
          children: [
            IconButton(
                onPressed: onUpdateTap,
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blueAccent,
                )),
            IconButton(
              onPressed: onDeleteTap,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
      shape: const Border(
        bottom: BorderSide(),
      ),
    );
  }
}