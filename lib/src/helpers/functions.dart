import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:raqi/src/enums/article_type.dart';
import 'package:raqi/src/network/server_config.dart';

Future<bool> checkInternetConnection() async {
  return await Connectivity().checkConnectivity() == ConnectivityResult.none;
}

getUrl(ArticleType type) {
  String url = '';
  if (type == ArticleType.apple) {
    url =
        '${ServerConfig.domainName}everything?q=apple&from=${getYestrdayDate()}&to=${getTodayDate()}&sortBy=popularity&apiKey=${ServerConfig.apiKey}';
    print(url);
  } else if (type == ArticleType.buisness) {
    url =
        '${ServerConfig.domainName}top-headlines?country=us&category=business&apiKey=${ServerConfig.apiKey}';
    print(url);
  } else if (type == ArticleType.tesla) {
    url =
        '${ServerConfig.domainName}everything?q=tesla&from=$getYestrdayDate()&to=$getTodayDate()&sortBy=popularity&apiKey=${ServerConfig.apiKey}';
    print(url);
  } else {
    url =
        '${ServerConfig.domainName}everything?domains=wsj.com&apiKey=${ServerConfig.apiKey}';
  }
  return url;

  /** 
   https://newsapi.org/v2/everything?q=apple
   
  */
}

getTodayDate() {
  var now = DateTime.now();
  print('${now.year}-${now.month}-${now.day}');
  return '${now.year}-${now.month}-${now.day}';
}

getYestrdayDate() {
  var now = DateTime.now().subtract(const Duration(days: 20));
  print('${now.year}-${now.month}-${now.day}');
  return '${now.year}-${now.month}-${now.day}';
}


/*
https://newsapi.org/v2/everything?q=apple&from=2023-12-9&to=2023-12-13&sortBy=popularity&apiKey=e24a5a6dda0c418fb9359dd3f110fe93
https://newsapi.org/v2/everything?q=ArticleType.apple&from=2023-12-9&to=2023-12-13&sortBy=popularity&apiKey=e24a5a6dda0c418fb9359dd3f110fe9
*/

/**
 https://newsapi.org/v2/?top-headlines?country=us&category=business&apiKey=e24a5a6dda0c418fb9359dd3f110fe93
 https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e24a5a6dda0c418fb9359dd3f110fe93
 */