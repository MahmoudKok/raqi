import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:raqi/src/router/app_pages.dart';
import 'package:raqi/src/theme/app_colors.dart';
import 'package:raqi/src/theme/fonts_family.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  String _typedText = '';
  bool _showCursor = true;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(milliseconds: 350), (timer) {
      setState(() {
        _showCursor = !_showCursor;
      });

      if (timer.tick.isOdd && _typedText.length < 4) {
        setState(() {
          _typedText += 'RAQI'[timer.tick ~/ 2];
        });
      } else if (_typedText.length == 4) {
        _timer.cancel();
        Get.offAndToNamed(AppPages.home);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBrown,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _typedText,
              style: TextStyle(
                  fontSize: 48.0.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: AppFontsFamily.rubik),
            ),
            Visibility(
              visible: _showCursor,
              child: Container(
                width: 10.0.h,
                height: 48.0.w,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
