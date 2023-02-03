import 'package:codefactory_flutter_lv2/common/model/model_with_id.dart';
import 'package:codefactory_flutter_lv2/common/utils/data_utils.dart';
import 'package:codefactory_flutter_lv2/user/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating_model.g.dart';

@JsonSerializable()
class RatingModel implements IModelWithId {
  final String id;
  @JsonKey(
    fromJson: DataUtils.listPathsToUrls
  )
  final List<String> imgUrls;
  final UserModel user;
  final String content;
  final int rating;

  RatingModel({
    required this.id,
    required this.imgUrls,
    required this.user,
    required this.content,
    required this.rating,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
        _$RatingModelFromJson(json);
}
