import 'package:codefactory_flutter_lv2/common/const/data.dart';
import 'package:codefactory_flutter_lv2/restaurant/model/restaurant_model.dart';

class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<RestaurantProductModel> products;

  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
  });

  factory RestaurantDetailModel.fromJson({required Map<String, dynamic> json}) {
    return RestaurantDetailModel(
      id: json['id'],
      name: json['name'],
      thumbUrl: 'http://$devHost${json['thumbUrl']}',
      tags: List<String>.from(json['tags']),
      priceRange: RestaurantPriceRange.values.firstWhere(
        (element) => element.name == json['priceRange'],
      ),
      ratings: json['ratings'],
      ratingsCount: json['ratingsCount'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
      detail: json['detail'],
      products: json['products']
          .map<RestaurantProductModel>(
            (json) => RestaurantProductModel.fromJson(json: json),
          )
          .toList(),
    );
  }
}

class RestaurantProductModel {
  final String id;
  final String name;
  final String imgUrl;
  final String detail;
  final int price;

  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });

  factory RestaurantProductModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return RestaurantProductModel(
      id: json['id'],
      name: json['name'],
      imgUrl: 'http://$devHost${json['imgUrl']}',
      detail: json['detail'],
      price: json['price'],
    );
  }
}
