import 'package:flutter/material.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';

class CommonDefaultAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CommonDefaultAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.lightBackground,
      surfaceTintColor: AppColors.lightBackground,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(0);
}
