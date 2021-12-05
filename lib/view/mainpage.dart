import 'package:flutter/material.dart';
import 'package:kakpahnasiberlauk/view/homepage.dart';
import 'package:kakpahnasiberlauk/view/orderpage.dart';
import 'package:kakpahnasiberlauk/view/profilepage.dart';
import 'package:kakpahnasiberlauk/model/user.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class MainPage extends StatefulWidget {
  final User user;

  const MainPage({Key? key, required this.user}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  late List<Widget> tabChildren;
  int _currentIndex = 0;
  String mainTitle = "Buyer";
  @override
  void initState() {
    super.initState();
    tabChildren = [
      HomePage(user: widget.user,),
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
            icon: Icon(LineAwesomeIcons.home, color: Colors.white),
            label: "Home"),
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
          mainTitle = "Home";
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