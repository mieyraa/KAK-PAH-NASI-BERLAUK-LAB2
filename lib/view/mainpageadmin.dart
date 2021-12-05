import 'package:flutter/material.dart';
import 'package:kakpahnasiberlauk/model/user.dart';
import 'package:kakpahnasiberlauk/view/productpage.dart';
import 'package:kakpahnasiberlauk/view/orderpage.dart';
import 'package:kakpahnasiberlauk/view/profilepage.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class MainPageAdmin extends StatefulWidget {
  final User user;

  const MainPageAdmin({Key? key, required this.user}) : super(key: key);

  @override
  State<MainPageAdmin> createState() => _MainPageAdminState();
}

class _MainPageAdminState extends State<MainPageAdmin> {
  
  late List<Widget> tabChildren;
  int _currentIndex = 0;
  String mainTitle = "Products";
  @override
  void initState() {
    super.initState();
    tabChildren = [
      ProductAdmin(user: widget.user,),
      const OrderPage(),
      ProfilePage(user: widget.user,),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: tabChildren[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: const [
          BottomNavigationBarItem(
            icon: Icon(LineAwesomeIcons.utensils, color: Colors.white),
            label: "Products"),
          BottomNavigationBarItem(
            icon: Icon(LineAwesomeIcons.shopping_cart, color: Colors.white),
            label: "Orders"),
          BottomNavigationBarItem(
            icon: Icon(LineAwesomeIcons.user, color: Colors.white),
            label: "Profile"),
          ]
        ),
    );
  }

  void onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
        if(_currentIndex == 0){
          mainTitle = "Product";
        }
        if(_currentIndex == 1){
          mainTitle = "Orders";
        }
        if(_currentIndex == 2){
          mainTitle = "Profile";
        }
      });
  }
}