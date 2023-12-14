import 'package:get/get.dart';
import 'package:raqi/app/features/Tesla_articles/Tesla_articles_screen.dart';
import 'package:raqi/app/features/apple_articles/appl_articles_screen.dart';
import 'package:raqi/app/features/business_articles/business_articles_screen.dart';
import 'package:raqi/app/features/wall_street/wall_street_screen.dart';
import 'package:raqi/src/models/main_home_screen.dart';

class BottomNavigationBarController extends GetxController {
  int selectedPage = 0;

  List<MainHomeScreenModel> screens = [
    MainHomeScreenModel(
        appBarTitle: 'Apple Articles', screen: AppleArticlesScreen()),
    MainHomeScreenModel(
        appBarTitle: 'Business Articles', screen: BusinessArticlesScreen()),
    MainHomeScreenModel(
        appBarTitle: 'Tesla Articles', screen: TeslaArticlesScreen()),
    MainHomeScreenModel(
        appBarTitle: 'Wall street Journal Articles',
        screen: WallStreetArticlesScreen()),
  ];

  navigate(index) {
    selectedPage = index;
    update(['nav_bar']);
  }
}
