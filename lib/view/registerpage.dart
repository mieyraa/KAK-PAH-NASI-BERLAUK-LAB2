import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kakpahnasiberlauk/model/config.dart';
import 'package:kakpahnasiberlauk/model/user.dart';
import 'package:kakpahnasiberlauk/view/loginpage.dart';
import 'package:kakpahnasiberlauk/view/profilepage.dart';
import 'package:ndialog/ndialog.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  final User user;
  const RegisterPage({Key? key, required this.user}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late double screenHeight, screenWidth, resWidth;
  bool _isChecked = false;
  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  bool _passwordVisible = true;
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final TextEditingController _pass2EditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String eula = "";

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
          title: const Text('KAK PAH NASI BERLAUK',
          style: TextStyle(fontSize: 24)),    
          backgroundColor: Colors.blue.shade900,
        ),
      body: Stack(
        children: [upperHalf(context), lowerHalf(context)],
      ),
    );
  }

  Widget upperHalf(BuildContext context) {
    return SizedBox(
        height: screenHeight / 1.6,
        width: resWidth,
        child: Image.asset(
          'assets/images/register.png',
          fit: BoxFit.cover,
          scale: 2,
        ),
      );
  }

  Widget lowerHalf(BuildContext context) {
    return Container(
      width: resWidth,
      margin: EdgeInsets.only(top: screenHeight / 6.2),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 10,
              child: Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(25, 10, 20, 25),
                  child: Column(children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Register New Account",
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
                        validator: (val) => val!.isEmpty || (val.length < 3)
                            ? "Name must be longer than 3"
                            : null,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context).requestFocus(focus);
                        },
                        controller: _nameEditingController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(fontSize: 20.0),
                            errorStyle: TextStyle(fontSize: 14.0),
                            icon: Icon(Icons.person),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 0.5),
                            ))),
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
                            labelStyle: TextStyle(fontSize: 20.0),
                            labelText: 'Email',
                            icon: Icon(Icons.phone),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 0.5),
                            ))),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (val) => validatePassword(val.toString()),
                      focusNode: focus1,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).requestFocus(focus2);
                      },
                      controller: _passEditingController,
                      decoration: InputDecoration(
                          errorStyle: const TextStyle(fontSize: 14.0),
                          labelStyle: const TextStyle(fontSize: 20.0),
                          labelText: 'Password',
                          icon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 0.5),
                          )),
                      obscureText: _passwordVisible,
                    ),
                    TextFormField(
                      style: const TextStyle(),
                      textInputAction: TextInputAction.done,
                      validator: (val) {
                        validatePassword(val.toString());
                        if (val != _passEditingController.text) {
                          return "Password do not match";
                        } else {
                          return null;
                        }
                      },
                      focusNode: focus2,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).requestFocus(focus3);
                      },
                      controller: _pass2EditingController,
                      decoration: InputDecoration(
                          errorStyle: const TextStyle(fontSize: 14.0),
                          labelText: 'Re-enter Password',
                          labelStyle: const TextStyle(fontSize: 20.0),
                          icon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 0.5),
                          )),
                      obscureText: _passwordVisible,
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
                              setState(() {
                                _isChecked = value!;
                              });
                            },
                          ),
                          Flexible(
                            child: GestureDetector(
                              onTap: _showEULA,
                              child: const Text('Agree with terms',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(screenWidth / 3, 50)),
                            child: const Text('Register',
                            style: TextStyle(fontSize: 20.0)),
                            onPressed: _registerAccountDialog,
                          ),
                        ]),
                  ]),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Already have an account?  ",
                    style: TextStyle(fontSize: 20.0)),
                GestureDetector(
                  onTap: () => {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                LoginPage(user: widget.user,)))
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
                      height: 20,
                    ),
          ],
        ),
      ),
    );
  }

  String? validatePassword(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter password first';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Mix upper and lowercase letters with number';
      } else {
        return null;
      }
    }
  }

  void _registerAccountDialog() {
    if (!_formKey.currentState!.validate()) {
      
      Fluttertoast.showToast(
        msg: "Please complete registration form first",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 18.0);
        return;
    }

  if (!_isChecked){
    Fluttertoast.showToast(
        msg: "Please accept the terms and conditions",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 18.0);
        return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Register New Account? ",
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
                _registerUserAccount();
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

  void _showEULA() {
    loadEula();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "EULA",
          ),
          content: SizedBox(
            height: screenHeight / 1.5,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                      child: RichText(
                    softWrap: true,
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        style: const TextStyle(
                          fontSize: 12.0,
                        ),
                        text: eula),
                  )),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Close",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  loadEula() async {
    eula = await rootBundle.loadString('assets/eula.txt');
  }
void _registerUserAccount() { 
  FocusScope.of(context).requestFocus(FocusNode()); 
  String _name = _nameEditingController.text;
  String _email = _emailEditingController.text;
  String _pass = _passEditingController.text;
  FocusScope.of(context).unfocus();
  ProgressDialog progressDialog = ProgressDialog(context, 
  message: const Text("Registration in progress.."), 
  title: const Text("Registering..."));
  progressDialog.show();
  http.post(Uri.parse(Config.server + "/kakpahnasiberlauk/php/register_user.php"), 
  body: {
    "name": _name, "email": _email, "password": _pass,
  }).then((response) {
    var data = jsonDecode(response.body);
    if (response.statusCode == 200 && data['status'] == 'success') { 
      Fluttertoast.showToast(
        msg: "Registration Successful", 
        toastLength: Toast.LENGTH_SHORT, 
        gravity: ToastGravity.BOTTOM, 
        timeInSecForIosWeb: 1, 
        textColor: Colors.red,
        fontSize: 18.0); 
        progressDialog.dismiss(); 
        Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ProfilePage(user: widget.user,)));
        return;
    } else {
        Fluttertoast.showToast(
          msg: "You already have an account. Please login.", 
          toastLength: Toast.LENGTH_SHORT, 
          gravity: ToastGravity.BOTTOM, 
          timeInSecForIosWeb: 1, 
          textColor: Colors.red,
          fontSize: 18.0); 
          progressDialog.dismiss(); 
          return;
    } 
});
}
}