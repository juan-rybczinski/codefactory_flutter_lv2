import 'package:codefactory_flutter_lv2/common/const/data.dart';

class DataUtils {
  static String pathToUrl(value) {
    return 'http://$devHost$value';
  }

  static List<String> listPathsToUrls(List paths) {
    return paths.map((e) => pathToUrl(e)).toList();
  }
}