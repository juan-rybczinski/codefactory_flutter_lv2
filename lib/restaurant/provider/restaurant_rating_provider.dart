import 'package:codefactory_flutter_lv2/common/model/cursor_pagination_model.dart';
import 'package:codefactory_flutter_lv2/common/provider/pagination_provider.dart';
import 'package:codefactory_flutter_lv2/rating/model/rating_model.dart';
import 'package:codefactory_flutter_lv2/restaurant/repository/restaurant_rating_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantRatingProvider = StateNotifierProvider.family<
        RestaurantRatingStateNotifier, CursorPaginationBase, String>(
    (ref, id) => RestaurantRatingStateNotifier(
        repository: ref.read(restaurantRatingRepositoryProvider(id))));

class RestaurantRatingStateNotifier
    extends PaginationStateNotifier<RatingModel, RestaurantRatingRepository> {
  RestaurantRatingStateNotifier({
    required super.repository,
  });
}
