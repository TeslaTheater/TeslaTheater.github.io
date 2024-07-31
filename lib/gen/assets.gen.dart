/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/appletvplus.svg
  SvgGenImage get appletvplus =>
      const SvgGenImage('assets/icons/appletvplus.svg');

  /// File path: assets/icons/artetv.svg
  SvgGenImage get artetv => const SvgGenImage('assets/icons/artetv.svg');

  /// File path: assets/icons/disneyplus.svg
  SvgGenImage get disneyplus =>
      const SvgGenImage('assets/icons/disneyplus.svg');

  /// File path: assets/icons/francetv.svg
  SvgGenImage get francetv => const SvgGenImage('assets/icons/francetv.svg');

  /// File path: assets/icons/hbo.svg
  SvgGenImage get hbo => const SvgGenImage('assets/icons/hbo.svg');

  /// File path: assets/icons/max.svg
  SvgGenImage get max => const SvgGenImage('assets/icons/max.svg');

  /// File path: assets/icons/mycanal.svg
  SvgGenImage get mycanal => const SvgGenImage('assets/icons/mycanal.svg');

  /// File path: assets/icons/netflix.svg
  SvgGenImage get netflix => const SvgGenImage('assets/icons/netflix.svg');

  /// File path: assets/icons/orangetv.svg
  SvgGenImage get orangetv => const SvgGenImage('assets/icons/orangetv.svg');

  /// File path: assets/icons/primevideo.svg
  SvgGenImage get primevideo =>
      const SvgGenImage('assets/icons/primevideo.svg');

  /// File path: assets/icons/sfrplay.svg
  SvgGenImage get sfrplay => const SvgGenImage('assets/icons/sfrplay.svg');

  /// File path: assets/icons/tesla.svg
  SvgGenImage get tesla => const SvgGenImage('assets/icons/tesla.svg');

  /// File path: assets/icons/youtube.svg
  SvgGenImage get youtube => const SvgGenImage('assets/icons/youtube.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        appletvplus,
        artetv,
        disneyplus,
        francetv,
        hbo,
        max,
        mycanal,
        netflix,
        orangetv,
        primevideo,
        sfrplay,
        tesla,
        youtube
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final BytesLoader loader;
    if (_isVecFormat) {
      loader = AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
