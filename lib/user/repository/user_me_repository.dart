import 'package:codefactory_flutter_lv2/common/const/data.dart';
import 'package:codefactory_flutter_lv2/common/dio/dio.dart';
import 'package:codefactory_flutter_lv2/user/model/user_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

part 'user_me_repository.g.dart';

final userMeRepositoryProvider = Provider(
  (ref) => UserMeRepository(
    dio,
    baseUrl: 'http://$devHost/user/me',
  ),
);

@RestApi()
abstract class UserMeRepository {
  factory UserMeRepository(Dio dio, {String baseUrl}) = _UserMeRepository;

  @GET(('/'))
  @Headers({'accessToken': 'true'})
  Future<UserModel> getMe();
}
