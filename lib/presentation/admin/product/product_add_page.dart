import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../../data/models/category/category_item.dart';
import '../../../data/models/products/product_item.dart';
import '../../../utils/my_utils.dart';
import '../../../view_models/category_view_model.dart';
import '../../../view_models/file_view_model.dart';
import '../../../view_models/product_view_model.dart';
import '../../widgets/my_custom_button.dart';
import '../../widgets/universal_text_input.dart';
import 'widgets/select_button.dart';

class ProductAddPage extends StatefulWidget {
  const ProductAddPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductAddPage> createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController countController = TextEditingController();
  final TextEditingController productDescriptionController =
      TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  List<XFile> images = [];

  List<String> imageUrls = [
    "https://phoneaqua.com/og/samsung.jpg",
    "https://phoneaqua.com/og/samsung.jpg",
    "https://phoneaqua.com/og/samsung.jpg"
  ];

  String currencyText = "";
  CategoryItem? categoryItem;
  List<String> currencies = [
    "USD",
    "SO'M",
    "RUB",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Product Add Page"),
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: Colors.red)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    UniversalTextInput(
                      hintText: "Product name",
                      textController: productNameController,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20),
                    UniversalTextInput(
                      hintText: "Count",
                      textController: countController,
                      textInputType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 20),
                    UniversalTextInput(
                      hintText: "Price",
                      textController: priceController,
                      textInputType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 200,
                      child: TextFormField(
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                        controller: productDescriptionController,
                        textInputAction: TextInputAction.done,
                        maxLines: 100,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            hintText: "Description",
                            border: OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ExpansionTile(
                      title: Text(
                        currencyText.isEmpty ? "Select currency" : currencyText,
                      ),
                      children: List.generate(currencies.length, (index) {
                        String currency = currencies[index];
                        return SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                currencyText = currency;
                              });
                            },
                            child: Text(currency),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SelectButton(
                            text: "Upload Image",
                            onTap: () => selectImageDialog(context),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: SelectButton(
                            text: categoryItem == null
                                ? "Select category"
                                : categoryItem!.categoryName,
                            onTap: () {
                              selectCategoryDialog((selectedCategoryItem) {
                                setState(() {
                                  categoryItem = selectedCategoryItem;
                                });
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          imageUrls.length,
                          (index) => Image.network(
                            imageUrls[index],
                            width: 200,
                            height: 150,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50)
                  ],
                ),
              ),
            ),
            Positioned(
              left: 10,
              right: 10,
              bottom: 30,
              child: MyCustomButton(
                onTap: () {
                  String desc = productDescriptionController.text;
                  String name = productNameController.text;
                  String count = countController.text;
                  String price = priceController.text;
                  if (desc.isEmpty) {
                    MyUtils.getMyToast(message: "Enter product name");
                  } else if (count.isEmpty) {
                    MyUtils.getMyToast(message: "Enter count!");
                  } else if (price.isEmpty) {
                    MyUtils.getMyToast(message: "Enter price!");
                  } else if (name.isEmpty) {
                    MyUtils.getMyToast(message: "Enter category description");
                  } else if (currencyText.isEmpty) {
                    MyUtils.getMyToast(message: "Select currency");
                  } else if (imageUrls.isEmpty) {
                    MyUtils.getMyToast(message: "Upload product image!");
                  } else if (categoryItem == null) {
                    MyUtils.getMyToast(message: "Select category!");
                  } else {
                    context.read<ProductViewModel>().addProduct(
                        context: context,
                        productItem: ProductItem(
                          currency: currencyText,
                          createdAt: DateTime.now(),
                          count: int.parse(count),
                          categoryId: categoryItem!.categoryId,
                          description: desc,
                          productId: "",
                          price: double.parse(price),
                          productImages: imageUrls,
                          productName: name,
                        ));
                    Navigator.pop(context);
                  }
                },
                text: "Add Product",
              ),
            )
          ],
        ));
  }

  void selectCategoryDialog(ValueChanged<CategoryItem> categoryItem) {
    showCupertinoModalBottomSheet(
      topRadius: const Radius.circular(24),
      context: context,
      barrierColor: Colors.grey.withOpacity(0.3),
      builder: (context) => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 200,
        child: StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: StreamBuilder<List<CategoryItem>>(
                stream: context.read<CategoryViewModel>().getCategories(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.hasData) {
                    final categories = snapshot.data!;
                    return ListView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 12),
                      children: categories
                          .map((category) => ListTile(
                                title: Text(
                                  category.categoryName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                onTap: () {
                                  categoryItem.call(category);
                                  Navigator.pop(context);
                                },
                              ))
                          .toList(),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _getFromGallery() async {
    final selectedImages = await _picker.pickMultiImage(
      maxWidth: 720,
      maxHeight: 720,
    );
    if (selectedImages!.isNotEmpty) {
      images.addAll(selectedImages);
    }
    imageUrls = await context
        .read<FileViewModel>()
        .uploadProductImages(context, images);
    setState(() {});
  }

  Future<void> _getFromCamera() async {
    final selectedImage = await _picker.pickImage(
      maxWidth: 720,
      maxHeight: 720,
      source: ImageSource.camera,
    );
    image = selectedImage;
    imageUrl = await context.read<FileViewModel>().uploadImage(image!, context);
    setState(() {});
  }

  void selectImageDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              height: 150, //MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text(
                      'Gallery',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () async {
                      await _getFromGallery().then((value) {
                        Navigator.of(context).pop();
                      });
                    },
                  ),
                  // ListTile(
                  //   leading: const Icon(Icons.photo_camera),
                  //   title: const Text(
                  //     'Camera',
                  //     style: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 16,
                  //     ),
                  //   ),
                  //   onTap: () async {
                  //     await _getFromCamera().then(
                  //       (value) {
                  //         Navigator.of(context).pop();
                  //       },
                  //     );
                  //   },
                  // ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    productNameController.dispose();
    countController.dispose();
    productDescriptionController.dispose();
    super.dispose();
  }
}