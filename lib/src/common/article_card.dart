import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:raqi/src/common/constant.dart';
import 'package:raqi/src/helpers/extension.dart';
import 'package:raqi/src/models/articles/article_model.dart';
import 'package:raqi/src/router/app_pages.dart';
import 'package:raqi/src/theme/app_colors.dart';
import 'package:raqi/src/theme/app_image.dart';
import 'package:raqi/src/theme/fonts_family.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    super.key,
    required this.item,
    this.index,
  });
  final ArticleModel item;
  final index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: verticalpadding,
          left: verticalpadding,
          right: horizontolpadding),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppPages.articleDetails,
              parameters: {'index': index.toString()}, arguments: item);
        },
        child: Container(
          width: 396.w,
          height: 217.h,
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [BoxShadow(color: AppColors.dark, blurRadius: 1)]),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18.r),
                child: Hero(
                  tag: 'image$index',
                  child: item.urlToImage != null
                      ? Image.network(
                          item.urlToImage!,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              AppImages.imageHolder,
                              fit: BoxFit.cover,
                              width: 396.w,
                              height: 217.h,
                            );
                          },
                          fit: BoxFit.cover,
                          width: 396.w,
                          height: 217.h,
                        )
                      : Image.asset(
                          AppImages.imageHolder,
                          fit: BoxFit.cover,
                          width: 396.w,
                          height: 217.h,
                        ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 396.w,
                  height: 120.h,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(18.r),
                          bottomRight: Radius.circular(18.r)),
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            AppColors.darkest,
                            AppColors.darkest,
                            AppColors.darkest.withOpacity(0),
                          ])),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        item.title ?? 'title',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: AppFontsFamily.rubik,
                            color: AppColors.white),
                        overflow: TextOverflow.ellipsis,
                      ).pOnly(bottom: 8.h),
                      FittedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.author ?? 'author',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: AppFontsFamily.rubik,
                                  color: AppColors.white),
                            ).pOnly(right: 16.w),
                            Text(
                              item.publishedAt == null
                                  ? '2000'
                                  : _convertDate(item.publishedAt!),
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: AppFontsFamily.rubik,
                                  color: AppColors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ).pOnly(top: 40.h, bottom: 10.h),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _convertDate(String date) {
    DateTime parsedDate = DateTime.parse(date);

    String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
    return formattedDate;
  }
}
