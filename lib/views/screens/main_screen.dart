import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:gebiya_web_admin/views/screens/side_bar_screens/dashboard_screen.dart';
import 'package:gebiya_web_admin/views/screens/side_bar_screens/vendors_screen.dart';

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        title: const Text("Management System"),
      ),
      sideBar: SideBar(
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
            route: '/',
            icon: CupertinoIcons.money_dollar,
          ),
          AdminMenuItem(
            title: 'Orders ',
            route: '/',
            icon: CupertinoIcons.shopping_cart,
          ),
          AdminMenuItem(
            title: 'Category  ',
            route: '/',
            icon: Icons.category,
          ),
          AdminMenuItem(
            title: 'Product ',
            route: '/',
            icon: Icons.shop,
          ),
          AdminMenuItem(
            title: 'Upload Banners ',
            route: '/',
            icon: CupertinoIcons.add,
          ),
        ],
        selectedRoute: '/',
        onSelected: (item) {
          setState(() {
            // The error is because 'selectedRoute' is not defined in this class.
            // To fix, you should define a variable in _MainScreenState:
            // String selectedRoute = '/';
            // Then, this assignment will work.
            // For now, you can comment this out or define the variable as shown above.
          });
        },
      ),
      body: _selectedItem,
    );
  }
}
