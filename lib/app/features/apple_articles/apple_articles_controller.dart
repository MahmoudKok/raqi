import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hive/hive.dart';

import 'package:raqi/src/enums/article_type.dart';
import 'package:raqi/src/helpers/functions.dart';
import 'package:raqi/src/helpers/strings.dart';
import 'package:raqi/src/models/articles/article_model.dart';
import 'package:raqi/src/network/article_servces.dart';

class AppleArticleController extends GetxController {
  bool isError = false;
  bool isNotConnected = false;
  bool isFirstLoad = true;
  List<ArticleModel> articles = [];

  String hiveBoxName = 'apple';
  ArticleType articleType = ArticleType.apple;

  fetchArticles() async {
    try {
      final box = await Hive.openBox<ArticleModel>(hiveBoxName);
      if (!await checkInternetConnection()) {
        print('remote');
        var result = await ArticleServcies.getArticles(articleType);
        if (result is! String) {
          articles = result;
          await box.deleteFromDisk();
          for (var article in articles) {
            await saveArticle(article);
          }
          if (articles.isNotEmpty) {
            isFirstLoad = false;
          }
          update(['articles']);
          isNotConnected = false;
          isError = false;
        } else if (result == Messages.NO_INTERNET_CONNNECTION) {
          isNotConnected = true;
        } else if (result == Messages.NOT_FOUND) {
          isError = true;
        }
      } else {
        articles = box.values.toList();
        if (articles.isEmpty) {
          isNotConnected = true;
          return;
        }
        print('local');
      }
    } catch (e) {
      print(e);
    }
  }

  initRefresh() async {
    isFirstLoad = true;

    update(['init_refresh']);
  }

  onRefresh() async {
    try {
      final box = await Hive.openBox<ArticleModel>(hiveBoxName);
      var result = await ArticleServcies.getArticles(articleType);
      if (result is! String) {
        articles = result;
        await box.deleteFromDisk();
        for (var article in articles) {
          await saveArticle(article);
        }
        box.close();
        update(['articles']);
      } else {
        isFirstLoad = true;
        update(['init_refresh']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveArticle(ArticleModel article) async {
    final box = await Hive.openBox<ArticleModel>(hiveBoxName);
    await box.add(article);
  }
}
/**[
    ArticleModel(
      source: ArticleSourceModel(id: '', name: ''),
      author: 'Steve Hanson',
      title:
          'dream parts tube town orbit regular realize card journey evening at drawn becoming tales exact foot announced care given mix edge hunter sharp stuck',
      description:
          'lonely correct best shelf tears care cry whom design saved composition they at spoken soon garden passage activity second silver feed teeth direction bag',
      url: 'http://pu.su/li',
      urlToImage: 'assets/images/test.png',
      publishedAt: '4/22/2109',
      content:
          'aloud order divide exactly weigh stage general proud atom surrounded dollar pencil men adventure spider compare attempt bit no cream stone scientific orbit audience',
    ),
    ArticleModel(
      source: ArticleSourceModel(id: '', name: ''),
      author: 'Steve Hanson',
      title:
          'dream parts tube town orbit regular realize card journey evening at drawn becoming tales exact foot announced care given mix edge hunter sharp stuck',
      description:
          'lonely correct best shelf tears care cry whom design saved composition they at spoken soon garden passage activity second silver feed teeth direction bag',
      url: 'http://pu.su/li',
      urlToImage: 'assets/images/test.png',
      publishedAt: '4/22/2109',
      content:
          'aloud order divide exactly weigh stage general proud atom surrounded dollar pencil men adventure spider compare attempt bit no cream stone scientific orbit audience',
    ),
    ArticleModel(
      source: ArticleSourceModel(id: '', name: ''),
      author: 'Steve Hanson',
      title:
          'dream parts tube town orbit regular realize card journey evening at drawn becoming tales exact foot announced care given mix edge hunter sharp stuck',
      description:
          'lonely correct best shelf tears care cry whom design saved composition they at spoken soon garden passage activity second silver feed teeth direction bag',
      url: 'http://pu.su/li',
      urlToImage: 'assets/images/test.png',
      publishedAt: '4/22/2109',
      content:
          'aloud order divide exactly weigh stage general proud atom surrounded dollar pencil men adventure spider compare attempt bit no cream stone scientific orbit audience',
    ),
    ArticleModel(
      source: ArticleSourceModel(id: '', name: ''),
      author: 'Steve Hanson',
      title:
          'dream parts tube town orbit regular realize card journey evening at drawn becoming tales exact foot announced care given mix edge hunter sharp stuck',
      description:
          'lonely correct best shelf tears care cry whom design saved composition they at spoken soon garden passage activity second silver feed teeth direction bag',
      url: 'http://pu.su/li',
      urlToImage: 'assets/images/test.png',
      publishedAt: '4/22/2109',
      content:
          'aloud order divide exactly weigh stage general proud atom surrounded dollar pencil men adventure spider compare attempt bit no cream stone scientific orbit audience',
    ),
    ArticleModel(
      source: ArticleSourceModel(id: '', name: ''),
      author: 'Steve Hanson',
      title:
          'dream parts tube town orbit regular realize card journey evening at drawn becoming tales exact foot announced care given mix edge hunter sharp stuck',
      description:
          'lonely correct best shelf tears care cry whom design saved composition they at spoken soon garden passage activity second silver feed teeth direction bag',
      url: 'http://pu.su/li',
      urlToImage: 'assets/images/test.png',
      publishedAt: '4/22/2109',
      content:
          'aloud order divide exactly weigh stage general proud atom surrounded dollar pencil men adventure spider compare attempt bit no cream stone scientific orbit audience',
    ),
    ArticleModel(
      source: ArticleSourceModel(id: '', name: ''),
      author: 'Steve Hanson',
      title:
          'dream parts tube town orbit regular realize card journey evening at drawn becoming tales exact foot announced care given mix edge hunter sharp stuck',
      description:
          'lonely correct best shelf tears care cry whom design saved composition they at spoken soon garden passage activity second silver feed teeth direction bag',
      url: 'http://pu.su/li',
      urlToImage: 'assets/images/test.png',
      publishedAt: '4/22/2109',
      content:
          'aloud order divide exactly weigh stage general proud atom surrounded dollar pencil men adventure spider compare attempt bit no cream stone scientific orbit audience',
    ),
  ]; */