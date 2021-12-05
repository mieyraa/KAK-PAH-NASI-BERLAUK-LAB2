import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kakpahnasiberlauk/model/user.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProductAdmin extends StatefulWidget {
  final User user;

  const ProductAdmin({Key? key, required this.user}) : super(key: key);

  @override
  State<ProductAdmin> createState() => _ProductAdminState();
}

class _ProductAdminState extends State<ProductAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(  
       appBar: AppBar(
          title: const Text('KAK PAH NASI BERLAUK', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24)),
          backgroundColor: Colors.blue.shade900,
          leading: IconButton(
          icon: const Icon(LineAwesomeIcons.store),
          onPressed: () {},
          ),
      ),
        body: Container(),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
                child: const Icon(Icons.add),
                label: "New Product",
                labelStyle: const TextStyle(color: Colors.black),
                labelBackgroundColor: Colors.white,
                onTap: null),
          ],
    ));
  }
}