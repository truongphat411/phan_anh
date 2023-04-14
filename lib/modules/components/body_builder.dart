import 'package:flutter/material.dart';
import 'package:phan_anh/utils/utils.dart';
import '../../services/services.dart';
import '../modules.dart';

class BodyBuilder extends StatelessWidget {
  final APIRequestStatus apiRequestStatus;
  final Widget child;
  final Function? reload;

  const BodyBuilder(
      {Key? key,
      required this.apiRequestStatus,
      required this.child,
      this.reload})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    switch (apiRequestStatus) {
      case APIRequestStatus.loading:
        return const LoadingWidget();
      case APIRequestStatus.error:
        return const LoadingWidget();
      case APIRequestStatus.loaded:
        return child;
      default:
        return const LoadingWidget();
    }
  }
}
