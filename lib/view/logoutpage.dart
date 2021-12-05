import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kakpahnasiberlauk/model/config.dart';
import 'package:kakpahnasiberlauk/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:kakpahnasiberlauk/view/splashpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutPage extends StatefulWidget {
  final User user;
  const LogoutPage({Key? key, required this.user}) : super(key: key);

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  late double screenHeight, screenWidth, resWidth;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    if(screenWidth<=600){
      resWidth = screenWidth;
    }else{
      resWidth = screenWidth * 0.75;
    }
    return Scaffold(
      appBar: AppBar(
          title: const Text('KAK PAH NASI BERLAUK'),
          backgroundColor: Colors.blue.shade900,
        ),
      body: Stack(
        children: [upperHalf(context), lowerHalf(context)],
      ),
    );
  }

  Widget upperHalf(BuildContext context) {
    return SizedBox(
      height: screenHeight / 1.55,
      width: screenWidth,
      child: Image.asset(
        'assets/images/logoutform.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget lowerHalf(BuildContext context) {
    return Container(
        width: resWidth,
        margin: EdgeInsets.only(top: screenHeight / 4),
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Card(
                elevation: 10,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(25, 10, 20, 25),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          const CircleAvatar(
                             backgroundImage: AssetImage('assets/images/img_avatar2.png'),
                             radius: 32,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Account Details",
                            style: TextStyle(
                              fontSize: resWidth * 0.08,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade600,
                            ),
                          ),
                          const SizedBox(height: 20),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
                            Text("USERNAME: ",
                            style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                            Text(widget.user.name.toString(),
                            style: const TextStyle(fontSize: 18, color: Colors.white)  ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Column(
                            children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const <Widget>[
                                  Text("EMAIL: ",
                                  style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)  ),
                                ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(widget.user.email.toString(),
                                  style: const TextStyle(fontSize: 18, color: Colors.white)  ),
                                ],
                            ),
                        ]),
                        const SizedBox(height: 25),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: 
                                      ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade600),
                                      fixedSize: MaterialStateProperty.all(Size(screenWidth/4, 50)),
                                      ),
                                  child: const Text('Logout',
                                  style: TextStyle(fontSize: 20)),
                                  onPressed: _logout,
                                ),
                              ]),
                        ],
                      ),
                    ))),
            const SizedBox(
              height: 10,
            ),
          ],
        )));
  }

  void saveremovepref(bool value) async {
  
    SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', '');
      await prefs.setString('pass', '');
      setState(() {
      });
    }
 
 void _logout() {
   
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Logout Account? ",
            style: TextStyle(fontSize: 24.0),
          ),
          content: const Text(
            "Are you sure?",
            style: TextStyle(fontSize: 20.0),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed:() {
                Navigator.of(context).pop();
                String _email = '';
                String _pass = '';
                http.post(Uri.parse(Config.server + "/kakpahnasiberlauk/php/login_user.php"),
                body: {"email": _email, "password": _pass,}).then((response) {
                if (response.statusCode == 200 && response.body != "failed") {
                Fluttertoast.showToast(
                   msg: "Logout Failed. Try again",
                   toastLength: Toast.LENGTH_SHORT,
                   gravity: ToastGravity.BOTTOM,
                   timeInSecForIosWeb: 1,
                   fontSize: 18.0);
                } else {
                Fluttertoast.showToast(
                msg: "Logout Successful",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                fontSize: 18.0);
                }
          });
          saveremovepref(false);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const SplashPage()));
              } 
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
