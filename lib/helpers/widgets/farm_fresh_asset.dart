import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FarmFreshAsset extends StatelessWidget {
  const FarmFreshAsset({
    super.key,
    required this.image,
    this.color,
    this.width,
    this.height,
    this.svg = true,
  });
  final String image;
  final Color? color;
  final double? width;
  final double? height;
  final bool svg;

  @override
  Widget build(BuildContext context) {
    return svg
        ? SvgPicture.asset(
            image,
            fit: BoxFit.cover,
            width: width,
            height: height,
            colorFilter: color == null
                ? null
                : ColorFilter.mode(
                    color ?? Colors.transparent, BlendMode.srcIn),
          )
        : Image.asset(
            image,
            fit: BoxFit.fitHeight,
            width: width,
            height: height,
            color: color,
          );
  }
}
