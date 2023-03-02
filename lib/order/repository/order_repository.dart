import 'package:codefactory_flutter_lv2/common/const/data.dart';
import 'package:codefactory_flutter_lv2/common/dio/dio.dart';
import 'package:codefactory_flutter_lv2/order/model/order_model.dart';
import 'package:codefactory_flutter_lv2/order/model/post_order_body.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

part 'order_repository.g.dart';

final orderRepositoryProvider = Provider<OrderRepository>(
  (ref) => OrderRepository(
    dio,
    baseUrl: 'http://$devHost/order',
  ),
);

@RestApi()
abstract class OrderRepository {
  factory OrderRepository(Dio dio, {String baseUrl}) = _OrderRepository;

  @POST('/')
  @Headers({'accessToken': 'true'})
  Future<OrderModel> postOrder({
    @Body() required PostOrderBody body,
  });
}
