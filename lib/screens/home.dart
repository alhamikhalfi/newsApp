import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper_tv/flutter_swiper.dart';
import 'package:news_app_02/models/newsinfo.dart';
import 'package:news_app_02/services/api_manager.dart';
import 'package:news_app_02/theme/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget titleLogo() {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 2),
      child: Text(
        'Your News',
        style: titleblack.copyWith(
          fontSize: 25,
        ),
      ),
    );
  }

  Widget trendingTitle() {
    return Container(
      margin: EdgeInsets.only(top: 25, bottom: 20, left: 2),
      child: Text(
        'Trending',
        style: titleblack.copyWith(
          fontSize: 21,
        ),
      ),
    );
  }

  Widget topHeadlinesBanner() {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Swiper(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: blackColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: FutureBuilder<Newsmodel>(
                future: _newsModel,
                builder: (context, snapshot) {
                  var article = snapshot.data?.articles?[index];

                  var image = Image.network(article?.urlToImage ?? '');

                  if (snapshot.hasData) {
                    print(image);
                    print(e);
                    return ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: CachedNetworkImage(
                        imageUrl: article?.urlToImage ?? '',
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      // child: Image(
                      //   fit: BoxFit.cover,
                      //   // errorBuilder: (context, error, stackTrace) {
                      //   //   print(e);
                      //   //   return Text('no img');
                      //   // },
                      //   // frameBuilder:
                      //   //     (context, child, frame, wasSynchronouslyLoaded) {
                      //   //   return CircularProgressIndicator();
                      //   // },
                      //   // loadingBuilder: (context, child, loadingProgress) {
                      //   //   return LinearProgressIndicator();
                      //   // },
                      //   image: NetworkImage(
                      //     article?.urlToImage ?? '',
                      //   ),
                      // ),
                    );
                  } else {
                    print(e);
                    return Text(
                      'Error!',
                      style: TextStyle(color: Colors.white),
                    );
                  }
                }),
          );
        },
      ),
    );
  }

// Future<Newsmodel>async {
//   super.initState();
//   var _newsModel = await API_manager().topNews();
// }

  late Future<Newsmodel> _newsModel;
  late Future<Newsmodel> _everynewsModel;

  @override
  void initState() {
    _newsModel = API_manager().topNews();
    // _everynewsModel = API_manager02().everythingNews();
    super.initState();
  }

  // 31:06 Timecode https://www.youtube.com/watch?v=1rXFKhBZXxY
  Widget trendingsList(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.51,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<Newsmodel>(
          future: _newsModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      var article = snapshot.data?.articles?[index];
                      // var image = Image.network(article!.urlToImage?? '');

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight:
                                MediaQuery.of(context).size.height * 0.15,
                            minWidth: MediaQuery.of(context).size.width,
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.20,
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.16,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    height: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      child: CachedNetworkImage(
                                        imageUrl: article?.urlToImage ?? '',
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.58,
                                        child: Text(
                                          article!.title ?? "no text",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              article.source!.name ?? "no text",
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            ),
                                            // Text(
                                            //   article.publishedAt!.day
                                            //           .toString() ??
                                            //       "no text",
                                            //   maxLines: 3,
                                            //   overflow: TextOverflow.ellipsis,
                                            //   style: TextStyle(
                                            //       color: Colors.grey,
                                            //       fontSize: 12),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            } else
              return Center(child: CircularProgressIndicator());
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
          vertical: 0,
        ),
        child: SafeArea(
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              titleLogo(),
              topHeadlinesBanner(),
              trendingTitle(),
              trendingsList(context)
            ],
          ),
        ),
      ),
    );
  }
}
