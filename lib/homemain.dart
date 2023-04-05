import 'package:carousel_slider/carousel_slider.dart';
import 'package:desh_bidesh/bd_news.dart';
import 'package:desh_bidesh/international.dart';
import 'package:desh_bidesh/newsdetelis.dart';
import 'package:desh_bidesh/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class homemain extends StatefulWidget {
  const homemain({Key? key}) : super(key: key);

  @override
  State<homemain> createState() => _homemainState();
}

class _homemainState extends State<homemain> {
  var active = 0;

  @override
  Widget build(BuildContext context) {
    final news = Provider.of<News>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  child: CarouselSlider.builder(
                    itemCount: news.sportsnews.length,
                    itemBuilder: (context, index, pageindex) {
                      if (news.sportsnews == null || news.sportsnews.isEmpty) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => newsDetelis(
                                  newsdetelis: news.sportsnews[index],
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        news.sportsnews[index]["urlToImage"] ??
                                            "https://cdn.pixabay.com/photo/2022/06/20/17/17/mountain-7274247_960_720.jpg",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      news.sportsnews[index]['title'] ??
                                          "Loading...",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    options: CarouselOptions(
                      height: 250,
                      enlargeCenterPage: true,
                      onPageChanged: (index, jahangir) {
                        setState(() {
                          active = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Bangladesh News",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  FittedBox(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => bd_news()));
                        },
                        child: Text(
                          "View all",
                          style:
                          TextStyle(fontSize: 20, color: Colors.pinkAccent),
                        ),
                      )),
                ],
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: GridView.builder(
                      scrollDirection: Axis.horizontal,
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
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Center(
                                    child: Text(
                                      news.bdnews[index]["title"]??"Loading...",
                                      style: TextStyle(
                                          fontSize: 15, fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "International News",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  FittedBox(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => international()));
                        },
                        child: Text(
                          "View all",
                          style:
                          TextStyle(fontSize: 20, color: Colors.pinkAccent),
                        ),
                      )),
                ],
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: news.worldnews.length ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1), itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>newsDetelis(newsdetelis: news.worldnews[index],)));
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
                                        image: NetworkImage(news.worldnews[index]["urlToImage"]??"https://cdn.pixabay.com/photo/2022/06/20/17/17/mountain-7274247_960_720.jpg"),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Center(
                                    child: Text(
                                      news.worldnews[index]["title"]??"Loading...",
                                      style: TextStyle(
                                          fontSize: 15, fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
