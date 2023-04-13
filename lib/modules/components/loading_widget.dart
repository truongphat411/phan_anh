import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class LoadingWidget extends StatelessWidget {
  final bool isImage;

  const LoadingWidget({super.key, this.isImage = false});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(seconds: 10),
      builder: (context, value, child) => Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(ColorSelect.mainColor)
        ),
      ),
    );
  }
}
