import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:news/helper/data.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/category_model.dart';
import 'package:news/helper/news.dart';
import 'package:news/views/article_view.dart';
import 'package:news/theme.dart' as tm;
import 'package:provider/provider.dart';
import '../changetheme.dart';
import 'category_news.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Category_model> categories = new List<Category_model>();
  List<Articlemodel> articles = new List<Articlemodel>();
  bool isloading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsdata = News();
    await newsdata.getnews();
    articles = newsdata.news;
    setState(() {
      isloading = false;
    });
  }

  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("New"),
            Text(
              "Newz",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        elevation: 0.0,
        actions: [
          Changetheme(),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: isloading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              physics: ScrollPhysics(),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 70,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                              image: categories[index].image,
                              name: categories[index].name,
                            );
                          }),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: ListView.builder(
                          shrinkWrap: true,
                          //  physics: NeverScrollableScrollPhysics(),
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return Blogtile(
                              title: articles[index].title,
                              desc: articles[index].description,
                              image: articles[index].urltoimage,
                              url: articles[index].url,
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String image, name;
  CategoryTile({this.image, this.name});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<tm.ThemeProvider>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CategoryNews(category: name.toLowerCase())));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: image,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black26),
              child: Text(
                name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Blogtile extends StatelessWidget {
  final String title, image, desc, url;
  Blogtile({this.title, this.desc, this.image, this.url});
  @override
  Widget build(BuildContext context) {
                final themeProvider = Provider.of<tm.ThemeProvider>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArticleView(url: url)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(image, errorBuilder: (BuildContext context,
                    Object exception, StackTrace stackTrace) {
                  return Text(' ');
                })),
            SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  color:themeProvider.themeMode==ThemeMode.dark?Colors.white70 :Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 8,
            ),
            Text(desc, style: TextStyle(color: themeProvider.themeMode==ThemeMode.dark?Colors.white54:Colors.black54)),
          ],
        ),
      ),
    );
  }
}
