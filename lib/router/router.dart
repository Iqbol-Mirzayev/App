import 'package:flutter/material.dart';
import '../data/models/category/category_item.dart';
import '../data/models/category/update_arguments.dart';
import '../data/models/order/order_item.dart';
import '../data/models/products/product_item.dart';
import '../main.dart';
import '../presentation/admin/admin_page.dart';
import '../presentation/admin/category/category_add_page.dart';
import '../presentation/admin/category/category_admin_page.dart';
import '../presentation/admin/category/category_update_page.dart';
import '../presentation/admin/order/order_update_page.dart';
import '../presentation/admin/order/orders_admin_page.dart';
import '../presentation/admin/product/product_add_page.dart';
import '../presentation/admin/product/products_admin_page.dart';
import '../presentation/on_boarding/on_boarding_screen.dart';
import '../presentation/product_detail/product_detail_page.dart';
import '../presentation/splash/splash_page.dart';
import '../presentation/start/start_page.dart';
import '../presentation/tab/account/sub_screens/profile/profile_page.dart';
import '../presentation/tab/account/sub_screens/settings/settings_screen.dart';
import '../presentation/tab/categories/category_products/category_products.dart';
import '../presentation/tab/tab_box.dart';
import '../utils/constants.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainPage:
        return MaterialPageRoute(builder: (_) => MainPage());
      case homePage:
        return MaterialPageRoute(builder: (_) => TabBox());
      case profilePage:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case adminPage:
        return MaterialPageRoute(builder: (_) => AdminPage());
      case adminCategories:
        return MaterialPageRoute(builder: (_) => CategoriesAdminPage());
      case adminProducts:
        return MaterialPageRoute(builder: (_) => ProductsAdminPage());
      case adminOrders:
        return MaterialPageRoute(builder: (_) => OrdersAdminPage());
      case addCategory:
        return MaterialPageRoute(builder: (_) => CategoryAddPage());
      case addProduct:
        return MaterialPageRoute(builder: (_) => ProductAddPage());
      case splashPage:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case onBoardingPage:
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
      case startPage:
        return MaterialPageRoute(builder: (_) => StartPage());
      case settingsPage:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      // case chatPage:
      //   return MaterialPageRoute(builder: (_) => HelpScreen());
      case categoryProductsPage:
        return MaterialPageRoute(
            builder: (_) => CategoryProducts(
                categoryItem: settings.arguments as CategoryItem));
      case orderUpdate:
        return MaterialPageRoute(
            builder: (_) =>
                OrderUpdatePage(orderItem: settings.arguments as OrderItem));
      case productDetail:
        return MaterialPageRoute(
            builder: (_) => ProductDetailPage(
                productItem: settings.arguments as ProductItem));
      case updateCategory:
        return MaterialPageRoute(
            builder: (_) => CategoryUpdatePage(
                updateCategoryArgs: settings.arguments as UpdateCategoryArgs));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}