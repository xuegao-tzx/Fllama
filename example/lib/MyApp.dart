import 'package:fllama_example/bean/Enum.dart';
import 'package:fllama_example/main.dart';
import 'package:fllama_example/theme.dart';
import 'package:fllama_example/view/AboutView.dart';
import 'package:fllama_example/view/HomeView.dart';
import 'package:fllama_example/view/ModelManageView.dart';
import 'package:fllama_example/vm/AboutVM.dart';
import 'package:fllama_example/vm/HomeVM.dart';
import 'package:fllama_example/vm/ModelVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:flutter_easyloading/flutter_easyloading.dart";
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void _setSystemUIOverlayStyle(ThemeMode value) {
    if (value == ThemeMode.dark) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Get.theme.colorScheme.surfaceBright,
        //状态栏颜色
        statusBarIconBrightness: Brightness.light,
        //状态栏图标颜色
        statusBarBrightness: Brightness.dark,
        //状态栏亮度
        systemStatusBarContrastEnforced: false,
        //系统状态栏对比度强制
        systemNavigationBarColor: Colors.transparent,
        //导航栏颜色
        systemNavigationBarIconBrightness: Brightness.light,
        //导航栏图标颜色
        systemNavigationBarDividerColor: Colors.transparent,
        //系统导航栏分隔线颜色
        systemNavigationBarContrastEnforced: false, //系统导航栏对比度强制
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Get.theme.colorScheme.surfaceBright,
        //状态栏颜色
        statusBarIconBrightness: Brightness.dark,
        //状态栏图标颜色
        statusBarBrightness: Brightness.light,
        //状态栏亮度
        systemStatusBarContrastEnforced: false,
        //系统状态栏对比度强制
        systemNavigationBarColor: Colors.transparent,
        //导航栏颜色
        systemNavigationBarIconBrightness: Brightness.dark,
        //导航栏图标颜色
        systemNavigationBarDividerColor: Colors.transparent,
        //系统导航栏分隔线颜色
        systemNavigationBarContrastEnforced: false, //系统导航栏对比度强制
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        navigatorKey: navigatorKey,
        title: "LocalAI",
        debugShowCheckedModeBanner: false,
        //调试水印
        theme: const MaterialTheme().light(),
        darkTheme: const MaterialTheme().dark(),
        home: const HomeView(),
        binds: [Bind.lazyPut<HomeVM>(() => HomeVM())],
        initialRoute: RouteEntry.home.label,
        onReady: () {
          Get.changeThemeMode(ThemeMode.light);
          //_setSystemUIOverlayStyle(ThemeMode.light);
        },
        logger: logger,
        builder: EasyLoading.init(),
        getPages: [
          GetPage(
              name: RouteEntry.home.label,
              page: () => const HomeView(),
              transition: Transition.fadeIn,
              transitionDuration: const Duration(milliseconds: 234),
              binds: [Bind.lazyPut<HomeVM>(() => HomeVM())]),
          GetPage(
              name: RouteEntry.about.label,
              page: () => const AboutView(),
              transition: Transition.fadeIn,
              transitionDuration: const Duration(milliseconds: 345),
              binds: [Bind.lazyPut<AboutVM>(() => AboutVM())]),
          GetPage(
              name: RouteEntry.modelManager.label,
              page: () => const ModelManageView(),
              transition: Transition.fadeIn,
              transitionDuration: const Duration(milliseconds: 345),
              binds: [Bind.lazyPut<ModelVM>(() => ModelVM())]),
        ]);
  }
}
