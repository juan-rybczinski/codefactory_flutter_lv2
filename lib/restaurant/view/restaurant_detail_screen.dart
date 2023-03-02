import 'package:badges/badges.dart';
import 'package:codefactory_flutter_lv2/common/const/colors.dart';
import 'package:codefactory_flutter_lv2/common/layout/default_layout.dart';
import 'package:codefactory_flutter_lv2/common/model/cursor_pagination_model.dart';
import 'package:codefactory_flutter_lv2/common/utils/pagination_utils.dart';
import 'package:codefactory_flutter_lv2/product/component/product_card.dart';
import 'package:codefactory_flutter_lv2/product/model/product_model.dart';
import 'package:codefactory_flutter_lv2/rating/component/rating_card.dart';
import 'package:codefactory_flutter_lv2/rating/model/rating_model.dart';
import 'package:codefactory_flutter_lv2/restaurant/component/restaurant_card.dart';
import 'package:codefactory_flutter_lv2/restaurant/model/restaurant_detail_model.dart';
import 'package:codefactory_flutter_lv2/restaurant/model/restaurant_model.dart';
import 'package:codefactory_flutter_lv2/restaurant/provider/restaurant_provider.dart';
import 'package:codefactory_flutter_lv2/restaurant/provider/restaurant_rating_provider.dart';
import 'package:codefactory_flutter_lv2/restaurant/view/basket_screen.dart';
import 'package:codefactory_flutter_lv2/user/provider/basket_provider.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletons/skeletons.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'restaurantDetail';

  final String id;

  const RestaurantDetailScreen({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
    controller.addListener(scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(scrollListener);

    super.dispose();
  }

  void scrollListener() {
    PaginationUtils.paginate(
        controller: controller,
        provider: ref.read(restaurantRatingProvider(widget.id).notifier));
  }

  @override
  Widget build(BuildContext context) {
    final restaurant = ref.watch(restaurantDetailProvider(widget.id));
    final ratings = ref.watch(restaurantRatingProvider(widget.id));
    final basket = ref.watch(basketProvider);

    if (restaurant == null) {
      return const DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
      title: restaurant.name,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(BasketScreen.routeName),
        backgroundColor: PRIMARY_COLOR,
        child: Badge(
          showBadge: basket.isNotEmpty,
          badgeContent: Text(
            basket
                .fold<int>(0, (previous, next) => previous + next.count)
                .toString(),
            style: const TextStyle(
              color: PRIMARY_COLOR,
              fontSize: 10.0,
            ),
          ),
          badgeStyle: const BadgeStyle(
            badgeColor: Colors.white,
          ),
          child: const Icon(
            Icons.shopping_basket_outlined,
          ),
        ),
      ),
      child: CustomScrollView(
        controller: controller,
        slivers: [
          renderTop(model: restaurant),
          if (restaurant is! RestaurantDetailModel) renderLoading(),
          if (restaurant is RestaurantDetailModel) renderLabel(),
          if (restaurant is RestaurantDetailModel)
            renderProducts(restaurant: restaurant),
          if (ratings is CursorPagination<RatingModel>)
            renderRatings(models: ratings.data)
        ],
      ),
    );
  }

  SliverPadding renderRatings({
    required List<RatingModel> models,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) => Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: RatingCard.fromModel(model: models[index]),
          ),
          childCount: models.length,
        ),
      ),
    );
  }

  SliverToBoxAdapter renderTop({
    required RestaurantModel model,
  }) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }

  SliverPadding renderLabel() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  SliverPadding renderProducts({
    required RestaurantDetailModel restaurant,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => InkWell(
                  onTap: () => ref.read(basketProvider.notifier).addToBasket(
                        product: ProductModel(
                          id: restaurant.products[index].id,
                          name: restaurant.products[index].name,
                          detail: restaurant.products[index].detail,
                          imgUrl: restaurant.products[index].imgUrl,
                          price: restaurant.products[index].price,
                          restaurant: restaurant,
                        ),
                      ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: ProductCard.fromRestaurantProductModel(
                      model: restaurant.products[index],
                    ),
                  ),
                ),
            childCount: restaurant.products.length),
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.only(
                top: 32.0,
              ),
              child: SkeletonParagraph(
                style: const SkeletonParagraphStyle(
                  lines: 5,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
