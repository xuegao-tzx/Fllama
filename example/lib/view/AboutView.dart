import 'package:about/about.dart';
import 'package:fcllama_example/bean/Enum.dart';
import 'package:fcllama_example/utils/HorizontalSwipeBack.dart';
import 'package:fcllama_example/vm/AboutVM.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final AboutVM aVM = Get.find<AboutVM>();
    return HorizontalSwipeBack(
        onBack: () {
          Get.offAllNamed(RouteEntry.home.label);
        },
        child: SafeArea(
            child: Stack(children: [
          Obx(() => AboutPage(
                values: {
                  "version": aVM.version.value,
                  "buildNumber": aVM.buildNumber.value,
                  "year": DateTime.now().year.toString(),
                  "author": "田梓萱",
                },
                title: const Offstage(),
                applicationVersion: "V {{ version }}({{ buildNumber }})",
                applicationLegalese:
                    "Copyright ©{{ author }} ${"copyright".tr} | 2021-{{ year }}",
                applicationDescription: Text(
                  aVM.cpuInfo.value,
                  textAlign: TextAlign.center,
                ),
                children: [
                  LicensesPageListTile(
                    title: Text("OpenSource Software".tr),
                    icon: const Icon(Icons.code_rounded),
                  ),
                  Container(
                    height: 48,
                  )
                ],
              )),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: IconButton(
                  onPressed: () {
                    Get.offAllNamed(RouteEntry.home.label);
                  },
                  iconSize: 28,
                  icon: const Icon(Icons.close_rounded),
                )),
          ),
        ])));
  }
}
