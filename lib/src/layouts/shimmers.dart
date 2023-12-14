import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raqi/src/common/constant.dart';
import 'package:raqi/src/helpers/extension.dart';
import 'package:raqi/src/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ArticleShimmer extends StatelessWidget {
  const ArticleShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Shimmer.fromColors(
            baseColor: AppColors.white,
            highlightColor: AppColors.lightes,
            child: Padding(
              padding: EdgeInsets.only(
                  top: verticalpadding,
                  left: verticalpadding,
                  right: horizontolpadding),
              child: Stack(
                children: [
                  Shimmer.fromColors(
                    baseColor: AppColors.white,
                    highlightColor: AppColors.lightes,
                    child: Container(
                      width: 396.w,
                      height: 217.h,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(color: AppColors.dark, blurRadius: 1)
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      width: 396.w,
                      child: Row(
                        children: [
                          Shimmer.fromColors(
                            baseColor: AppColors.white,
                            highlightColor: AppColors.lightes,
                            child: Container(
                              height: 40.h,
                              width: 150.w,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Shimmer.fromColors(
                            baseColor: AppColors.white,
                            highlightColor: AppColors.lightes,
                            child: Container(
                              height: 40.h,
                              width: 150.w,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ).pSymmetric(vertical: verticalpadding),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
