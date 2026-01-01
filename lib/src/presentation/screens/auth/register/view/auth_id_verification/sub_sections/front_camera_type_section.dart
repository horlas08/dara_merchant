import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/controller/auth_id_verification_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/model/merchant_kyc_model.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/view/auth_id_verification/sub_sections/front_camera_capture.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/view/auth_id_verification/sub_sections/kyc_submission_section.dart';

class FrontCameraTypeSection extends StatelessWidget {
  final Fields field;

  const FrontCameraTypeSection({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    final AuthIdVerificationController controller = Get.find();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Container(
                    color: Color(0xFF2C874F),
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(height: 80.h),
                        Image.asset(
                          PngAssets.authFrontCameraTypeImage,
                          width: 300.w,
                        ),
                        SizedBox(height: 80.h),
                        Expanded(
                          child: Container(
                            color: Color(0xFF2C874F),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: 18.w,
                                vertical: 30.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.r),
                                  topRight: Radius.circular(30.r),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(PngAssets.appLogo, width: 100.w),
                                  SizedBox(height: 20.h),
                                  Text(
                                    field.name ?? "N/A",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      color: AppColors.lightTextPrimary,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    field.instructions ?? "N/A",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: AppColors.lightTextPrimary
                                          .withValues(alpha: 0.30),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 30.h),
                                  CommonButton(
                                    text: "Launch Camera",
                                    onPressed: () async {
                                      final file = await Get.to(
                                        () => FrontCameraCapture(
                                          fieldName: field.name ?? "",
                                        ),
                                      );
                                      if (file != null) {
                                        controller.fieldFiles[field.name ??
                                                ""] =
                                            file;
                                        Get.to(
                                          () => const KycSubmissionSection(),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
