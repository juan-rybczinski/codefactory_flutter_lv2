import 'package:codefactory_flutter_lv2/common/const/data.dart';
import 'package:codefactory_flutter_lv2/common/dio/dio.dart';
import 'package:codefactory_flutter_lv2/restaurant/component/restaurant_card.dart';
import 'package:codefactory_flutter_lv2/restaurant/model/restaurant_model.dart';
import 'package:codefactory_flutter_lv2/restaurant/repository/restaurant_repository.dart';
import 'package:codefactory_flutter_lv2/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  Future<List<RestaurantModel>> paginateRestaurant() async {
    final dio = Dio();
    dio.interceptors.add(
      CustomInterceptor(),
    );

    final repository = RestaurantRepository(dio, baseUrl: 'http://$devHost/restaurant');
    final resp = await repository.paginate();

    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder<List<RestaurantModel>>(
          future: paginateRestaurant(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.separated(
              itemBuilder: (_, index) {
                final pItem = snapshot.data![index];

                return GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => RestaurantDetailScreen(id: pItem.id),
                    ),
                  ),
                  child: RestaurantCard.fromModel(model: pItem),
                );
              },
              separatorBuilder: (_, index) => const SizedBox(height: 16.0),
              itemCount: snapshot.data!.length,
            );
          },
        ),
      ),
    );
  }
}
