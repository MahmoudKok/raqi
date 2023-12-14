import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:raqi/src/enums/article_type.dart';
import 'package:raqi/src/helpers/functions.dart';
import 'package:raqi/src/helpers/strings.dart';
import 'package:raqi/src/models/articles/article_model.dart';
import 'package:raqi/src/network/article_servces.dart';

class ArticleWallStreetController extends GetxController {
  bool isError = false;
  bool isNotConnected = false;
  bool isFirstLoad = true;
  List<ArticleModel> articles = [];

  String hiveBoxName = 'wall';
  ArticleType articleType = ArticleType.wallstreet;

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
        if (isFirstLoad) {
          isNotConnected = true;
          return;
        } else {
          articles = box.values.toList();
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
