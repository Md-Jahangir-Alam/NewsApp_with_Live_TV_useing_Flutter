import 'dart:io';

import 'package:desh_bidesh/drawar.dart';
import 'package:desh_bidesh/forget_password.dart';
import 'package:desh_bidesh/homepage.dart';
import 'package:desh_bidesh/singupPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _drawer = GlobalKey<ScaffoldState>();
  var eye = true;
  eye_control() {
    setState(() {
      eye = !eye;
    });
    print(eye);
  }

  check() {
    _email.clear();
    _password.clear();
  }

  void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  logIn() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text,
      );
      var authCredential = credential.user;
      if (authCredential!.uid.isNotEmpty) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => homepage()));
      } else {
        showToastMessage("Something is worng");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToastMessage("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        showToastMessage("Wrong password provided for that user.");
      }
    } catch (e) {
      showToastMessage(e.toString());
    }
  }


  late BannerAd _bannerAd;

  @override
  void initState() {
    super.initState();

    // Initialize banner ad
    _bannerAd = BannerAd(
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => print('Ad loaded.'),
        onAdFailedToLoad: (ad, error) => print('Ad failed to load: $error'),
      ),
    );

    // Load banner ad
    _bannerAd.load();
  }

  @override
  void dispose() {
    // Dispose of banner ad when widget is disposed
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _drawer,
      drawer: Drawer(
        child: draWar(),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.pinkAccent,
        title: FittedBox(
            alignment: Alignment.centerLeft,
            child: Text(
              "Desh Bidesh",
              style: TextStyle(fontSize: 25),
            )),
        leading: IconButton(
            onPressed: () {
              _drawer.currentState!.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              size: 30,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                size: 30,
              )),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/login.png"), fit: BoxFit.cover)),
          ),
          Positioned(
              child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: AdWidget(ad: _bannerAd),
                          width: _bannerAd.size.width.toDouble(),
                          height: _bannerAd.size.height.toDouble(),
                        ),
                        FittedBox(
                            alignment: Alignment.center,
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black38),
                            )),
                        FittedBox(
                            alignment: Alignment.center,
                            child: Text(
                              "login to continue",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black38),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: _email,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.pinkAccent),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.pinkAccent),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                prefixIcon: Icon(
                                  Icons.person_outline_outlined,
                                  color: Colors.pinkAccent,
                                ),
                                hintText: "E-mail",
                                hintStyle: TextStyle(color: Colors.pinkAccent),
                                labelText: "E-mail",
                                labelStyle: TextStyle(color: Colors.pinkAccent),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Your E-mail";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _password,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.pinkAccent),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.pinkAccent),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                prefixIcon: Icon(Icons.security,
                                    color: Colors.pinkAccent),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      eye_control();
                                    },
                                    icon: Icon(Icons.remove_red_eye_outlined,
                                        color: Colors.pinkAccent)),
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.pinkAccent),
                                labelText: "Password",
                                labelStyle: TextStyle(color: Colors.pinkAccent),
                              ),
                              obscureText: (eye == true ? true : false),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Your Password.";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.pinkAccent),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  logIn();
                                  check();
                                }
                              },
                              child: Text("Login"),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              forget_password()));
                                },
                                child: Text(
                                  "Forget password?",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black38),
                                )),
                            RichText(
                                text: TextSpan(
                                    text: "Don't have an account?",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black38),
                                    children: [
                                  WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        signUP()));
                                          },
                                          child: Text(" Sign Up",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.pink))))
                                ])),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
