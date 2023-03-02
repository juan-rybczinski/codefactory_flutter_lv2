import 'package:codefactory_flutter_lv2/common/const/colors.dart';
import 'package:codefactory_flutter_lv2/common/layout/default_layout.dart';
import 'package:codefactory_flutter_lv2/order/provider/order_provider.dart';
import 'package:codefactory_flutter_lv2/order/view/order_done_screen.dart';
import 'package:codefactory_flutter_lv2/product/component/product_card.dart';
import 'package:codefactory_flutter_lv2/user/provider/basket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BasketScreen extends ConsumerWidget {
  static String get routeName => 'basket';

  const BasketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);
    if (basket.isEmpty) {
      return const DefaultLayout(
        title: '장바구니',
        child: Center(
          child: Text('장바구니가 비어있습니다 ㅠㅠ'),
        ),
      );
    }

    final productsTotal =
        basket.fold<int>(0, (p, n) => p + n.product.price * n.count);
    final deliveryFee = basket.first.product.restaurant.deliveryFee;

    return DefaultLayout(
      title: '장바구니',
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (_, index) => ProductCard.fromProductModel(
                    model: basket[index].product,
                    onAdd: () => ref
                        .read(basketProvider.notifier)
                        .addToBasket(product: basket[index].product),
                    onSubtract: () => ref
                        .read(basketProvider.notifier)
                        .removeFromBasket(product: basket[index].product),
                  ),
                  separatorBuilder: (_, __) => const Divider(height: 32.0),
                  itemCount: basket.length,
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '장바구니 금액',
                        style: TextStyle(
                          color: BODY_TEXT_COLOR,
                        ),
                      ),
                      Text('￦$productsTotal'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '배달비',
                        style: TextStyle(
                          color: BODY_TEXT_COLOR,
                        ),
                      ),
                      Text('￦$deliveryFee'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('총액'),
                      Text('￦${productsTotal + deliveryFee}'),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final resp =
                            await ref.read(orderProvider.notifier).postOrder();

                        if (resp) {
                          context.goNamed(OrderDoneScreen.routeName);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('결제 실패!'),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PRIMARY_COLOR,
                      ),
                      child: const Text('결제하기'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
