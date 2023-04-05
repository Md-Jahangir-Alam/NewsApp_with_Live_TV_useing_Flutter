import 'package:desh_bidesh/newsdetelis.dart';
import 'package:desh_bidesh/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SearchUser extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query = "";
      }, icon: Icon(Icons.close, size: 20,))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      Navigator.pop(context);
    }, icon: Icon(Icons.arrow_back_ios, size: 20,));
  }

  @override
  Widget buildResults(BuildContext context) {
    final news = Provider.of<News>(context);
    return Expanded(
      child: ListView.builder(
        itemCount: news.worldnews.length,
        itemBuilder: (context, index) {
          // Display the search results using a ListTile widget
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>newsDetelis(newsdetelis: news.worldnews[index],)));
            },
            child: ListTile(
              title: Text(news.worldnews[index]['title']??"Loding..."),
              subtitle: Text(news.worldnews[index]['description']??"Loding..."),
              leading: Container(
                height: 50,
                width: 50,
                child: Image.network(news.worldnews[index]["urlToImage"]??"https://cdn.pixabay.com/photo/2022/06/20/17/17/mountain-7274247_960_720.jpg"),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text("Search", style: TextStyle(fontSize: 20),),
    );
  }

}