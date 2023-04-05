import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:desh_bidesh/cricbuzz.dart';
import 'package:desh_bidesh/drawar.dart';
import 'package:desh_bidesh/homemain.dart';
import 'package:desh_bidesh/live_tv.dart';
import 'package:desh_bidesh/scerch.dart';
import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  final GlobalKey<ScaffoldState> _drawer = GlobalKey<ScaffoldState>();
  var _index = 1;
  final page = [live_tv(), homemain(), cricbuzz()];

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {
                showSearch(context: context, delegate: SearchUser());
              },
              icon: Icon(
                Icons.search,
                size: 30,
              )),
          IconButton(
              onPressed: () {

              },
              icon: Icon(
                Icons.more_vert,
                size: 30,
              )),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _index,
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.pinkAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index){
          setState(() {
            _index = index;
          });
          },
          items: [
            Icon(Icons.live_tv_outlined, size: 25,color: Colors.pinkAccent,),
            Icon(Icons.home_outlined, size: 25,color: Colors.pinkAccent,),
            Icon(Icons.sports_cricket_outlined, size: 25,color: Colors.pinkAccent,),
          ]
      ),
      body: page[_index],
    );
  }
}
