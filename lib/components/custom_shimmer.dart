import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final ShapeBorder? shapeBorder;

  const MyShimmer.rectangular({Key? key, this.width = double.infinity, this.height, this.shapeBorder = const RoundedRectangleBorder()}) : super(key: key);

  const MyShimmer.circular({Key? key, this.width, this.height, this.shapeBorder = const CircleBorder()}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: shapeBorder!,
          ),
        ),
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!);
  }
}
