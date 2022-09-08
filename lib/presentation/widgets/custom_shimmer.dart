import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test_weather_app/presentation/theme/app_colors.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({Key? key, required this.child, this.isLoading = false}) : super(key: key);

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: Shimmer.fromColors(
        baseColor: AppColors.lightGrey,
        highlightColor: AppColors.primaryColor,
        child: child,
      ),
    );
  }
}
