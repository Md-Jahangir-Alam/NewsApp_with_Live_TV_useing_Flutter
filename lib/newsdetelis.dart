import 'package:desh_bidesh/drawar.dart';
import 'package:flutter/material.dart';

class newsDetelis extends StatefulWidget {
  var newsdetelis;
  newsDetelis ({required this.newsdetelis});

  @override
  State<newsDetelis> createState() => _newsDetelisState();
}

class _newsDetelisState extends State<newsDetelis> {
  final GlobalKey<ScaffoldState> _drawer = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  height: height / 3,
                  width: width,
                  child: Image.network(widget.newsdetelis["urlToImage"]??"https://cdn.pixabay.com/photo/2022/06/20/17/17/mountain-7274247_960_720.jpg"),
                ),
                SizedBox(height: 10,),
                Text(widget.newsdetelis['title']??"Loading...",style: TextStyle(fontSize: 25),),
                SizedBox(height: 10,),
                Text(widget.newsdetelis['description']??"Loading...",style: TextStyle(fontSize: 17),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
