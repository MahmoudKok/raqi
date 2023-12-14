import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hive/hive.dart';
import 'package:raqi/src/models/articles/article_model.dart';

class ArticleDetailsController extends GetxController {
  ArticleModel? item;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  saveLastArticle() async {
    try {
      if (item != null) {
        final box = await Hive.openBox<ArticleModel>('last');
        box.put('last', item!);
      }
    } catch (e) {
      print(e);
    }
  }

  readArticle() async {
    final box = await Hive.openBox<ArticleModel>('last');
    print(box.get('last'));
  }
}
