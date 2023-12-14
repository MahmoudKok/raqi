import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:raqi/src/common/constant.dart';
import 'package:raqi/src/helpers/extension.dart';
import 'package:raqi/src/helpers/strings.dart';
import 'package:raqi/src/models/articles/article_model.dart';
import 'package:raqi/src/theme/app_colors.dart';
import 'package:raqi/src/theme/fonts_family.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailsScreen extends StatelessWidget {
  @override
  var data = Get.parameters;
  ArticleModel item = Get.arguments;

  ArticleDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: Get.size.height * 0.5,
              // pinned: true,
              flexibleSpace: Stack(
                children: [
                  Hero(
                    tag: 'image${data['index']}',
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        item.urlToImage == null
                            ? Image.asset(
                                'assets/images/imageholder.png',
                                alignment: Alignment.topCenter,
                                fit: BoxFit.cover,
                                width: Get.size.width,
                                height: Get.size.height * 0.3,
                              )
                            : Image.network(
                                item.urlToImage!,
                                alignment: Alignment.topCenter,
                                fit: BoxFit.cover,
                                width: Get.size.width,
                                height: Get.size.height * 0.3,
                              ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.h),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      width: 50.w,
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                          color: AppColors.darkest
                                              .withOpacity(0.2),
                                          shape: BoxShape.circle),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_back_ios_new,
                                    size: 24.sp,
                                    color: AppColors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0.h,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: horizontolpadding,
                          vertical: verticalpadding),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.r),
                          topRight: Radius.circular(18.r),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          item.title!,
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontFamily: AppFontsFamily.rubik,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      item.content!,
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: AppFontsFamily.rubik,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (await canLaunchUrl(Uri.parse(item.url!))) {
                        launch(
                          item.url!,
                        );
                      } else {
                        GetSnackBar(
                          message: Messages.SERVER_FAILED,
                          backgroundColor: Colors.redAccent,
                        );
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          'Open the article on browser',
                          style: TextStyle(
                            color: AppColors.lighter,
                            fontSize: 18.sp,
                            fontFamily: AppFontsFamily.rubik,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Icon(
                          Icons.open_in_new,
                          size: 48.sp,
                          color: AppColors.lighter,
                        )
                      ],
                    ),
                  ).pSymmetric(horizontal: horizontolpadding)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/**
 * 
 * 
 * Scaffold(
      body: SizedBox(
        width: Get.size.width,
        height: Get.size.height,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: 'image',
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Image.asset(
                      'assets/images/test.png',
                      alignment: Alignment.topCenter,
                      fit: BoxFit.cover,
                      width: Get.size.width,
                      height: Get.size.height * 0.3,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                  width: 50.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                      color: AppColors.darkest.withOpacity(0.2),
                                      shape: BoxShape.circle),
                                ),
                              ),
                              Icon(
                                Icons.arrow_back_ios_new,
                                size: 24.sp,
                                color: AppColors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: Get.size.width,
                height: Get.size.height * 0.75,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.r),
                      topRight: Radius.circular(18.r),
                    )),
              ),
            )
          ],
        ),
      ),
    );
 */