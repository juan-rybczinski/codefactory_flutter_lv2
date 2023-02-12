import 'package:codefactory_flutter_lv2/common/component/pagination_list_view.dart';
import 'package:codefactory_flutter_lv2/restaurant/component/restaurant_card.dart';
import 'package:codefactory_flutter_lv2/restaurant/provider/restaurant_provider.dart';
import 'package:codefactory_flutter_lv2/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RestaurantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaginationListView(
      provider: restaurantProvider,
      itemBuilder: <RestaurantModel>(_, index, model) => GestureDetector(
        onTap: () => context.goNamed(
          RestaurantDetailScreen.routeName,
          params: {
            'rid': model.id,
          },
        ),
        child: RestaurantCard.fromModel(model: model),
      ),
    );
  }
}
