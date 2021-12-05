import 'package:flutter/material.dart';
import 'package:kakpahnasiberlauk/model/user.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text(widget.user.email.toString(),
          style: const TextStyle(fontSize: 16, color: Colors.white)  ),
          ],
          ),
        )
    );
  }
}