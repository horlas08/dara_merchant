import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset(PngAssets.noDataFoundImage, width: 130.w));
  }
}
