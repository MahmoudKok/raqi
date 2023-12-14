import 'package:get/get.dart';
import 'package:raqi/app/features/article_datails/article_details_controller.dart';

class ArticleDetailsBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ArticleDetailsController());
  }
}
