import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:raqi/src/common/bottom_navigation_bar/bottom_navigation_bar_controller.dart';
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
