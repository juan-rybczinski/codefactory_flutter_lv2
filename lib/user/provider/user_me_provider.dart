import 'package:codefactory_flutter_lv2/common/const/data.dart';
import 'package:codefactory_flutter_lv2/common/secure_storage/secure_storage.dart';
import 'package:codefactory_flutter_lv2/user/model/user_model.dart';
import 'package:codefactory_flutter_lv2/user/repository/auth_repository.dart';
import 'package:codefactory_flutter_lv2/user/repository/user_me_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final userMeProvider =
    StateNotifierProvider<UserMeStateNotifier, UserModelBase?>(
  (ref) => UserMeStateNotifier(
    authRepository: ref.watch(authRepositoryProvider),
    repository: ref.watch(userMeRepositoryProvider),
    storage: storage,
  ),
);

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final AuthRepository authRepository;
  final UserMeRepository repository;
  final FlutterSecureStorage storage;

  UserMeStateNotifier({
    required this.authRepository,
    required this.repository,
    required this.storage,
  }) : super(UserModelLoading()) {
    getMe();
  }

  Future<void> getMe() async {
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    if (accessToken == null || refreshToken == null) {
      state = null;
      return;
    }

    state = await repository.getMe();
  }

  Future<UserModelBase> login({
    required String username,
    required String password,
  }) async {
    try {
      state = UserModelLoading();

      final resp = await authRepository.login(
        username: username,
        password: password,
      );

      await Future.wait([
        storage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken),
        storage.write(key: REFRESH_TOKEN_KEY, value: resp.refreshToken),
      ]);

      final userResp = await repository.getMe();
      state = userResp;

      return Future.value(state);
    } catch (e) {
      state = UserModelError(message: '로그인에 실패했습니다.');

      return Future.value(state);
    }
  }

  Future<void> logout() async {
    state = null;

    await Future.wait([
      storage.delete(key: ACCESS_TOKEN_KEY),
      storage.delete(key: REFRESH_TOKEN_KEY),
    ]);
  }
}
