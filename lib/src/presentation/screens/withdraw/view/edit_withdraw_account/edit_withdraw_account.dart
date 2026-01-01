import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/common/widgets/text_field/common_text_field.dart';
import 'package:qunzo_merchant/src/presentation/screens/withdraw/controller/edit_withdraw_account_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/withdraw/model/withdraw_account_model.dart';

class EditWithdrawAccount extends StatefulWidget {
  final Accounts account;

  const EditWithdrawAccount({super.key, required this.account});

  @override
  State<EditWithdrawAccount> createState() => _EditWithdrawAccountState();
}

class _EditWithdrawAccountState extends State<EditWithdrawAccount> {
  final EditWithdrawAccountController controller = Get.put(
    EditWithdrawAccountController(),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initializeFields(widget.account);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      appBar: CommonDefaultAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              CommonAppBar(title: localization!.editWithdrawAccountScreenTitle),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 18),
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localization.editWithdrawAccountScreenHeader,
                        style: TextStyle(
                          letterSpacing: 0,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: AppColors.lightTextPrimary,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              Column(
                                children: [
                                  CommonTextField(
                                    controller: controller.methodNameController,
                                    labelText: localization
                                        .editWithdrawAccountScreenMethodNameLabel,
                                    backgroundColor: AppColors.transparent,
                                  ),
                                  Obx(
                                    () => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20),
                                        ...controller
                                            .dynamicFieldControllers
                                            .entries
                                            .map((entry) {
                                              final fieldName = entry.key;
                                              final fieldData = entry.value;

                                              final fieldController =
                                                  fieldData['controller']
                                                      as TextEditingController;
                                              final type =
                                                  fieldData['type'] as String;
                                              final existingValue =
                                                  fieldData['value'] as String;
                                              final isTextArea =
                                                  type == 'textarea';
                                              final isFile = type == 'file';

                                              return Column(
                                                children: [
                                                  isFile
                                                      ? _buildUploadSection(
                                                          title: fieldName,
                                                          fieldName: fieldName,
                                                          existingValue:
                                                              existingValue,
                                                        )
                                                      : CommonTextField(
                                                          backgroundColor:
                                                              AppColors
                                                                  .transparent,
                                                          labelText: fieldName,
                                                          controller:
                                                              fieldController,
                                                          maxLine: isTextArea
                                                              ? 4
                                                              : 1,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                        ),
                                                  const SizedBox(height: 20),
                                                ],
                                              );
                                            }),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        controller
                                            .dynamicFieldControllers
                                            .isEmpty
                                        ? 30
                                        : 20,
                                  ),
                                  CommonButton(
                                    onPressed: () =>
                                        controller.updateWithdrawAccount(
                                          accountId: widget.account.id
                                              .toString(),
                                        ),
                                    width: double.infinity,
                                    text: localization
                                        .editWithdrawAccountScreenUpdateButton,
                                  ),
                                ],
                              ),
                              SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () => Visibility(
              visible: controller.isLoading.value,
              child: CommonLoading(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadSection({
    required String title,
    required String fieldName,
    String? existingValue,
  }) {
    return Obx(() {
      final selectedImage = controller.selectedImages[fieldName];
      final hasExistingValue =
          existingValue != null &&
          existingValue.isNotEmpty &&
          existingValue.toLowerCase() != 'null';

      return GestureDetector(
        onTap: () {
          controller.pickImage(fieldName, image_picker.ImageSource.gallery);
        },
        child: Container(
          width: double.infinity,
          height: selectedImage != null || hasExistingValue ? 120 : 80,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: selectedImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    selectedImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                )
              : hasExistingValue
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    existingValue,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 40,
                        color: AppColors.lightTextTertiary,
                      ),
                    ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return CommonLoading();
                    },
                  ),
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      PngAssets.attachFileTwo,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          PngAssets.uploadCommonIcon,
                          width: 18,
                          fit: BoxFit.contain,
                          color: AppColors.lightTextTertiary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: AppColors.lightTextTertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      );
    });
  }
}
