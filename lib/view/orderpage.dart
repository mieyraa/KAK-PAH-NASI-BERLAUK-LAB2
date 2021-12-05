import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
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
        body: Container()
    );
}
}