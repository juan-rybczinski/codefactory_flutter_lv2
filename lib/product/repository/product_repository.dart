import 'package:codefactory_flutter_lv2/common/const/data.dart';
import 'package:codefactory_flutter_lv2/common/dio/dio.dart';
import 'package:codefactory_flutter_lv2/common/model/cursor_pagination_model.dart';
import 'package:codefactory_flutter_lv2/common/model/pagination_params.dart';
import 'package:codefactory_flutter_lv2/common/repository/base_pagination_repository.dart';
import 'package:codefactory_flutter_lv2/product/model/product_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

part 'product_repository.g.dart';

final productRepositoryProvider = Provider(
    (ref) => ProductRepository(dio, baseUrl: 'http://$devHost/product'));

@RestApi()
abstract class ProductRepository
    implements IBasePaginationRepository<ProductModel> {
  factory ProductRepository(Dio dio, {String baseUrl}) = _ProductRepository;

  @override
  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<ProductModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
