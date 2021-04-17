import 'package:flutter/material.dart';
import 'package:news/helper/news.dart';
import 'package:news/models/article_model.dart';
import 'package:news/theme.dart' as tm;
import 'package:provider/provider.dart';

import 'article_view.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<Articlemodel> articles = new List<Articlemodel>();
  bool isloading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
    isloading = false;
  }

  getCategoryNews() async {
    CategoriNews newsdata = CategoriNews();
    await newsdata.getnews(widget.category);
    articles = newsdata.news;
    setState(() {
      isloading = false;
    });
  }

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
            Opacity(
              opacity: 0,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.save)),
            )
          ]),
      body: isloading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
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
                  )),
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
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.white54
                      : Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 8,
            ),
            Text(desc,
                style: TextStyle(
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? Colors.white54
                        : Colors.black54)),
          ],
        ),
      ),
    );
  }
}
