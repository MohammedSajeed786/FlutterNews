import 'dart:io';
import 'dart:ui';
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
import 'package:share_plus/share_plus.dart';

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
    //categories is a list containing category names and photos
    categories = getCategories();
    getNews();
  }

//articles will contain headlines news list
  Future<void> getNews() async {
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
    final themeProvider = Provider.of<tm.ThemeProvider>(context);
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
                child: CircularProgressIndicator(
                    backgroundColor: themeProvider.themeMode == ThemeMode.dark
                        ? Colors.grey
                        : Colors.blue),
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              physics: ScrollPhysics(),
              child: Container(
                child: Column(
                  children: [
                    //CATEGORY LIST
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
                              //categories=[0,1,2,3]
                            );
                          }),
                    ),
                    //CATEGORY LIST
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: ListView.builder(
                          shrinkWrap: true,
                          //  physics: NeverScrollableScrollPhysics(),
                          //physics: ClampingScrollPhysics(),
                          physics: BouncingScrollPhysics(),
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

//defines how a category will look
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
            //instead of having border decoration in a container to give circu;ar border we have cliprrect
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

//represents how a headline article will appear
class Blogtile extends StatelessWidget {
  final String title, image, desc, url;
  Blogtile({this.title, this.desc, this.image, this.url});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<tm.ThemeProvider>(context);
    return Card(
        margin: EdgeInsets.only(bottom: 15),
        color: themeProvider.themeMode == ThemeMode.dark
            ? Colors.black
            : Colors.white,
        shadowColor: themeProvider.themeMode == ThemeMode.dark
            ? Colors.grey
            : Colors.blue,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ArticleView(url: url)));
              },
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(image, errorBuilder:
                          (BuildContext context, Object exception,
                              StackTrace stackTrace) {
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
                            ? Colors.white70
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
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Found Something New",
                    style: TextStyle(
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.white70
                          : Colors.black87,
                    )),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  icon: Icon(
                    Icons.share,
                    size: 23,
                  ),
                  onPressed: () {
                    Share.share(url, subject: "Hey do you know this");
                  },
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.white70
                      : Colors.black87,
                )
              ],
            ),
          ]),
        ));

    /*return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ArticleView(url: url)));
          },
          child: Container(
            // margin: EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //    IconButton(icon: Icon(Icons.share,size: 23,), onPressed: (){},color: themeProvider.themeMode == ThemeMode.dark
                //           ? Colors.white70
                //           : Colors.black87,)
                //   ],
                // ),
                // SizedBox(height: 6,),
                ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(image, errorBuilder:
                        (BuildContext context, Object exception,
                            StackTrace stackTrace) {
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
                          ? Colors.white70
                          : Colors.black87,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 8,
                ),
               
               
                // SizedBox(
                //   height: 4,
                // ),
                // Row(
                //  // mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Text("Found Something New",style: TextStyle(color: themeProvider.themeMode == ThemeMode.dark
                //           ? Colors.white70
                //           : Colors.black87,) ),
                //   SizedBox(
                //   width: 186,
                // ),
                //    IconButton(icon: Icon(Icons.share,size: 23,), onPressed: (){},color: themeProvider.themeMode == ThemeMode.dark
                //           ? Colors.white70
                //           : Colors.black87,)
                //  ],
                //  ),
              ],
            ),
          ),
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Found Something New?",
                style: TextStyle(
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.white70
                      : Colors.black87,
                )),
            SizedBox(
              width: 180,
            ),
            IconButton(
              icon: Icon(
                Icons.share,
                size: 23,
              ),
              onPressed: () {
                Share.share(url,subject: "Hey do you know this");
              },
              color: themeProvider.themeMode == ThemeMode.dark
                  ? Colors.white70
                  : Colors.black87,
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );*/
  }
}
