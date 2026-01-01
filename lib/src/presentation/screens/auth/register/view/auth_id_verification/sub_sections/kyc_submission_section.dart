import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/app/routes/routes.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_icon_button.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/controller/auth_id_verification_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/model/merchant_kyc_model.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/view/auth_id_verification/sub_sections/back_camera_capture.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/view/auth_id_verification/sub_sections/camera_type_section.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/view/auth_id_verification/sub_sections/file_type_section.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/view/auth_id_verification/sub_sections/front_camera_capture.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/view/auth_id_verification/sub_sections/front_camera_type_section.dart';
import 'package:qunzo_merchant/src/presentation/widgets/dynamic_attachment_preview.dart';

class KycSubmissionSection extends StatefulWidget {
  const KycSubmissionSection({super.key});

  @override
  State<KycSubmissionSection> createState() => _KycSubmissionSectionState();
}

class _KycSubmissionSectionState extends State<KycSubmissionSection> {
  final AuthIdVerificationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        controller.currentFieldIndex.value = 0;
        controller.fields.clear();
        controller.fieldFiles.clear();
        Get.toNamed(
          BaseRoute.signUpStatus,
          arguments: {"is_login_state": true},
        );
      },
      child: Scaffold(
        appBar: CommonDefaultAppBar(),
        body: Stack(
          children: [
            Obx(() {
              return Column(
                children: [
                  CommonAppBar(
                    title: "ID Verification",
                    isBackLogicApply: true,
                    backLogicFunction: () {
                      controller.currentFieldIndex.value = 0;
                      controller.fields.clear();
                      controller.fieldFiles.clear();
                      Get.toNamed(
                        BaseRoute.signUpStatus,
                        arguments: {"is_login_state": true},
                      );
                    },
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.fields.length,
                              itemBuilder: (context, index) {
                                final field = controller.fields[index];
                                final file =
                                    controller.fieldFiles[field.name ?? ""];

                                if (file == null) {
                                  return const SizedBox.shrink();
                                }

                                return Column(
                                  children: [
                                    _buildFieldWidget(
                                      field,
                                      context,
                                      index,
                                      file,
                                    ),
                                    const SizedBox(height: 30),
                                  ],
                                );
                              },
                            ),
                            _buildActionButton(),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
            Obx(
              () => Visibility(
                visible: controller.isLoading.value,
                child: CommonLoading(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    bool allFieldsProcessed = true;
    Fields? nextUnprocessedField;

    for (var field in controller.fields) {
      if (!controller.isFieldProcessed(field.name ?? "")) {
        allFieldsProcessed = false;
        nextUnprocessedField ??= field;
      }
    }

    return CommonButton(
      width: double.infinity,
      text: allFieldsProcessed ? "Submit" : "Next",
      onPressed: () async {
        if (allFieldsProcessed) {
          await controller.submitIdVerification();
          return;
        }

        if (nextUnprocessedField != null) {
          final result = await _navigateToFieldScreen(nextUnprocessedField);

          if (result != null) {
            controller.fieldFiles[nextUnprocessedField.name ?? ""] = result;

            controller.currentFieldIndex.value = controller.fields.indexOf(
              nextUnprocessedField,
            );
          }
        }
      },
    );
  }

  Future<dynamic> _navigateToFieldScreen(Fields field) async {
    switch (field.type?.toLowerCase()) {
      case 'camera':
        return await Get.to(() => CameraTypeSection(field: field));
      case 'file':
        return await Get.to(() => FileTypeSection(field: field));
      case 'front_camera':
        return await Get.to(() => FrontCameraTypeSection(field: field));
      default:
        return null;
    }
  }

  Widget _buildFieldWidget(
    Fields field,
    BuildContext context,
    int fieldIndex,
    dynamic file,
  ) {
    String name = field.name ?? "";
    String validation = field.validation ?? "";
    String type = field.type ?? "";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        letterSpacing: 0,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: AppColors.lightTextPrimary.withValues(
                          alpha: 0.60,
                        ),
                      ),
                    ),
                  ),
                  if (validation == "required")
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: const Text(
                        " *",
                        style: TextStyle(
                          letterSpacing: 0,
                          color: AppColors.error,
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            CommonIconButton(
              onPressed: () async {
                if (type == "file") {
                  await controller.pickFile(field.name ?? "");
                } else if (type == "camera") {
                  final result = await Get.to(
                    () => BackCameraCapture(fieldName: field.name ?? ""),
                  );
                  if (result != null) {
                    controller.fieldFiles[field.name ?? ""] = result;
                  }
                } else if (type == "front_camera") {
                  final result = await Get.to(
                    () => FrontCameraCapture(fieldName: field.name ?? ""),
                  );
                  if (result != null) {
                    controller.fieldFiles[field.name ?? ""] = result;
                  }
                }
              },
              backgroundColor: AppColors.lightPrimary.withValues(alpha: 0.06),
              borderColor: AppColors.lightPrimary.withValues(alpha: 0.50),
              borderWidth: 2,
              textColor: AppColors.lightTextPrimary,
              width: type == "file" ? 120 : 95,
              height: 36,
              text: type == "file" ? "Re Upload" : "Retake",
              icon: type == "file"
                  ? PngAssets.reUploadIcon
                  : PngAssets.reTechIcon,
              iconWidth: 18,
              iconHeight: 18,
              iconAndTextSpace: 5,
              iconColor: AppColors.lightTextPrimary.withValues(alpha: 0.80),
              fontSize: 15,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                final decodedImage = Image.file(file);
                decodedImage.image
                    .resolve(const ImageConfiguration())
                    .addListener(
                      ImageStreamListener((ImageInfo info, bool _) {
                        final imageHeight = info.image.height.toDouble();
                        final imageWidth = info.image.width.toDouble();

                        final screenWidth =
                            MediaQuery.of(context).size.width - 36;
                        final scaledHeight =
                            (imageHeight / imageWidth) * screenWidth;
                        final bottomExtraHeight = 50.0;

                        Get.bottomSheet(
                          DynamicAttachmentPreview(
                            file: file,
                            scaledHeight: scaledHeight,
                            bottomExtraHeight: bottomExtraHeight,
                          ),
                          isScrollControlled: true,
                          enableDrag: true,
                          backgroundColor: AppColors.transparent,
                        );
                      }),
                    );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  file,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
