import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/app/routes/routes.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/common/widgets/dropdown_bottom_sheet/common_dropdown_bottom_sheet.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/controller/sign_up_status_controller.dart';

class SubmitValidIdVerification extends StatefulWidget {
  const SubmitValidIdVerification({super.key});

  @override
  State<SubmitValidIdVerification> createState() =>
      _SubmitValidIdVerificationState();
}

class _SubmitValidIdVerificationState extends State<SubmitValidIdVerification> {
  final SignUpStatusController controller = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchMerchantKyc();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        body: Obx(
          () => controller.isKycLoading.value
              ? CommonLoading()
              : LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              Container(
                                color: const Color(0xFF2C874F),
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    SizedBox(height: 80.h),
                                    Image.asset(
                                      PngAssets.authIdVerificationImage,
                                      width: 300.w,
                                    ),
                                    SizedBox(height: 80.h),
                                  ],
                                ),
                              ),

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
                                        Image.asset(
                                          PngAssets.appLogo,
                                          width: 100.w,
                                        ),
                                        SizedBox(height: 20.h),
                                        Text(
                                          "Submit a Valid ID for Verification",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 22.sp,
                                            color: AppColors.lightTextPrimary,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Text(
                                          "Please upload a valid government-issued ID for verification.",
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
                                          text: "Choose ID Type",
                                          onPressed: () {
                                            Get.bottomSheet(
                                              CommonDropdownBottomSheet(
                                                title: "Select ID Type",
                                                notFoundText:
                                                    "Verification Type Not Found",
                                                dropdownItems: controller
                                                    .merchantKycList
                                                    .map(
                                                      (item) =>
                                                          item.name.toString(),
                                                    )
                                                    .toList(),
                                                height: 400,
                                                selectedItem:
                                                    controller.typeName,
                                                onValueSelected: (value) {
                                                  controller.typeName.value =
                                                      value;
                                                  final selectedKyc = controller
                                                      .merchantKycList
                                                      .firstWhere(
                                                        (item) =>
                                                            item.name == value,
                                                      );

                                                  if (selectedKyc.fields !=
                                                      null) {
                                                    Future.delayed(
                                                      const Duration(
                                                        milliseconds: 200,
                                                      ),
                                                      () {
                                                        Get.toNamed(
                                                          BaseRoute
                                                              .authIdVerification,
                                                          arguments: {
                                                            "fields":
                                                                selectedKyc
                                                                    .fields,
                                                            "kyc_id":
                                                                selectedKyc.id
                                                                    .toString(),
                                                          },
                                                        );
                                                      },
                                                    );
                                                  }
                                                },
                                              ),
                                            );
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
                    );
                  },
                ),
        ),
      ),
    );
  }
}
