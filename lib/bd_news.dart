import 'package:desh_bidesh/drawar.dart';
import 'package:desh_bidesh/newsdetelis.dart';
import 'package:desh_bidesh/provider.dart';
import 'package:desh_bidesh/scerch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class bd_news extends StatefulWidget {
  const bd_news({Key? key}) : super(key: key);

  @override
  State<bd_news> createState() => _bd_newsState();
}

class _bd_newsState extends State<bd_news> {
  final GlobalKey<ScaffoldState> _drawer = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    final news = Provider.of<News>(context);
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
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                size: 30,
              )),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: FittedBox(
                  alignment: Alignment.center,
                  child: Text(
                    "---Bangladesh News---",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: height,
                width: width,
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: news.bdnews.length ?? 0,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1), itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>newsDetelis(newsdetelis: news.bdnews[index],)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                      image: NetworkImage(news.bdnews[index]["urlToImage"]??"https://cdn.pixabay.com/photo/2022/06/20/17/17/mountain-7274247_960_720.jpg"),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          Container(
                            child: Center(
                                child: Text(
                                  news.bdnews[index]["title"]??"Loading...",
                                  style: TextStyle(
                                      fontSize: 25, fontWeight: FontWeight.bold),
                                )),
                          ),
                          SizedBox(height: 20,)
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        )
      ),
    );
  }
}