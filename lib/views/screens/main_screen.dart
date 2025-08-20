import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:gebiya_web_admin/views/screens/side_bar_screens/categories_screen.dart';
import 'package:gebiya_web_admin/views/screens/side_bar_screens/dashboard_screen.dart';
import 'package:gebiya_web_admin/views/screens/side_bar_screens/orders_screen.dart';
import 'package:gebiya_web_admin/views/screens/side_bar_screens/product_screen.dart';
import 'package:gebiya_web_admin/views/screens/side_bar_screens/upload_banner_screen.dart';
import 'package:gebiya_web_admin/views/screens/side_bar_screens/vendors_screen.dart';
import 'package:gebiya_web_admin/views/screens/side_bar_screens/withdrowal_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedItem = DashboardScreen();
  screenSelector(item) {
    switch (item.route) {
      case DashboardScreen.routeName:
        setState(() {
          _selectedItem = DashboardScreen();
        });
        break;
      case VendorsScreen.routeName:
        setState(() {
          _selectedItem = VendorsScreen();
        });
        break;
      case WithdrowalScreen.routeName:
        setState(() {
          _selectedItem = WithdrowalScreen();
        });
        break;
      case OrdersScreen.routeName:
        setState(() {
          _selectedItem = OrdersScreen();
        });
        break;
      case CategoriesScreen.routeName:
        setState(() {
          _selectedItem = CategoriesScreen();
        });
        break;
      case ProductScreen.routeName:
        setState(() {
          _selectedItem = ProductScreen();
        });
        break;
      case UploadBannerScreen.routeName:
        setState(() {
          _selectedItem = UploadBannerScreen();
        });

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text(" Gebiya Admin Panel"),
      ),
      sideBar: SideBar(
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            route: DashboardScreen.routeName,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Vendors',
            route: VendorsScreen.routeName,
            icon: CupertinoIcons.person_3,
          ),
          AdminMenuItem(
            title: 'Withdrowal ',
            route: WithdrowalScreen.routeName,
            icon: CupertinoIcons.money_dollar,
          ),
          AdminMenuItem(
            title: 'Orders ',
            route: OrdersScreen.routeName,
            icon: CupertinoIcons.shopping_cart,
          ),
          AdminMenuItem(
            title: 'Category  ',
            route: CategoriesScreen.routeName,
            icon: Icons.category,
          ),
          AdminMenuItem(
            title: 'Product ',
            route: ProductScreen.routeName,
            icon: Icons.shop,
          ),
          AdminMenuItem(
            title: 'Upload Banners ',
            route: UploadBannerScreen.routeName,
            icon: CupertinoIcons.add,
          ),
        ],
        selectedRoute: DashboardScreen.routeName,
        onSelected: (item) {
          screenSelector(item);
        },
      ),
      body: _selectedItem,
    );
  }
}
