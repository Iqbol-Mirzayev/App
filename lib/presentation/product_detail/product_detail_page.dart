import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/order/order_item.dart';
import '../../data/models/products/product_item.dart';
import '../../utils/my_utils.dart';
import '../../view_models/order_view_model.dart';
import '../widgets/my_custom_button.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key, required this.productItem})
      : super(key: key);

  final ProductItem productItem;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: const FlatAppBarBack(),
      body: Column(
        children: [
          const SizedBox(height: 16),
          CarouselSlider(
            items: List.generate(
                widget.productItem.productImages.length,
                (index) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          widget.productItem.productImages[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
            options: CarouselOptions(
              height: 200,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.productItem.productName,
                  style: MyTextStyle.sfProBold
                      .copyWith(fontSize: 20, color: MyColors.black),
                ),
                Row(
                  children: [
                    Text(
                      widget.productItem.currency,
                      style: MyTextStyle.sfProBold
                          .copyWith(fontSize: 16, color: MyColors.black),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.productItem.price.toString(),
                      style: MyTextStyle.sfProBold
                          .copyWith(fontSize: 16, color: MyColors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const SizedBox(width: 16),
              Text(
                "Description",
                style: MyTextStyle.sfProBold
                    .copyWith(fontSize: 20, color: MyColors.black),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
              child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.productItem.description,
                  style: MyTextStyle.sfProRegular
                      .copyWith(fontSize: 14, color: MyColors.black),
                  maxLines: 100,
                ),
              ),
            ],
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total:   ${widget.productItem.currency}  ${(count * widget.productItem.price).roundToDouble()}",
                  style: MyTextStyle.sfProBold
                      .copyWith(fontSize: 14, color: MyColors.black),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (count > 0) {
                          setState(() {
                            count -= 1;
                          });
                        }
                      },
                      icon: const Icon(Icons.remove),
                    ),
                    Text(
                      count.toString(),
                      style: MyTextStyle.sfProSemibold
                          .copyWith(fontSize: 16, color: MyColors.black),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (count < widget.productItem.count) {
                              count++;
                            } else
                              MyUtils.getMyToast(
                                  message: "Products not enough");
                          });
                        },
                        icon: const Icon(Icons.add)),
                  ],
                ),
              ],
            ),
          ),
          MyCustomButton(
              onTap: () {
                if (count > 0) {
                  OrderItem orderItem = OrderItem(
                    orderProductName: widget.productItem.productName,
                    currency: widget.productItem.currency,
                    createdAt: DateTime.now(),
                    count: count,
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    totalPrice: widget.productItem.price * count,
                    productId: widget.productItem.productId,
                    orderId: "",
                    orderStatus: "ORDERED",
                  );
                  context.read<OrderViewModel>().addOrder(
                        context: context,
                        orderItem: orderItem,
                        allProductsCount: widget.productItem.count,
                      );
                  Navigator.pop(context);
                } else {
                  MyUtils.getMyToast(message: "Not added");
                }
              },
              text: "Add to card"),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}