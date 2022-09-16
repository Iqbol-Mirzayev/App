import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/order/order_item.dart';
import '../../../view_models/order_view_model.dart';
import 'widgets/user_order_update.dart';

class OrdersAdminPage extends StatefulWidget {
  const OrdersAdminPage({Key? key}) : super(key: key);

  @override
  State<OrdersAdminPage> createState() => _OrdersAdminPageState();
}

class _OrdersAdminPageState extends State<OrdersAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Orders page"),
      ),
      body: StreamBuilder<List<OrderItem>>(
        stream: context.read<OrderViewModel>().getAllOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            List<OrderItem> userOrders = snapshot.data!;
            return ListView(
              children: List.generate(userOrders.length, (index) {
                var orderItem = userOrders[index];
                return UserOrderUpdate(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        orderUpdate,
                        arguments: orderItem,
                      );
                    },
                    onCancel: () {
                      context.read<OrderViewModel>().cancelOrder(
                            context: context,
                            orderItem: orderItem,
                          );
                    },
                    orderItem: orderItem);
              }),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}