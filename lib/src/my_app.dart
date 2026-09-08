import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/app/app_material.dart';
import 'core/constants/decorations/app_sizes.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    log('state: $state', name: 'AppLifecycleState');
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppSizes.screenSize,
      minTextAdapt: true,
      builder: (context, child) => const AppMaterial(),
    );
  }
}
