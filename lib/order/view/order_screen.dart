import 'package:codefactory_flutter_lv2/common/component/pagination_list_view.dart';
import 'package:codefactory_flutter_lv2/common/layout/default_layout.dart';
import 'package:codefactory_flutter_lv2/order/component/order_card.dart';
import 'package:codefactory_flutter_lv2/order/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      child: PaginationListView(
        provider: orderProvider,
        itemBuilder: <OrderModel>(_, __, model) =>
            OrderCard.fromModel(model: model),
      ),
    );
  }
}
