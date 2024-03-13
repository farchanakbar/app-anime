import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class LoadingItem extends StatelessWidget {
  const LoadingItem({super.key, required this.data});

  final Widget data;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.height,
      height: Get.width,
      child: Shimmer.fromColors(
        baseColor: Colors.white70,
        highlightColor: Colors.grey.shade200,
        child: data,
      ),
    );
  }
}
