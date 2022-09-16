import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/order/order_item.dart';
import '../../../view_models/order_view_model.dart';
import '../../widgets/my_custom_button.dart';

class OrderUpdatePage extends StatefulWidget {
  const OrderUpdatePage({Key? key, required this.orderItem}) : super(key: key);

  final OrderItem orderItem;

  @override
  State<OrderUpdatePage> createState() => _OrderUpdatePageState();
}

class _OrderUpdatePageState extends State<OrderUpdatePage> {
  String statusText = "";
  List<String> statuses = [
    "ORDERED",
    "IN THE PROGRESS",
    "DELIVERED",
  ];

  @override
  void initState() {
    statusText = widget.orderItem.orderStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Order Update Page"),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1, color: Colors.red)),
        child: Column(
          children: [
            ExpansionTile(
              title: Text(
                statusText.isEmpty ? "Select Status" : statusText,
              ),
              children: List.generate(statuses.length, (index) {
                String currency = statuses[index];
                return SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        statusText = currency;
                      });
                    },
                    child: Text(currency),
                  ),
                );
              }),
            ),
            MyCustomButton(
              onTap: () {
                context.read<OrderViewModel>().updateOrderStatus(
                      status: statusText,
                      docId: widget.orderItem.orderId,
                    );
                Navigator.pop(context);
              },
              text: "Update Order Status",
            )
          ],
        ),
      ),
    );
  }
}