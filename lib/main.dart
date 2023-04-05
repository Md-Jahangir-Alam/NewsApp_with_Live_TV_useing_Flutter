import 'dart:async';
import 'package:desh_bidesh/firebase_options.dart';
import 'package:desh_bidesh/homepage.dart';
import 'package:desh_bidesh/loginPage.dart';
import 'package:desh_bidesh/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (_) => News(),
      child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Desh Bidesh",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(color: Colors.deepOrange, child: Next()),
      ),
    );
  }
}

class Next extends StatefulWidget {
  const Next({Key? key}) : super(key: key);

  @override
  State<Next> createState() => _NextState();
}

class _NextState extends State<Next> {


  StreamSubscription? subscription;

  Future connection()async{
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: "check your network connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  final credential = FirebaseAuth.instance.currentUser;

  usercheck(){
    if(credential != null){
      Timer(Duration(seconds: 3), () {
        Navigator.push(
            this.context, MaterialPageRoute(builder: (context) => homepage()));
      });
    }else{
      Timer(Duration(seconds: 3), () {
        Navigator.push(
            this.context, MaterialPageRoute(builder: (context) => LoginPage()));
      });
    }
  }



  @override
  void initState() {
    subscription = Connectivity().onConnectivityChanged.listen((event) { connection();});
    Provider.of<News>(context, listen: false).sportsNews();
    Provider.of<News>(context, listen: false).bdNews();
    Provider.of<News>(context, listen: false).worldNews();
    Provider.of<News>(context, listen: false).getUid();
    usercheck();
    super.initState();
  }

  @override
  void dispose() {
    subscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FittedBox(
            alignment: Alignment.center,
            child: Text(
              "Welcome to the App",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
        Lottie.asset("assets/animation.json"),
      ],
    );
  }
}
