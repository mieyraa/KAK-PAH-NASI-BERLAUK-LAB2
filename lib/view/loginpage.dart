import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kakpahnasiberlauk/model/config.dart';
import 'package:kakpahnasiberlauk/view/mainpageadmin.dart';
import 'package:kakpahnasiberlauk/view/registerpage.dart';
import 'package:kakpahnasiberlauk/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainpage.dart';
import 'package:ndialog/ndialog.dart';

class LoginPage extends StatefulWidget {
  final User user;
  const LoginPage({Key? key, required this.user}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double screenHeight, screenWidth, resWidth;
  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final TextEditingController _useremailcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    loadPref();
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
      height: screenHeight / 1.7,
      width: screenWidth,
      child: Image.asset(
        'assets/images/loginform.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget lowerHalf(BuildContext context) {
    return Container(
        width: resWidth,
        margin: EdgeInsets.only(top: screenHeight / 3.5),
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
                          Text(
                            "Login Account",
                            style: TextStyle(
                              fontSize: resWidth * 0.07,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (val) => val!.isEmpty ||
                                      !val.contains("@") ||
                                      !val.contains(".")
                                  ? "Please enter a valid email"
                                  : null,
                              focusNode: focus,
                              onFieldSubmitted: (v) {
                                FocusScope.of(context).requestFocus(focus1);
                              },
                              controller: _emailEditingController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                  errorStyle: TextStyle(fontSize: 14.0),
                                  labelStyle: TextStyle(fontSize: 22),
                                  labelText: 'Email',
                                  icon: Icon(
                                    Icons.phone,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ))),
                                  const SizedBox(height: 5),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            validator: (val) =>
                                val!.isEmpty ? "Please enter a password first" : null,
                            focusNode: focus1,
                            onFieldSubmitted: (v) {
                              FocusScope.of(context).requestFocus(focus2);
                            },
                            controller: _passEditingController,
                            decoration: const InputDecoration(
                                errorStyle: TextStyle(fontSize: 14.0),
                                labelStyle: TextStyle(fontSize: 22),
                                labelText: 'Password',
                                icon: Icon(
                                  Icons.lock,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2.0),
                                )),
                            obscureText: true,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Checkbox(
                                  value: _isChecked,
                                  onChanged: (bool? value) {
                                    _onRememberMeChanged(value!);
                                  },
                                ),
                                const Flexible(
                                  child: Text('Remember me  ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                ElevatedButton(
                                  style: 
                                      ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade600),
                                      fixedSize: MaterialStateProperty.all(Size(screenWidth/3, 50)),
                                      ),
                    
                                  child: const Text('Login',
                                  style: TextStyle(fontSize: 20)),
                                  onPressed: _loginUser,
                                ),
                              ]),
                        ],
                      ),
                    ))),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Don't have an account yet?  ",
                    style: TextStyle(fontSize: 20.0)),
                GestureDetector(
                  onTap: () => {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                RegisterPage(user: widget.user,)))
                  },
                  child: const Text(
                    "Click here",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                    color: Colors.white,
                    offset: Offset(0, -5))
              ],
              color: Colors.transparent,
              decoration:
              TextDecoration.underline,
              decorationColor: Colors.white,
              decorationThickness: 2,
              decorationStyle:
              TextDecorationStyle.solid,
            ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
               mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Forgot password?  ",
                    style: TextStyle(fontSize: 20.0)),
                GestureDetector(
                  onTap: _forgotPassword,
                  child: const Text(
                    "Click here",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                    color: Colors.white,
                    offset: Offset(0, -5))
              ],
              color: Colors.transparent,
              decoration:
              TextDecoration.underline,
              decorationColor: Colors.white,
              decorationThickness: 2,
              decorationStyle:
              TextDecorationStyle.solid,
            ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        )));
  }

  void _loginUser() {
    FocusScope.of(context).requestFocus(FocusNode());
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Please fill in all the login credentials first",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 18.0);
      _isChecked = false;
      return;
    }
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Please wait.."), title: const Text("Login user"));
    progressDialog.show();
    String _email = _emailEditingController.text;
    String _pass = _passEditingController.text;
    http.post(Uri.parse(Config.server + "/kakpahnasiberlauk/php/login_user.php"),
        body: {"email": _email, "password": _pass,}).then((response) {
      if (response.statusCode == 200 && response.body != "failed") {
        final jsonResponse = json.decode(response.body);
        User user = User.fromJson(jsonResponse);
        Fluttertoast.showToast(
            msg: "Login Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 18.0);
        progressDialog.dismiss();
        if(_email == "kakpahnasiberlauk@gmail.com"){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MainPageAdmin(
                      user: user,
                    )));
        }else if(_email != "kakpahnasiberlauk@gmail.com"){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MainPage(
                      user: user,
                    )));
        }
      } else {
        Fluttertoast.showToast(
            msg: "Login Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 18.0);
      }
      progressDialog.dismiss();
    });
  }

  void saveremovepref(bool value) async {
    if (!_formKey.currentState!.validate()) {
        Fluttertoast.showToast(
            msg: "Please fill in all the login credentials first",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 18.0);
            _isChecked = false;
        return;
      }
    FocusScope.of(context).requestFocus(FocusNode());
    FocusScope.of(context).unfocus();
    String email = _emailEditingController.text;
    String password = _passEditingController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      await prefs.setString('email', email);
      await prefs.setString('pass', password);
      Fluttertoast.showToast(
          msg: "Preference Succcessfully Stored",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 18.0);
    } else {
      //delete preference
      await prefs.setString('email', '');
      await prefs.setString('pass', '');
      setState(() {
        _emailEditingController.text = '';
        _passEditingController.text = '';
        _isChecked = false;
      });
      Fluttertoast.showToast(
          msg: "Preference Successfully Removed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 18.0);
    }
  }

  void _onRememberMeChanged(bool newValue) => setState(() {
        _isChecked = newValue;
        if (_isChecked) {
          saveremovepref(true);
        } else {
          saveremovepref(false);
        }
      });

  Future<void> loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('pass')) ?? '';
    if (email.length > 1 && password.length > 1) {
      setState(() {
        _emailEditingController.text = email;
        _passEditingController.text = password;
        _isChecked = true;
      });
    }
  }

String? validatePassword(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter a password first';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Mix uppercase and lowercase letters with numbers';
      } else {
        return null;
      }
    }
  }
  
  void _forgotPassword() {

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Forgot Password?", style: TextStyle(fontSize: 26)),
            content: SizedBox(
                height: 120,
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Enter your recovery email", style: TextStyle(fontSize: 22)),
                    TextField(
                      controller: _useremailcontroller,
                      decoration: const InputDecoration(
                          labelText: 'Email', 
                          labelStyle: TextStyle(fontSize: 24),
                          icon: Icon(LineAwesomeIcons.envelope)
                          ),
                    ),
                  ], 
                )),
                
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                    primary: Colors.white, backgroundColor: Colors.blue.shade600),
                child: const Text("Submit", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  _newPassword();
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height:10),
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blue.shade600),
                  child: const Text("Cancel", style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }), 
                  const SizedBox(height:20),
            ],
          );
        });
  }

  void _newPassword() {}
}
