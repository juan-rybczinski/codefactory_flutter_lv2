/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal

import 'package:flutter/widgets.dart';

class $AssetImgGen {
  const $AssetImgGen();

  $AssetImgFoodGen get food => const $AssetImgFoodGen();
  $AssetImgLogoGen get logo => const $AssetImgLogoGen();
  $AssetImgMiscGen get misc => const $AssetImgMiscGen();
}

class $AssetRiveGen {
  const $AssetRiveGen();

  /// File path: asset/rive/basketball.riv
  String get basketball => 'asset/rive/basketball.riv';

  /// List of all assets
  List<String> get values => [basketball];
}

class $AssetSvgGen {
  const $AssetSvgGen();

  $AssetSvgIconGen get icon => const $AssetSvgIconGen();
}

class $AssetImgFoodGen {
  const $AssetImgFoodGen();

  /// File path: asset/img/food/ddeok_bok_gi.jpg
  AssetGenImage get ddeokBokGi =>
      const AssetGenImage('asset/img/food/ddeok_bok_gi.jpg');

  /// File path: asset/img/food/pizza_ddeok_bok_gi.jpg
  AssetGenImage get pizzaDdeokBokGi =>
      const AssetGenImage('asset/img/food/pizza_ddeok_bok_gi.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [ddeokBokGi, pizzaDdeokBokGi];
}

class $AssetImgLogoGen {
  const $AssetImgLogoGen();

  /// File path: asset/img/logo/codefactory_logo.png
  AssetGenImage get codefactoryLogo =>
      const AssetGenImage('asset/img/logo/codefactory_logo.png');

  /// File path: asset/img/logo/logo.png
  AssetGenImage get logo => const AssetGenImage('asset/img/logo/logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [codefactoryLogo, logo];
}

class $AssetImgMiscGen {
  const $AssetImgMiscGen();

  /// File path: asset/img/misc/logo.png
  AssetGenImage get logo => const AssetGenImage('asset/img/misc/logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [logo];
}

class $AssetSvgIconGen {
  const $AssetSvgIconGen();

  /// File path: asset/svg/icon/home.svg
  String get home => 'asset/svg/icon/home.svg';

  /// File path: asset/svg/icon/orders.svg
  String get orders => 'asset/svg/icon/orders.svg';

  /// File path: asset/svg/icon/profile.svg
  String get profile => 'asset/svg/icon/profile.svg';

  /// File path: asset/svg/icon/search.svg
  String get search => 'asset/svg/icon/search.svg';

  /// List of all assets
  List<String> get values => [home, orders, profile, search];
}

class Assets {
  Assets._();

  static const $AssetImgGen img = $AssetImgGen();
  static const $AssetRiveGen rive = $AssetRiveGen();
  static const $AssetSvgGen svg = $AssetSvgGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
