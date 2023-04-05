import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desh_bidesh/bd_news.dart';
import 'package:desh_bidesh/international.dart';
import 'package:desh_bidesh/loginPage.dart';
import 'package:desh_bidesh/provider.dart';
import 'package:desh_bidesh/sports.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';


class draWar extends StatefulWidget {
  const draWar({Key? key}) : super(key: key);

  @override
  State<draWar> createState() => _draWarState();
}

class _draWarState extends State<draWar> {
  final Uri gmail = Uri.parse('mailto: jahangirad14@gmail.com');
  final Uri phone = Uri.parse('tel:+880-17961-96500');
  final firestore = FirebaseFirestore.instance.collection("users").snapshots();

  Future<void> contact(contact) async {
    if (!await launchUrl(contact)) {
      throw Exception('Could not launch $contact');
    }
  }


  Future logout()async {
    await FirebaseAuth.instance.signOut();

    return Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  }




  @override
  Widget build(BuildContext context) {
    final news = Provider.of<News>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20),
              ClipOval(
                child: news.allData == null
                    ? new Text('No image')
                    : Image.network(
                  news.allData["image"],
                  fit: BoxFit.cover,
                  height: 90.0,
                  width: 90.0,
                ),
              ),
              SizedBox(height:  10,),
              Text(news.allData["name"]??"No Username", style: TextStyle(fontSize: 30, color: Colors.white),),
              SizedBox(height:  5,),
              Text(news.allData["fullname"]??"No Name", style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(
                height: height / 10,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  height: height/4,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.newspaper,
                            color: Colors.white,
                          ),
                          FittedBox(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>bd_news()));
                              },
                              child: Text(
                                "Bangladesh News",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.newspaper,
                            color: Colors.white,
                          ),
                          FittedBox(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>international()));
                              },
                              child: Text(
                                "International News",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.newspaper,
                            color: Colors.white,
                          ),
                          FittedBox(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>sports()));
                              },
                              child: Text(
                                "Sports News",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    logout();
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  )),
              SizedBox(
                height: height / 20,
              ),
              FittedBox(
                alignment: Alignment.topCenter,
                child: Text(
                  "Contacts",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(height: 10),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        contact(phone);
                      },
                      icon: Icon(
                        Icons.phone_callback_outlined,
                        size: 30,
                        color: Colors.white,
                      )),
                  SizedBox(width: width / 20,),
                  IconButton(
                      onPressed: () {
                        contact(gmail);
                      },
                      icon: Icon(
                        Icons.mark_as_unread_rounded,
                        size: 30,
                        color: Colors.white,
                      )),
                ],
              )
            ],
          ),
        ));
  }
}


