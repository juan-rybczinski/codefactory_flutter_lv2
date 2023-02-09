import 'package:codefactory_flutter_lv2/common/component/pagination_list_view.dart';
import 'package:codefactory_flutter_lv2/restaurant/component/restaurant_card.dart';
import 'package:codefactory_flutter_lv2/restaurant/provider/restaurant_provider.dart';
import 'package:codefactory_flutter_lv2/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaginationListView(
      provider: restaurantProvider,
      itemBuilder: <RestaurantModel>(_, index, model) => GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => RestaurantDetailScreen(id: model.id),
          ),
        ),
        child: RestaurantCard.fromModel(model: model),
      ),
    );
  }
}
