import 'package:codefactory_flutter_lv2/common/model/cursor_pagination_model.dart';
import 'package:codefactory_flutter_lv2/common/provider/pagination_provider.dart';
import 'package:codefactory_flutter_lv2/product/model/product_model.dart';
import 'package:codefactory_flutter_lv2/product/repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productProvider =
    StateNotifierProvider<ProductStateNotifier, CursorPaginationBase>((ref) =>
        ProductStateNotifier(repository: ref.read(productRepositoryProvider)));

class ProductStateNotifier
    extends PaginationStateNotifier<ProductModel, ProductRepository> {
  ProductStateNotifier({
    required super.repository,
  });
}
