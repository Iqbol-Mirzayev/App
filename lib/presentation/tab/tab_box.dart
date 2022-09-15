import 'package:flutter/material.dart';
import 'package:shopping/presentation/profile/profile_page.dart';
import 'package:shopping/utils/constants.dart';
import 'categories/categories_page.dart';
import 'products/products_page.dart';
import 'user_card/user_card_page.dart';

class TabBox extends StatefulWidget {
  const TabBox({Key? key}) : super(key: key);

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  int currentIndex = 0;

  List<Widget> screens = [
    CategoriesPage(),
    ProductsPage(),
    UserCardsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body:
          //screens[currentIndex],
          IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        iconSize: 24,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(color: Colors.green),
        items: [
          getItem(icon: Icons.category_sharp, labelText: "Category"),
          getItem(icon: Icons.border_all_outlined, labelText: "Products"),
          getItem(icon: Icons.shopping_basket_sharp, labelText: "Card"),
          getItem(icon: Icons.person, labelText: "admin", ),
        ],
      ),
    );
  }

  BottomNavigationBarItem getItem(
      {required IconData icon, required String labelText}) {
    return BottomNavigationBarItem(
    
        label: labelText,
        backgroundColor: Colors.grey,
        icon: Icon(
          icon,
          color: Colors.black,
        ),
        activeIcon: Icon(
          icon,
          color: Colors.white,
        ));
  }
}