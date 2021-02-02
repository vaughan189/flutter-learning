import 'package:flutter/material.dart';
import 'package:news_app/helper/categories.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/category.dart';
import 'package:news_app/widgets/category_card.dart';
import 'package:news_app/widgets/list_tile.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategorieModel> categories = [];
  List newslist = [];
  bool loading = false;

  @override
  void initState() {
    loading = true;
    super.initState();
    categories = getCategories();
    getNews();
  }

  void getNews() async {
    News news = News();
    await news.getNews();
    setState(() {
      this.newslist = news.news;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
              child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 70,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      imageAssetUrl: categories[index].imageAssetUrl,
                      categoryName: categories[index].categorieName,
                    );
                  }),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: ListView.builder(
                  itemCount: newslist.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return NewsTile(
                      imgUrl: newslist[index].urlToImage ?? "",
                      title: newslist[index].title ?? "",
                      desc: newslist[index].description ?? "",
                      content: newslist[index].content ?? "",
                      posturl: newslist[index].articleUrl ?? "",
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
