import 'package:codefactory_flutter_lv2/common/provider/pagination_provider.dart';
import 'package:flutter/cupertino.dart';

class PaginationUtils {
  static void paginate({
    required ScrollController controller,
    required PaginationStateNotifier provider,
  }) {
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      provider.paginate(fetchMore: true);
    }
  }
}
