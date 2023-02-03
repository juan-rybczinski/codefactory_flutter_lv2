import 'package:codefactory_flutter_lv2/common/const/data.dart';
import 'package:codefactory_flutter_lv2/common/dio/dio.dart';
import 'package:codefactory_flutter_lv2/common/model/cursor_pagination_model.dart';
import 'package:codefactory_flutter_lv2/common/model/pagination_params.dart';
import 'package:codefactory_flutter_lv2/common/repository/base_pagination_repository.dart';
import 'package:codefactory_flutter_lv2/rating/model/rating_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

part 'restaurant_rating_repository.g.dart';

final restaurantRatingRepositoryProvider =
    Provider.family<RestaurantRatingRepository, String>((ref, id) =>
        RestaurantRatingRepository(dio,
            baseUrl: 'http://$devHost/restaurant/$id/rating'));

@RestApi()
abstract class RestaurantRatingRepository
    implements IBasePaginationRepository<RatingModel> {
  factory RestaurantRatingRepository(Dio dio, {String baseUrl}) =
      _RestaurantRatingRepository;

  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<RatingModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
