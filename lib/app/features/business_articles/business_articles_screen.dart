import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:raqi/app/features/business_articles/business_articles_controller.dart';
import 'package:raqi/src/common/article_card.dart';
import 'package:raqi/src/helpers/functions.dart';
import 'package:raqi/src/helpers/strings.dart';
import 'package:raqi/src/layouts/empty_data_screen.dart';
import 'package:raqi/src/layouts/error_screen.dart';
import 'package:raqi/src/layouts/no_internet_screen.dart';
import 'package:raqi/src/layouts/shimmers.dart';
import 'package:raqi/src/models/articles/article_model.dart';
import 'package:raqi/src/theme/app_colors.dart';
import 'package:raqi/src/theme/fonts_family.dart';

class BusinessArticlesScreen extends StatelessWidget {
  BusinessArticlesScreen({super.key});
  final _controller = Get.find<BusinessArticlesController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessArticlesController>(
        id: 'init_refresh',
        init: BusinessArticlesController(),
        builder: (_) {
          return Scaffold(
            body: Center(
                child: _controller.isFirstLoad
                    ? FutureBuilder(
                        future: _controller.fetchArticles(),
                        builder: (context, snapshot) {
                          if (_controller.isNotConnected) {
                            return RefreshIndicator(
                              onRefresh: () async {
                                await _controller.initRefresh();
                              },
                              child: NoInterConnectionScreen(onRefresh: () {}),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const ArticleShimmer();
                          } else if (_controller.isError) {
                            return RefreshIndicator(
                              onRefresh: () async {
                                await _controller.initRefresh();
                              },
                              child: ErrorScreen(onRefresh: () {}),
                            );
                          } else if (_controller.articles.isEmpty) {
                            return RefreshIndicator(
                              onRefresh: () async {
                                await _controller.initRefresh();
                              },
                              child: EmptyScreen(onRefresh: () {}),
                            );
                          } else {
                            return RefreshIndicator(
                                child: GetBuilder<BusinessArticlesController>(
                                    id: 'articles',
                                    init: BusinessArticlesController(),
                                    builder: (_) {
                                      return ListView.builder(
                                        itemCount: _controller.articles.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          ArticleModel item =
                                              _controller.articles[index];
                                          return ArticleCard(
                                            item: item,
                                            index: index,
                                          );
                                        },
                                      );
                                    }),
                                onRefresh: () async {
                                  if (await checkInternetConnection()) {
                                    Get.snackbar(
                                      'No connection',
                                      Messages.NO_INTERNET_CONNNECTION,
                                      messageText: Text(
                                        Messages.NO_INTERNET_CONNNECTION,
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontFamily: AppFontsFamily.rubik,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      backgroundColor: Colors.redAccent,
                                    );
                                  }
                                  await _controller.onRefresh();
                                });
                          }
                        },
                      )
                    : RefreshIndicator(
                        child: GetBuilder<BusinessArticlesController>(
                            id: 'articles',
                            init: BusinessArticlesController(),
                            builder: (_) {
                              if (_controller.articles.isEmpty) {
                                return RefreshIndicator(
                                  onRefresh: () async {
                                    await _controller.initRefresh();
                                  },
                                  child: EmptyScreen(onRefresh: () {}),
                                );
                              } else {
                                return ListView.builder(
                                  itemCount: _controller.articles.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    ArticleModel item =
                                        _controller.articles[index];
                                    return ArticleCard(
                                      item: item,
                                      index: index,
                                    );
                                  },
                                );
                              }
                            }),
                        onRefresh: () async {
                          await _controller.onRefresh();
                        })),
          );
        });
  }
}
