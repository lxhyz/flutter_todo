import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/utils/keys.dart';

class StroageService extends GetxService{
  late GetStorage _box;

  Future<StroageService> init() async {
    _box = GetStorage();
    await _box.writeIfNull(taskkey, []);
    return this;
  }

  T read<T>(String key){
    return _box.read(key);
  }

  void write(String key,dynamic value) async {
    await _box.write(key, value);
  }
}