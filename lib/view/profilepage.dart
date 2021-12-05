import 'package:flutter/material.dart';
import 'package:kakpahnasiberlauk/view/loginpage.dart';
import 'package:kakpahnasiberlauk/model/user.dart';
import 'package:kakpahnasiberlauk/view/logoutpage.dart';
import 'package:kakpahnasiberlauk/view/registerpage.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  
  final User user;
  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
  }

class _ProfilePageState extends State<ProfilePage> {
  late double screenHeight, screenWidth, resWidth;

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
          title: const Text('MY PROFILE SETTING', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24)),
          backgroundColor: Colors.blue.shade900,
          leading: IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {},
          ),
      ),
        body: Center(
          child: Stack(
          children: [upperHalf(context), lowerHalf(context)],
      ),
        ),
      );
  }

  Widget upperHalf(BuildContext context) {
    return SizedBox(
      height: screenHeight / 3.9,
      width: screenWidth,
      child: Image.asset(
        'assets/images/blueflower.jfif',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget lowerHalf(BuildContext context) {
    return Column(
        children: [
           const SizedBox(height: 30),
        Flexible(
          flex: 3,
          child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Stack(
                    clipBehavior: Clip.none, fit: StackFit.expand,
                    children: [
                    const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/img_avatar2.png'),
                    ),
                    Positioned(
                       right: 5,
                       bottom: 2,
                       child: SizedBox(
                         height: 26,
                         width: 26,  
                         child: Container(
                         decoration: BoxDecoration(
                         border: Border.all(color: Colors.white, width: 4),
                         shape: BoxShape.circle,
                         ),
                       child: IconButton(
                         padding: const EdgeInsets.all(0.0),
                         color: Colors.white,
                         icon: const Icon(Icons.camera, size: 18.0),
                         onPressed: () {  },
                       ),
                      )
                        ),
                      ),
                  ],
                ),       
              ),    
        ),
        const SizedBox(height: 5),
         Text(widget.user.name.toString(),
                      style: const TextStyle(fontSize: 22, color: Colors.white)  ), 
        Flexible(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                      child: ListView(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          shrinkWrap: true,
                          children: [
                            ElevatedButton(
                            onPressed: null,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const <Widget>[
                              Icon(LineAwesomeIcons.user_edit, color: Colors.white,),
                              Text("UPDATE NAME",
                                  style: TextStyle(fontSize: 20)
                              ),
                              Icon(LineAwesomeIcons.angle_right, color: Colors.white,),
                              ],
                             ),
                            style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),      
                            fixedSize: const Size(40, 45),          
                            )
                            ),
                            const SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: null,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const <Widget>[
                              Icon(LineAwesomeIcons.user_lock, color: Colors.white,),
                              Text("UPDATE PASSWORD",
                              style: TextStyle(fontSize: 20)),
                              Icon(LineAwesomeIcons.angle_right, color: Colors.white,),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                            fixedSize: const Size(40, 45),                      
                            )),
                            const SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: null,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const <Widget>[
                              Icon(LineAwesomeIcons.map_pin, color: Colors.white,),
                              Text("UPDATE LOCATION",
                              style: TextStyle(fontSize: 20)),
                              Icon(LineAwesomeIcons.angle_right, color: Colors.white,),
                              ],
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                            fixedSize: const Size(40, 45),            
                            )),
                            const SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: _registerAccountDialog,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const <Widget>[
                              Icon(LineAwesomeIcons.user_plus, color: Colors.white,),
                              Text("NEW REGISTRATION",
                              style: TextStyle(fontSize: 20)),
                              Icon(LineAwesomeIcons.angle_right, color: Colors.white,),
                              ],
                            ),
                            style: 
                            ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade600),
                            fixedSize: MaterialStateProperty.all(const Size(40, 45)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            ))
                            ),
                           ),
                           const SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: _loginDialog,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const <Widget>[
                              Icon(Icons.login, color: Colors.white,),
                              Text("LOGIN ACCOUNT",
                              style: TextStyle(fontSize: 20)),
                              Icon(LineAwesomeIcons.angle_right, color: Colors.white,),
                              ],
                            ),
                            style: 
                            ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade600),
                            fixedSize: MaterialStateProperty.all(const Size(40, 45)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            ))),),
                            const SizedBox(height: 10),
                             ElevatedButton(
                            onPressed: _logoutDialog,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const <Widget>[
                              Icon(Icons.login, color: Colors.white,),
                              Text("LOGOUT ACCOUNT",
                              style: TextStyle(fontSize: 20)),
                              Icon(LineAwesomeIcons.angle_right, color: Colors.white,),
                              ],
                            ),
                            style: 
                            ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade600),
                            fixedSize: MaterialStateProperty.all(const Size(40, 45)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            ))),),
                            const SizedBox(height: 10),
                      ])),
                ],
              ),
            )),
     ],
    );
  }

  void _registerAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Register New Account",
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
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            RegisterPage(user: widget.user,)));
              },
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
  void _loginDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Go to Login Page",
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
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage(user: widget.user,)));
              },
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

  void _logoutDialog() {
     showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Go to Logout Page",
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
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LogoutPage(user: widget.user,)));
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