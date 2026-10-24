import 'package:flutter/cupertino.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_values.dart';

class DotIndicator  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppWidth.w5,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _indicatorDot(),
        _indicatorDot(),
        _indicatorDot(isActive: true),
      ],
    );
  }

    Widget _indicatorDot({bool isActive = false}) {
    return Container(
    width: isActive ?AppWidth.w34 : AppWidth.w6,
    height: AppHeight.h6,
    decoration: const BoxDecoration(
    color: AppColors.white,
    shape: BoxShape.circle,
    ),
    );
    }





}