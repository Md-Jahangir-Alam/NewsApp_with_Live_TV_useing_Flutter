import 'dart:async';
import 'package:desh_bidesh/drawar.dart';
import 'package:desh_bidesh/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class forget_password extends StatelessWidget {
  forget_password({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _drawer = GlobalKey<ScaffoldState>();
  final _email = TextEditingController();
  check(){
    _email.clear();

  }
  void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }


  Future passwordreset()async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text.trim());
      showToastMessage("Check your email");
    }on FirebaseAuthException catch(e){
      showToastMessage("Something is worng");
    }
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/login.png"), fit: BoxFit.cover)),
          ),
          Positioned(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                      height: height / 7,
                    ),
                    FittedBox(
                        alignment: Alignment.center,
                        child: Text(
                          "Desh Bidesh",
                          style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                    SizedBox(
                      height: height / 6.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              const FittedBox(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Forget",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black38),
                                  )),
                              const FittedBox(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "forget to continue",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black38),
                                  )),
                              SizedBox(
                                height: height / 40,
                              ),
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: _email,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.pinkAccent),
                                      borderRadius: BorderRadius.all(Radius.circular(12))
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.pinkAccent),
                                      borderRadius: BorderRadius.all(Radius.circular(12))
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person_outline_outlined,color: Colors.pinkAccent,
                                  ),
                                  hintText: "E-mail",
                                  hintStyle: TextStyle(color: Colors.pinkAccent),
                                  labelText: "E-mail",
                                  labelStyle: TextStyle(color: Colors.pinkAccent),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Your E-mail.";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: height / 50,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: Colors.pinkAccent),
                                onPressed: () {
                                  if(formKey.currentState!.validate()){
                                    passwordreset();
                                    Timer(Duration(seconds: 3), () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                                    });
                                    check();
                                  }
                                },
                                child: Text("Forget"),
                              ),

                            ],
                          )),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
