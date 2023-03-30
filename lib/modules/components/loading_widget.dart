import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final bool isImage;

  const LoadingWidget({super.key, this.isImage = false});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.blue,
      ),
    );
  }
}
