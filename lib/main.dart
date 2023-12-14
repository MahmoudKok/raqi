import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:raqi/app/features/apple_articles/apple_articles_controller.dart';
import 'package:raqi/app/features/business_articles/business_articles_controller.dart';
import 'package:raqi/app/features/tesla_articles/tesla_articles_controller.dart';
import 'package:raqi/app/features/wall_street/wall_street_controller.dart';
import 'package:raqi/src/common/bottom_navigation_bar/bottom_navigation_bar_controller.dart';
import 'package:raqi/src/layouts/splash_screen.dart';
import 'package:raqi/src/models/articles/article_model.dart';
import 'package:raqi/src/router/router.dart';
import 'package:raqi/src/theme/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  initGetXDepencies();
  runApp(const MyApp());
}

initHive() async {
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(ArticleModelAdapter());
  Hive.registerAdapter(ArticleSourceModelAdapter());
  await Hive.openBox<ArticleModel>('apple');
  await Hive.openBox<ArticleModel>('buisness');
  await Hive.openBox<ArticleModel>('tesla');
  await Hive.openBox<ArticleModel>('wall');
}

void initGetXDepencies() {
  Get.lazyPut(() => BottomNavigationBarController());
  Get.lazyPut(() => AppleArticleController());
  Get.lazyPut(() => BusinessArticlesController());
  Get.lazyPut(() => ArticleTesalController());
  Get.lazyPut(() => ArticleWallStreetController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'RaQi',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
          getPages: AppRouter.routes,
        );
      },
    );
  }
}
