import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:raqi/src/common/bottom_navigation_bar/bottom_navigation_bar_controller.dart';
import 'package:raqi/src/models/articles/article_model.dart';
import 'package:raqi/src/router/app_pages.dart';
import 'package:raqi/src/theme/app_colors.dart';
import 'package:raqi/src/theme/app_image.dart';
import 'package:raqi/src/theme/fonts_family.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavigationBarScreen extends StatelessWidget {
  BottomNavigationBarScreen({super.key});
  final _controller = Get.find<BottomNavigationBarController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavigationBarController>(
        id: 'nav_bar',
        init: BottomNavigationBarController(),
        builder: (_) {
          return Scaffold(
            floatingActionButton: SizedBox(
              width: 150.w,
              height: 60.h,
              child: FloatingActionButton(
                backgroundColor: AppColors.darkBrown,
                isExtended: true,
                onPressed: () async {
                  final box = await Hive.openBox<ArticleModel>('last');
                  if (box.values.isEmpty) {
                    Get.snackbar(
                      'No artciles recently',
                      'There is no artcile being reading recently',
                      titleText: Text(
                        'No articles recently',
                        style: TextStyle(
                          color: AppColors.white,
                          fontFamily: AppFontsFamily.rubik,
                          fontSize: 16.sp,
                        ),
                      ),
                      messageText: Text(
                        'There is no articles being reading recently',
                        style: TextStyle(
                          color: AppColors.white,
                          fontFamily: AppFontsFamily.rubik,
                          fontSize: 12.sp,
                        ),
                      ),
                      backgroundColor: AppColors.primary,
                    );
                  } else {
                    Get.toNamed(AppPages.articleDetails,
                        parameters: {'index': '0'},
                        arguments: box.values.first);
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Continue',
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Icon(
                          Icons.play_circle_filled_sharp,
                          color: AppColors.white,
                          size: 20.sp,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.darkBrown,
                centerTitle: true,
                title: Text(
                  _controller.screens[_controller.selectedPage].appBarTitle!,
                  style: TextStyle(
                      color: AppColors.white,
                      fontFamily: AppFontsFamily.rubik,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp),
                )),
            bottomNavigationBar: SalomonBottomBar(
              currentIndex: _controller.selectedPage,
              items: [
                SalomonBottomBarItem(
                    icon: Image.asset(
                      AppImages.apple,
                      width: 32.w,
                      height: 32.h,
                    ),
                    title: const Text('Apple')),
                SalomonBottomBarItem(
                    icon: Image.asset(
                      AppImages.buisness,
                      width: 32.w,
                      height: 32.h,
                    ),
                    title: const Text('Business')),
                SalomonBottomBarItem(
                    icon: Image.asset(
                      AppImages.tesla,
                      width: 32.w,
                      height: 32.h,
                    ),
                    title: const Text('Tesla')),
                SalomonBottomBarItem(
                    icon: Image.asset(
                      AppImages.wall_street,
                      width: 32.w,
                      height: 32.h,
                    ),
                    title: const Text('Wall Street')),
              ],
              onTap: (int index) {
                _controller.navigate(index);
              },
            ),
            body: _controller.screens[_controller.selectedPage].screen,
          );
        });
  }
}
