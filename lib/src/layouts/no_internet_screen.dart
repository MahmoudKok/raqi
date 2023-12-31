import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raqi/src/common/constant.dart';
import 'package:raqi/src/helpers/strings.dart';
import 'package:raqi/src/theme/app_colors.dart';
import 'package:raqi/src/theme/app_image.dart';
import 'package:raqi/src/theme/fonts_family.dart';

class NoInterConnectionScreen extends StatelessWidget {
  const NoInterConnectionScreen({super.key, this.onRefresh});
  final onRefresh;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: horizontolpadding, vertical: verticalpadding),
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.no_internet,
                    width: 250.w,
                    height: 250.h,
                  ),
                  SizedBox(
                    height: verticalpadding,
                  ),
                  SizedBox(
                    width: 250.w,
                    height: 250.h,
                    child: Text(
                      Messages.NO_INTERNET_CONNNECTION,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.darker,
                          fontFamily: AppFontsFamily.rubik,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
