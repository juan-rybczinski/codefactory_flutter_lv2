import 'package:codefactory_flutter_lv2/common/model/cursor_pagination_model.dart';
import 'package:codefactory_flutter_lv2/common/provider/pagination_provider.dart';
import 'package:codefactory_flutter_lv2/restaurant/model/restaurant_model.dart';
import 'package:codefactory_flutter_lv2/restaurant/repository/restaurant_repository.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantDetailProvider =
    Provider.family<RestaurantModel?, String>((ref, id) {
  final restaurants = ref.watch(restaurantProvider);

  if (restaurants is! CursorPagination) {
    return null;
  }

  return restaurants.data.firstWhereOrNull((restaurant) => restaurant.id == id);
});

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
  (ref) => RestaurantStateNotifier(
    repository: ref.read(
      restaurantRepositoryProvider,
    ),
  ),
);

class RestaurantStateNotifier
    extends PaginationStateNotifier<RestaurantModel, RestaurantRepository> {
  RestaurantStateNotifier({
    required super.repository,
  });

  void getDetail({
    required String id,
  }) async {
    if (state is! CursorPagination) {
      await paginate();
    }

    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination;

    final resp = await repository.getRestaurantDetail(id: id);

    if (pState.data.where((element) => element.id == id).isEmpty) {
      state = pState.copyWith(data: <RestaurantModel>[
        ...pState.data,
        resp,
      ]);
    } else {
      state = pState.copyWith(
        data: pState.data
            .map<RestaurantModel>(
                (restaurant) => restaurant.id == id ? resp : restaurant)
            .toList(),
      );
    }
  }
}
