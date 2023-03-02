import 'package:codefactory_flutter_lv2/common/model/cursor_pagination_model.dart';
import 'package:codefactory_flutter_lv2/common/provider/pagination_provider.dart';
import 'package:codefactory_flutter_lv2/order/model/order_model.dart';
import 'package:codefactory_flutter_lv2/order/model/post_order_body.dart';
import 'package:codefactory_flutter_lv2/order/repository/order_repository.dart';
import 'package:codefactory_flutter_lv2/user/provider/basket_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final orderProvider =
    StateNotifierProvider<OrderStaterNotifier, CursorPaginationBase>(
  (ref) => OrderStaterNotifier(
    ref: ref,
    repository: ref.watch(
      orderRepositoryProvider,
    ),
  ),
);

class OrderStaterNotifier extends PaginationStateNotifier<OrderModel, OrderRepository> {
  final Ref ref;

  OrderStaterNotifier({
    required this.ref,
    required super.repository,
  });

  Future<bool> postOrder() async {
    const uuid = Uuid();
    final id = uuid.v4();
    final state = ref.read(basketProvider);

    try {
      await repository.postOrder(
        body: PostOrderBody(
          id: id,
          products: state
              .map(
                (e) => PostOrderBodyProduct(
                  productId: e.product.id,
                  count: e.count,
                ),
              )
              .toList(),
          totalPrice: state.fold<int>(
            0,
            (p, n) => p + n.product.price * n.count,
          ),
          createdAt: DateTime.now().toString(),
        ),
      );

      return true;
    } catch (e) {
      print(e);

      return false;
    }
  }
}
