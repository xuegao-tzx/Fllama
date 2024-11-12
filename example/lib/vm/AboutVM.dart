import 'package:fllama/fllama.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutVM extends GetxController {
  var version = "1.0.0".obs;
  var buildNumber = DateTime.now().toString().obs;
  var cpuInfo = "".obs;

  @override
  void onInit() {
    PackageInfo.fromPlatform().then((value) => {
          version.value = value.version.toString(),
          buildNumber.value = value.buildNumber.toString(),
          Get.log("V${version.value}[${buildNumber.value}]")
        });
    Fllama.instance()?.getCpuInfo().then((value) {
      Get.log("CPU-Info=$value");
      cpuInfo.value = value.toString();
    });
    super.onInit();
  }
}
