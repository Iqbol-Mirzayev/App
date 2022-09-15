import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopping/data/models/order/order_item.dart';

class UserOrderUpdate extends StatelessWidget {
  const UserOrderUpdate({
    Key? key,
    required this.orderItem,
    required this.onCancel,
    required this.onTap,
  }) : super(key: key);
  final OrderItem orderItem;
  final VoidCallback onCancel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.symmetric(vertical: 16),
      height: 70,
      child: ListTile(
        onTap: onTap,
        title: Text(
          orderItem.orderProductName,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
            "${orderItem.count} x ${orderItem.totalPrice / orderItem.count} = ${orderItem.totalPrice} ${orderItem.currency}\n${orderItem.orderStatus}"),
        trailing: SizedBox(
          width: 120,
          child: Row(
            children: [
              Text(DateFormat.yMd().format(orderItem.createdAt)),
              IconButton(
                onPressed: onCancel,
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
        shape: const Border(
          bottom: BorderSide(),
        ),
      ),
    );
  }
}