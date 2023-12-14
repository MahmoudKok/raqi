import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:raqi/app/features/article_datails/article_details_screen.dart';
import 'package:raqi/src/common/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:raqi/src/router/app_pages.dart';

class AppRouter {
  static final routes = [
    GetPage(name: AppPages.articleDetails, page: () => ArticleDetailsScreen()),
    GetPage(name: AppPages.home, page: () => BottomNavigationBarScreen()),
  ];
}
