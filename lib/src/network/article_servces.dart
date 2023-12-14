import 'package:raqi/src/enums/article_type.dart';
import 'package:raqi/src/helpers/functions.dart';
import 'package:raqi/src/helpers/strings.dart';
import 'package:raqi/src/models/articles/article_api_response.dart';
import 'package:raqi/src/network/excptions.dart';
import 'package:http/http.dart' as http;

class ArticleServcies {
  static getArticles(ArticleType type) async {
    try {
      if (await checkInternetConnection()) {
        throw InterNetConnectionException(
            message: Messages.NO_INTERNET_CONNNECTION);
      } else {
        String url = getUrl(type);

        var response = await http.get(Uri.parse(url));
        print(response.statusCode);
        if (response.statusCode == 200) {
          ArticleApiRespons data = ArticleApiRespons.fromJson(response.body);
          print(data.totalResults.toString());
          return data.articles;
        } else if (response.statusCode == 426) {
          throw FaildException(message: Messages.TOO_OLD);
        } else if (response.statusCode == 404) {
          throw NotFoundException(message: Messages.NOT_FOUND);
        }
      }
    } on InterNetConnectionException catch (e) {
      return e.message;
    } on FaildException catch (e) {
      return e.message;
    } on NotFoundException catch (e) {
      return e.message;
    }
  }
}
