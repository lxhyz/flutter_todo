import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension PrecentSized on double{
  double get hp => (Get.width * (this / 100));
  double get wp => (Get.height * (this / 100));
}

extension ReponsiveText on double {
  double get sp => Get.width / 100 * (this / 3);
}

extension HexColor on double {
  static Color fromHex(String hexString){
    final buffer = StringBuffer();
    if(hexString.length == 6 || hexString.length == 7) buffer.write(hexString);
    buffer.write(hexString.replaceFirst("#", ""));
    return Color(int.parse(buffer.toString()));
  }

  String toHex({bool leadingHashSing = true}) => "${leadingHashSing}";
  
}