import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/order/order_item.dart';
import '../../../view_models/order_view_model.dart';

class UserCardsPage extends StatefulWidget {
  const UserCardsPage({Key? key}) : super(key: key);

  @override
  State<UserCardsPage> createState() => _UserCardsPageState();
}

class _UserCardsPageState extends State<UserCardsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: const FlatAppBarText(
        title: "My Orders",
      ),
      body: StreamBuilder<List<OrderItem>>(
        stream: context.read<OrderViewModel>().getAllUserOrders(
              userId: FirebaseAuth.instance.currentUser!.uid,
            ),
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
                return UserOrderItem(
                    onTap: () {},
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