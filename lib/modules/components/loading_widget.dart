import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class LoadingWidget extends StatelessWidget {
  final bool isImage;

  const LoadingWidget({super.key, this.isImage = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(ColorSelect.mainColor)
      ),
    );
  }
}
